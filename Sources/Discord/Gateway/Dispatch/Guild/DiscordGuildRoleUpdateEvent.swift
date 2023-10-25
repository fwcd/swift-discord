/// Sent when a role is created/updated on a guild.
public struct DiscordGuildRoleUpdateEvent: Codable {
    public enum CodingKeys: String, CodingKey {
        case guildId = "guild_id"
        case role
    }

    /// The id of the guild.
    public var guildId: GuildID
    /// The role.
    public var role: DiscordRole
}
