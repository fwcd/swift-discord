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

import class Dispatch.DispatchSemaphore
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import Logging

fileprivate let logger = Logger(label: "DiscordGuild")

/// Represents a Guild.
public struct DiscordGuild: CustomStringConvertible, Identifiable, Codable, Hashable {
    public enum CodingKeys: String, CodingKey {
        case id
        case channels
        case defaultMessageNotifications = "default_message_notifications"
        case widgetEnabled = "widget_enabled"
        case widgetChannelId = "widget_channel_id"
        case emojis
        case icon
        case banner
        case large
        case memberCount = "member_count"
        case mfaLevel = "mfa_level"
        case name
        case ownerId = "owner_id"
        case presences
        case region
        case roles
        case splash
        case verificationLevel = "verification_level"
        case voiceStates = "voice_states"
        case unavailable
        case joinedAt = "joined_at"
        case members
    }

    // MARK: Properties

    /// The snowflake id of the guild.
    public var id: GuildID

    /// Whether or not this a "large" guild.
    public var large: Bool?

    /// The date the user joined the guild.
    public var joinedAt: Date?

    /// The base64 encoded splash image.
    public var splash: String?

    /// Whether this guild is unavailable.
    public var unavailable: Bool?

    /// - returns: A description of this guild
    public var description: String { "DiscordGuild(name: \(name.map { "\"\($0)\"" } ?? "nil"))" }

    /// A dictionary of this guild's members. The key is the snowflake id of the user.
    public var members: DiscordIDDictionary<DiscordGuildMember>

    /// A dictionary of this guild's channels. The key is the snowflake id of the channel.
    public var channels: DiscordIDDictionary<DiscordChannel>

    /// A dictionary of this guild's emojis. The key is the snowflake id of the emoji.
    public var emojis: DiscordIDDictionary<DiscordEmoji>

    /// The number of members in this guild.
    ///
    /// *This number might not be the actual number of users in the `members` field.*
    public var memberCount: Int?

    /// A `DiscordLazyDictionary` of presences. The key is the snowflake id of the user.
    public var presences: DiscordIDDictionary<DiscordPresence>

    /// A dictionary of this guild's roles. The key is the snowflake id of the role.
    public var roles: DiscordIDDictionary<DiscordRole>

    /// A dictionary of this guild's current voice states.
    /// The key is the snowflake id of the user for this voice
    /// state.
    public var voiceStates: DiscordIDDictionary<DiscordVoiceState>

    /// The default message notification setting.
    public var defaultMessageNotifications: Int?

    /// The snowflake id of the embed channel for this guild.
    public var widgetChannelId: ChannelID?

    /// Whether this guild has embed enabled.
    public var widgetEnabled: Bool?

    /// The base64 encoded icon image for this guild.
    public var icon: String?

    /// The base64 encoded banner image for this guild.
    public var banner: String?

    /// The multi-factor authentication level for this guild.
    public var mfaLevel: Int?

    /// The name of this guild.
    public var name: String?

    /// The snowflake id of this guild's owner.
    public var ownerId: UserID?

    /// The region this guild is in.
    public var region: String?

    /// The verification level a member of this guild must have to join.
    public var verificationLevel: Int?

    // MARK: Methods

    ///
    /// Gets the roles that this member has on this guild.
    ///
    /// - parameter member: The member whose roles we are getting.
    /// - returns: An array containing the roles they have.
    ///
    public func roles(for member: DiscordGuildMember) -> [DiscordRole] {
        var roles = [DiscordRole]()

        if let everyone = self.roles[id] {
            roles.append(everyone)
        }

        return roles + self.roles.filter { member.roleIds.contains($0.key) }.map(\.value)
    }

    func shardNumber(assuming numOfShards: Int) -> Int {
        return Int(id.rawValue >> 22) % numOfShards
    }

    // Used to update a guild from a guildUpdate event
    mutating func merge(update: DiscordGuild) {
        if let defaultMessageNotifications = update.defaultMessageNotifications {
            self.defaultMessageNotifications = defaultMessageNotifications
        }

        if let widgetChannelId = update.widgetChannelId {
            self.widgetChannelId = widgetChannelId
        }

        if let widgetEnabled = update.widgetEnabled {
            self.widgetEnabled = widgetEnabled
        }

        if let icon = update.icon {
            self.icon = icon
        }

        if let banner = update.banner {
            self.banner = banner
        }

        if let memberCount = update.memberCount {
            self.memberCount = memberCount
        }

        if let mfaLevel = update.mfaLevel {
            self.mfaLevel = mfaLevel
        }

        if let name = update.name {
            self.name = name
        }

        if let ownerId = update.ownerId {
            self.ownerId = ownerId
        }

        if let region = update.region {
            self.region = region
        }

        if let verificationLevel = update.verificationLevel {
            self.verificationLevel = verificationLevel
        }
    }
}
