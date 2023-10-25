/// Sent when a single reaction is added/removed.
public struct DiscordMessageReactionUpdateEvent: Codable {
    public enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case channelId = "channel_id"
        case messageId = "message_id"
        case guildId = "guild_id"
        case emoji
        case member
    }

    /// The id of the user.
    public var userId: UserID
    /// The id of the channel.
    public var channelId: ChannelID
    /// The id of the message.
    public var messageId: MessageID
    /// The id of the guild.
    public var guildId: GuildID?
    /// The member who reacted if in a guild.
    /// Only specified on reaction additions.
    public var member: DiscordGuildMember?
    /// The emoji used to react.
    public var emoji: DiscordEmoji
}
