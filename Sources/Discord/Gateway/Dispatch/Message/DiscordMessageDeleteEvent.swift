/// Sent when a message is deleted.
public struct DiscordMessageDeleteEvent: Codable {
    public enum CodingKeys: String, CodingKey {
        case id
        case channelId = "channel_id"
        case guildId = "guild_id"
    }

    /// The id of the message.
    public var id: MessageID
    /// The id of the channel.
    public var channelId: ChannelID
    /// The id of the guild.
    public var guildId: GuildID?
}
