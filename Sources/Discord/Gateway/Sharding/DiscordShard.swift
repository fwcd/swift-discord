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

import NIO

/// Protocol that represents a sharded gateway connection. This is the top-level protocol for
/// `DiscordEngine`
public protocol DiscordShard: DiscordWebSocketable, DiscordGatewayable, DiscordEventLoopable {
    // MARK: Properties

    /// Whether this shard is connected to the gateway
    var connected: Bool { get }

    /// A reference to the client this engine is associated with.
    var delegate: DiscordShardDelegate? { get }

    /// The total number of shards.
    var numShards: Int { get }

    /// This shard's number.
    var shardNum: Int { get }

    // MARK: Initializers

    ///
    /// The main initializer.
    ///
    /// - parameter client: The client this engine should be associated with.
    ///
    init(delegate: DiscordShardDelegate, shardNum: Int, numShards: Int, intents: DiscordGatewayIntents, onLoop: EventLoop)
}
