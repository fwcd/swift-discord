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
import Logging
import NIO

fileprivate let logger = Logger(label: "DiscordSharding")

///
/// The shard manager is responsible for a client's shards. It decides when a client is considered connected.
/// Connected being when all shards have recieved a ready event and are receiving events from the gateway. It also
/// decides when a client has fully disconnected. Disconnected being when all shards have closed.
///
public class DiscordShardManager: DiscordShardDelegate, Lockable {
    // MARK: Properties

    /// - returns: The shard with num `n`
    public subscript(n: Int) -> DiscordShard {
        return get(shards).first(where: { $0.shardNum == n })!
    }

    /// The token for the user.
    public var token: DiscordToken { delegate!.token }

    /// The individual shards.
    public var shards = [DiscordShard]()

    let lock = DispatchSemaphore(value: 1)

    private var closed = false
    private var closedShards = 0
    private var connectedShards = 0
    private weak var delegate: DiscordShardManagerDelegate?

    init(delegate: DiscordShardManagerDelegate) {
        self.delegate = delegate
    }

    // MARK: Methods

    private func cleanUp() {
        protected {
            shards.removeAll()
            closedShards = 0
            connectedShards = 0
        }
    }

    ///
    /// Connects all shards to the gateway.
    ///
    /// **Note** This method is an async method.
    ///
    public func connect() {
        protected { closed = false }
        let shards = get(self.shards)

        for (i, shard) in shards.enumerated() {
            let deadline = DispatchTime.now() +  Double(5 * i)
            DispatchQueue.global().asyncAfter(deadline: deadline) { [weak self, weak shard] in
                guard let this = self, this.get(!this.closed) else { return }
                shard?.connect()
            }
        }
    }

    ///
    /// Creates a new shard.
    ///
    /// - parameter delegate: The delegate for this shard.
    /// - parameter withShardNum: The shard number for the new shard.
    /// - parameter totalShards: The total number of shards.
    /// - returns: A new `DiscordShard`
    ///
    public func createShardWithDelegate(
        _ delegate: DiscordShardManagerDelegate,
        withShardNum shardNum: Int,
        totalShards: Int,
        intents: DiscordGatewayIntents,
        onloop: EventLoop
    ) -> DiscordShard {
        return DiscordEngine(
            delegate: self,
            shardNum: shardNum, 
            numShards: totalShards,
            intents: intents,
            onLoop: onloop
        )
    }

    ///
    /// Disconnects all shards.
    ///
    public func disconnect() {
        protected {
            closed = true

            for shard in shards {
                shard.disconnect()
            }
        }

        if get(connectedShards != shards.count) {
            // Still connecting, say we disconnected, since we never connected to begin with
            delegate?.shardManager(self, didDisconnectWithReason: .normal, closed: true)
        }
    }

    ///
    /// Use when you will have multiple shards spread across a few instances.
    ///
    /// - parameter withInfo: The information about this single shard.
    ///
    public func manuallyShatter(withInfo info: DiscordShardInformation, intents: DiscordGatewayIntents) {
        guard let delegate = self.delegate else { return }

        logger.debug("(verbose) Handling shard range \(info.shardRange)")

        cleanUp()

        protected {
            for shardNum in info.shardRange {
                shards.append(createShardWithDelegate(
                    delegate,
                    withShardNum: shardNum,
                    totalShards: info.totalShards,
                    intents: intents,
                    onloop: delegate.eventLoopGroup.next()
                ))
            }
        }
    }

    ///
    /// Sends a payload on the specified shard.
    ///
    /// - parameter payload: The payload to send.
    /// - parameter onShard: The shard to send the payload on.
    ///
    public func sendPayload(_ payload: DiscordGatewayCommand, onShard shard: Int) {
        self[shard].sendPayload(payload)
    }

    public func shard(_ shard: DiscordShard, didReceiveEvent event: DiscordDispatchEvent) {
        delegate?.shardManager(self, shouldHandleEvent: event)
    }

    public func shard(_ engine: DiscordShard, gotHello hello: DiscordGatewayHello) { }

    public func shardDidConnect(_ shard: DiscordShard) {
        logger.debug("(verbose) Shard #\(shard.shardNum), connected")

        protected { connectedShards += 1 }

        guard get(connectedShards == shards.count) else { return }

        delegate?.shardManager(self, didConnect: true)
    }

    public func shard(_ shard: DiscordShard, didDisconnectWithReason reason: DiscordGatewayCloseReason, closed: Bool) {
        logger.debug("(verbose) Shard #\(shard.shardNum), disconnected")

        protected { closedShards += 1 }

        guard get(closedShards == shards.count) else { return }

        delegate?.shardManager(self, didDisconnectWithReason: reason, closed: closed)
    }

    public func shard(_ shard: DiscordShard, shouldAttemptResuming reason: DiscordGatewayCloseReason, closed: Bool) -> Bool {
        delegate?.shardManager(self, shouldAttemptResuming: reason, closed: closed) ?? false
    }
}
