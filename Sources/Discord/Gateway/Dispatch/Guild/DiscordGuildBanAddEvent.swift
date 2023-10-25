/// Sent when a user is banned from a guild.
public struct DiscordGuildBanAddEvent: Codable {
    public enum CodingKeys: String, CodingKey {
        case guildId = "guild_id"
        case user
    }

    /// The id of the guild.
    public var guildId: GuildID
    /// The banned user.
    public var user: DiscordUser
}
