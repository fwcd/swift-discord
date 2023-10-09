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

/// Struct that represents shard information.
/// Used when a client is doing manual sharding.
public struct DiscordShardInformation {
    /// Sharding errors.
    public enum ShardingError : Error {
        /// Thrown when a shardRange's end is greater than or equal to the total number of shards.
        /// A range should always be `n..<m` where m is <= the total number of shards.
        case invalidShardRange
    }

    // MARK: Properties

    /// The range of shards in this client.
    public let shardRange: CountableRange<Int>

    /// The total number of shards this bot will have.
    public let totalShards: Int

    // MARK: Initializers

    ///
    /// Creates a new DiscordShardInformation telling the client the range of shards that it should spawn.
    ///
    public init(shardRange: CountableRange<Int>, totalShards: Int) throws {
        guard shardRange.first! >= 0 && shardRange.last! < totalShards else { throw ShardingError.invalidShardRange }

        self.shardRange = shardRange
        self.totalShards = totalShards
    }
}
