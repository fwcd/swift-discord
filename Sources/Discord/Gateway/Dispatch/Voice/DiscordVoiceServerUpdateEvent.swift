/// Sent when a guild's voice server is updated.
public struct DiscordVoiceServerUpdateEvent: Codable {
    public enum CodingKeys: String, CodingKey {
        case token
        case guildId = "guild_id"
        case endpoint
    }

    /// The voice connection token.
    public var token: String

    /// The guild this voice server update is for.
    public var guildId: GuildID?

    /// The voice server host.
    public var endpoint: String?
}
