/// Sent when a guild channel's webhook is created, updated or deleted.
public struct DiscordWebhooksUpdateEvent: Codable {
    public enum CodingKeys: String, CodingKey {
        case guildId = "guild_id"
        case channelId = "channel_id"
    }

    /// The id of the guild.
    public var guildId: GuildID?
    /// The id of the channel.
    public var channelId: ChannelID
}
