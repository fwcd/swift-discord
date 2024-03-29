// The MIT License (MIT)
// Copyright (c) 2016 Erik Little
// Copyright (c) 2021 fwcd

// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
// documentation files (the "Software"), to deal in the Software without restriction, including without
// limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
// Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
// Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
// BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
// ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.

import Dispatch
import Foundation
import Logging
import NIO
import WebSocketKit

fileprivate let logger = Logger(label: "DiscordWebSocketable")

/// Declares that a type will be capable of communicating with Discord's WebSockets
public protocol DiscordWebSocketable: AnyObject {
    /// MARK: Properties

    /// The url to connect to.
    var connectURL: String { get }

    /// The UUID for this WebSocketable.
    var connectUUID: UUID { get set }

    /// A description of this WebSocketable.
    var description: String { get }

    /// The queue WebSockets do their parsing on.
    var parseQueue: DispatchQueue { get }

    /// A reference to the underlying WebSocket.
    var webSocket: WebSocket? { get set }

    // MARK: Methods

    ///
    /// Attaches the WebSocket handlers that listen for text/connects/disconnects/etc
    ///
    /// Override if you need to provide custom handlers.
    ///
    func attachWebSocketHandlers()

    ///
    /// Starts the connection to the Discord gateway.
    ///
    func connect()

    ///
    /// Disconnects the engine. An `engine.disconnect` is fired on disconnection.
    ///
    func disconnect()

    ///
    /// Handles a close from the WebSocket.
    ///
    /// - parameter reason: The reason the socket closed.
    ///
    func handleClose(reason: DiscordGatewayCloseReason)
}

public extension DiscordWebSocketable where Self: DiscordGatewayable & DiscordEventLoopable {
    /// Default implementation.
    func attachWebSocketHandlers() {
        webSocket?.onText { [weak self] ws, text in
            guard let self else { return }

            logger.debug("\(self.description), Got text: \(text)")

            self.parseAndHandleGatewayMessage(text)
        }
        
        webSocket?.onClose.whenSuccess { [weak self] in
            guard let self else { return }
            
            let code = self.webSocket?.closeCode
            let reason = code.map { DiscordGatewayCloseReason(rawValue: Int(UInt16(webSocketErrorCode: $0))) } ?? .unknown

            logger.info("WebSocket closed with reason \(reason), \(self.description)")
            
            self.handleClose(reason: reason)
        }

        webSocket?.onClose.whenFailure { [weak self] err in
            guard let self else { return }

            logger.info("WebSocket errored: \(err), \(self.description);")

            self.handleClose(reason: .unknown)
        }
    }

    ///
    /// Starts the connection to the Discord gateway.
    ///
    func connect() {
        eventLoop.execute(self._connect)
    }

    private func _connect() {
        logger.info("Connecting to \(connectURL), \(description)")
        logger.info("Attaching WebSocket, shard: \(description)")

        let url = URL(string: connectURL)!
        let path = url.path.isEmpty ? "/" : url.path
        let query = url.query

        let future = WebSocket.connect(
            scheme: url.scheme ?? "wss",
            host: url.host!,
            port: url.port ?? 443,
            path: "\(path)\(query.map { "?\($0)" } ?? "")",
            configuration: .init(
                tlsConfiguration: .clientDefault,
                maxFrameSize: 1 << 31
            ),
            on: eventLoop
        ) { [weak self] ws in
            guard let self else { return }

            logger.info("WebSocket connected, shard: \(self.description)")

            self.webSocket = ws
            self.connectUUID = UUID()

            self.attachWebSocketHandlers()
            self.startHandshake()
        }
        
        future.whenFailure { [weak self] err in
            guard let self else { return }
            
            logger.info("WebSocket errored, closing: \(err), \(self.description)")
            
            self.handleClose(reason: .init(error: err) ?? .unknown)
        }
    }

    internal func closeWebSockets(fast: Bool = false) {
        logger.info("Closing WebSocket, shard: \(description)")

        guard !fast else {
            handleClose(reason: .unknown)

            return
        }

        let _ = webSocket?.close()
    }
}
