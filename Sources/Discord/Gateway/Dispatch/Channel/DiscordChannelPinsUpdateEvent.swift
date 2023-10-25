import Foundation

/// Sent when a message is pinned/unpinned in a text channel. Not sent if the
/// pinned message is deleted.
public struct DiscordChannelPinsUpdateEvent: Codable {
    public enum CodingKeys: String, CodingKey {
        case guildId = "guild_id"
        case channelId = "channel_id"
        case lastPinTimestamp = "last_pin_timestamp"
    }

    public var guildId: GuildID?
    public var channelId: ChannelID
    public var lastPinTimestamp: Date?
}
