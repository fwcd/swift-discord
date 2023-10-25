/// Sent when a guild's stickers have been updated.
public struct DiscordGuildStickersUpdateEvent: Codable {
    public enum CodingKeys: String, CodingKey {
        case guildId = "guild_id"
        case stickers
    }

    /// The id of the guild.
    public var guildId: GuildID
    /// The stickers updated.
    public var stickers: [DiscordSticker]
}
