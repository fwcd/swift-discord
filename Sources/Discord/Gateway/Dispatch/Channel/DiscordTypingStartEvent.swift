/// Sent when a user starts typing in a channel.
public struct DiscordTypingStartEvent: Codable {
    public enum CodingKeys: String, CodingKey {
        case channelId = "channel_id"
        case guildId = "guild_id"
        case userId = "user_id"
        case timestamp
        case member
    }

    /// The id of the channel.
    public var channelId: ChannelID
    /// The id of the guild.
    public var guildId: GuildID?
    /// The id of the user.
    public var userId: UserID
    /// The unix time in seconds of when the user started typing.
    public var timestamp: Int
    /// The member who started typing if this happened in a guild.
    public var member: DiscordGuildMember?
}
