/// Sent when a guild's emojis have been updated.
public struct DiscordGuildEmojisUpdateEvent: Codable {
    public enum CodingKeys: String, CodingKey {
        case guildId = "guild_id"
        case emojis
    }

    /// The id of the guild.
    public var guildId: GuildID
    /// The emojis updated.
    public var emojis: [DiscordEmoji]
}
