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

/// The delegate for a `DiscordShardManager`.
public protocol DiscordShardManagerDelegate : AnyObject, DiscordEventLoopGroupManager, DiscordTokenBearer {
    // MARK: Methods

    ///
    /// Signals that the manager has finished connecting.
    ///
    /// - parameter manager: The manager.
    /// - parameter didConnect: Should always be true.
    ///
    func shardManager(_ manager: DiscordShardManager, didConnect connected: Bool)

    ///
    /// Signals that the manager has disconnected.
    ///
    /// - parameter manager: The manager.
    /// - parameter didDisconnectWithReason: The reason why the manager disconnected.
    /// - parameter closed: Whether the socket was closed.
    ///
    func shardManager(_ manager: DiscordShardManager, didDisconnectWithReason reason: DiscordGatewayCloseReason, closed: Bool)

    ///
    /// Signals that the manager received an event. The client should handle this.
    ///
    /// - parameter manager: The manager.
    /// - parameter shouldHandleEvent: The event to be handled.
    ///
    func shardManager(_ manager: DiscordShardManager, shouldHandleEvent event: DiscordDispatchEvent)
}
