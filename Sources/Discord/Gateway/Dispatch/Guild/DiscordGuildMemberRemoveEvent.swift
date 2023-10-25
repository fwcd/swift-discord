/// Sent when a user is removed from a guild (leave/kick/ban):
public struct DiscordGuildMemberRemoveEvent: Codable {
    public enum CodingKeys: String, CodingKey {
        case guildId = "guild_id"
        case user
    }

    /// The id of the guild.
    public var guildId: GuildID
    /// The user who was removed.
    public var user: DiscordUser
}
