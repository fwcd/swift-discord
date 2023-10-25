/// Sent when a role is removed from a guild.
public struct DiscordGuildRoleDeleteEvent: Codable {
    public enum CodingKeys: String, CodingKey {
        case guildId = "guild_id"
        case roleId = "role_id"
    }

    /// The id of the guild.
    public var guildId: GuildID
    /// The id of the role.
    public var roleId: RoleID
}
