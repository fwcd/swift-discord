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

import Foundation

/// Represents the reason a gateway was closed.
public struct DiscordGatewayCloseReason: RawRepresentable, Codable, Hashable {
    public var rawValue: Int

    /// We don't quite know why the gateway closed.
    public static let unknown = DiscordGatewayCloseReason(rawValue: 0)
    /// The gateway closed because the network dropped.
    public static let noNetwork = DiscordGatewayCloseReason(rawValue: 50)
    /// The gateway closed from a normal WebSocket close event.
    public static let normal = DiscordGatewayCloseReason(rawValue: 1000)
    /// The endpoint is going away.
    public static let goingAway = DiscordGatewayCloseReason(rawValue: 1001)
    /// Something went wrong, but we aren't quite sure either.
    public static let unknownError = DiscordGatewayCloseReason(rawValue: 4000)
    /// Discord got an opcode is doesn't recognize.
    public static let unknownOpcode = DiscordGatewayCloseReason(rawValue: 4001)
    /// We sent a payload Discord doesn't know what to do with.
    public static let decodeError = DiscordGatewayCloseReason(rawValue: 4002)
    /// We tried to send stuff before we were authenticated.
    public static let notAuthenticated = DiscordGatewayCloseReason(rawValue: 4003)
    /// We failed to authenticate with Discord.
    public static let authenticationFailed = DiscordGatewayCloseReason(rawValue: 4004)
    /// We tried to authenticate twice.
    public static let alreadyAuthenticated = DiscordGatewayCloseReason(rawValue: 4005)
    /// We sent a bad sequence number when trying to resume.
    public static let invalidSequence = DiscordGatewayCloseReason(rawValue: 4007)
    /// We sent messages too fast.
    public static let rateLimited = DiscordGatewayCloseReason(rawValue: 4008)
    /// Our session timed out.
    public static let sessionTimeout = DiscordGatewayCloseReason(rawValue: 4009)
    /// We sent an invalid shard when identifing.
    public static let invalidShard = DiscordGatewayCloseReason(rawValue: 4010)
    /// We sent a protocol Discord doesn't recognize.
    public static let unknownProtocol = DiscordGatewayCloseReason(rawValue: 4012)
    /// We got disconnected.
    public static let disconnected = DiscordGatewayCloseReason(rawValue: 4014)
    /// The voice server crashed.
    public static let voiceServerCrash = DiscordGatewayCloseReason(rawValue: 4015)
    /// We sent an encryption mode Discord doesn't know.
    public static let unknownEncryptionMode = DiscordGatewayCloseReason(rawValue: 4016)

    // MARK: Initializers

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    init?(error: Error?) {
        guard let error = error else { return nil }

        self.init(rawValue: (error as NSError).code)
    }
}
