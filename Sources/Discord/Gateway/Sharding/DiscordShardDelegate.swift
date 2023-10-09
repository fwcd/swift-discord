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

/// Declares that a type will be a shard's delegate.
public protocol DiscordShardDelegate: AnyObject, DiscordTokenBearer {
    ///
    /// Used by shards to signal that they have connected.
    ///
    /// - parameter shard: The shard that disconnected.
    ///
    func shardDidConnect(_ shard: DiscordShard)

    ///
    /// Used by shards to signal that they have disconnected
    ///
    /// - parameter shard: The shard that disconnected.
    /// - parameter reason: The reason why the shard disconnected.
    /// - parameter closed: Whether the connection was closed.
    ///
    func shard(_ shard: DiscordShard, didDisconnectWithReason reason: DiscordGatewayCloseReason, closed: Bool)

    ///
    /// Whether the shard should attempt resuming the connection.
    /// This was the classic behavior, which is now disabled by
    /// default to avoid accidentally spamming the gateway.
    ///
    /// - parameter shard: The shard that disconnected.
    /// - parameter reason: The reason why the shard disconnected.
    /// - parameter closed: Whether the connection was closed.
    /// 
    func shard(_ shard: DiscordShard, shouldAttemptResuming reason: DiscordGatewayCloseReason, closed: Bool) -> Bool

    ///
    /// Handles engine dispatch events. You shouldn't need to call this method directly.
    ///
    /// Override to provide custom engine dispatch functionality.
    ///
    /// - parameter engine: The engine that received the event.
    /// - parameter didReceiveEvent: The event that was received.
    ///
    func shard(_ engine: DiscordShard, didReceiveEvent event: DiscordDispatchEvent)

    ///
    /// Called when an engine handled a hello packet.
    ///
    /// - parameter engine: The engine that received the event.
    /// - gotHello: The hello data.
    ///
    func shard(_ engine: DiscordShard, gotHello hello: DiscordGatewayHello)
}
