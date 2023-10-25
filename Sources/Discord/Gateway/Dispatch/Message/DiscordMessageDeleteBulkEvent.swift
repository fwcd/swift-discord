/// Sent when multiple messages are deleted at once.
public struct DiscordMessageDeleteBulkEvent: Codable {
    public enum CodingKeys: String, CodingKey {
        case ids
        case channelId = "channel_id"
        case guildId = "guild_id"
    }

    /// The ids of the messages.
    public var ids: [MessageID]
    /// The id of the channel.
    public var channelId: ChannelID
    /// The id of the guild.
    public var guildId: GuildID?
}
