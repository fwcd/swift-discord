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

import Derive

/// Represents a regular gateway opcode.
@DeriveCustomStringConvertible
public struct DiscordGatewayOpcode: RawRepresentable, Codable, Hashable {
    public var rawValue: Int

    public static let dispatch = DiscordGatewayOpcode(rawValue: 0)
    public static let heartbeat = DiscordGatewayOpcode(rawValue: 1)
    public static let identify = DiscordGatewayOpcode(rawValue: 2)
    public static let presenceUpdate = DiscordGatewayOpcode(rawValue: 3)
    public static let voiceStatusUpdate = DiscordGatewayOpcode(rawValue: 4)
    public static let voiceServerPing = DiscordGatewayOpcode(rawValue: 5)
    public static let resume = DiscordGatewayOpcode(rawValue: 6)
    public static let reconnect = DiscordGatewayOpcode(rawValue: 7)
    public static let requestGuildMembers = DiscordGatewayOpcode(rawValue: 8)
    public static let invalidSession = DiscordGatewayOpcode(rawValue: 9)
    public static let hello = DiscordGatewayOpcode(rawValue: 10)
    public static let heartbeatAck = DiscordGatewayOpcode(rawValue: 11)

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
