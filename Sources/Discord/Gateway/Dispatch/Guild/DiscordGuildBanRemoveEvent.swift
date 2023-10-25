/// Sent when a user is unbanned from a guild.
public struct DiscordGuildBanRemoveEvent: Codable {
    public enum CodingKeys: String, CodingKey {
        case guildId = "guild_id"
        case user
    }

    /// The id of the guild.
    public var guildId: GuildID
    /// The banned user.
    public var user: DiscordUser
}
