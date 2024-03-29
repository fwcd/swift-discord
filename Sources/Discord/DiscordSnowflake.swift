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

/// The stored type of a Discord Snowflake ID
public struct Snowflake: RawRepresentable, Codable, Hashable, CustomStringConvertible, ExpressibleByIntegerLiteral, Comparable {
    /// Set this key to true on an encoder to encode Snowflakes as UInt64s instead of Strings.
    /// This will save space in binary encoders like binary plists, but will cause encoded JSON to be
    /// incompatible with Discord. Since JSON isn't a binary encoding, it won't save much space there anyways.
    public static let encodeAsUInt64 = CodingUserInfoKey(rawValue: "snowflakeAsUInt64")!

    /// The internal ID storage for a snowflake
    public let rawValue: UInt64

    /// CustomStrngConvertible conformance.
    public var description: String { String(rawValue) }

    /// RawRepresentable conformance.
    public init(rawValue: UInt64) {
        self.rawValue = rawValue
    }

    /// Initialize from a UInt64
    public init(_ rawValue: UInt64) {
        self.init(rawValue: rawValue)
    }

    /// Initialize from an integer literal.
    public init(integerLiteral rawValue: UInt64) {
        self.init(rawValue: rawValue)
    }

    /// Initialize from a string
    public init?(_ string: String) {
        guard let rawValue = UInt64(string) else { return nil }
        self.init(rawValue: rawValue)
    }

    /// Decodable implementation.
    public init(from decoder: Decoder) throws {
        do {
            let intForm = try UInt64(from: decoder)
            self.init(rawValue: intForm)
        } catch {
            guard let snowflake = Snowflake(try String(from: decoder)) else {
                let context = DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Failed to convert decoded string into a snowflake"
                )
                throw DecodingError.typeMismatch(Snowflake.self, context)
            }
            self = snowflake
        }
    }

    /// Encodable implementation.
    public func encode(to encoder: Encoder) throws {
        if encoder.userInfo[Snowflake.encodeAsUInt64] as? Bool ?? false {
            try self.rawValue.encode(to: encoder)
        } else {
            try self.description.encode(to: encoder)
        }
    }

    public static func <(lhs: Snowflake, rhs: Snowflake) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

// MARK: Snowflake Typealiases

/// A Snowflake ID representing a Guild
public typealias GuildID = Snowflake

/// A Snowflake ID representing a Channel
public typealias ChannelID = Snowflake

/// A Snowflake ID representing a User
public typealias UserID = Snowflake

/// A Snowflake ID representing a Role
public typealias RoleID = Snowflake

/// A Snowflake ID representing a Message
public typealias MessageID = Snowflake

/// A Snowflake ID representing a Webhook
public typealias WebhookID = Snowflake

/// A Snowflake ID representing a Permissions Overwrite
public typealias OverwriteID = Snowflake

/// A Snowflake ID representing an Emoji
public typealias EmojiID = Snowflake

/// A Snowflake ID representing an Integration
public typealias IntegrationID = Snowflake

/// A Snowflake ID representing an Attachment
public typealias AttachmentID = Snowflake

/// A Snowflake ID representing an Interaction
public typealias InteractionID = Snowflake

/// A Snowflake ID representing an Application
public typealias ApplicationID = Snowflake

/// A Snowflake ID representing a Slash Command
public typealias CommandID = Snowflake

// MARK: Extra snowflake information

extension Snowflake {
    /// Discord's epoch
    public static let epoch = Date(timeIntervalSince1970: 1420070400)

    /// Time when snowflake was created
    public var timestamp: Date { return Date(timeInterval: Double((rawValue & 0xFFFFFFFFFFC00000) >> 22) / 1000, since: Snowflake.epoch) }

    /// Discord's internal worker ID that generated this snowflake
    public var workerId: Int { return Int((rawValue & 0x3E0000) >> 17) }

    /// Discord's internal process under worker that generated this snowflake
    public var processId: Int { return Int((rawValue & 0x1F000) >> 12) }

    /// Number of generated ID's for the process
    public var numberInProcess: Int { return Int(rawValue & 0xFFF) }

    ///
    /// Creates a fake snowflake that would have been created at the specified date
    /// Useful for things like the messages before/after/around endpoint
    ///
    /// - parameter date: The date to make a fake snowflake for
    /// - returns: A fake snowflake with the specified date, or nil if the specified date will not make a valid snowflake
    ///
    public static func fakeSnowflake(date: Date) -> Snowflake? {
        let intervalSinceDiscordEpoch = Int64(date.timeIntervalSince(Snowflake.epoch) * 1000)
        guard intervalSinceDiscordEpoch > 0 else { return nil }
        guard intervalSinceDiscordEpoch < (1 << 41) else { return nil }
        return Snowflake(UInt64(intervalSinceDiscordEpoch) << 22)
    }
}
