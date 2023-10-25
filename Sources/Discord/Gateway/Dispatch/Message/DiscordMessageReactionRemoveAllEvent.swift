/// Sent when a user explicitly removes all reactions from a message.
public struct DiscordMessageReactionRemoveAllEvent: Codable {
    public enum CodingKeys: String, CodingKey {
        case channelId = "channel_id"
        case messageId = "message_id"
        case guildId = "guild_id"
    }

    /// The id of the channel.
    public var channelId: ChannelID
    /// The id of the message.
    public var messageId: MessageID
    /// The id of the guild.
    public var guildId: GuildID?
}
