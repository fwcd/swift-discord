/// Sent when a guild's integration is updated.
public struct DiscordGuildIntegrationsUpdateEvent: Codable {
    public enum CodingKeys: String, CodingKey {
        case guildId = "guild_id"
    }

    /// The id of the guild.
    public var guildId: GuildID
}
