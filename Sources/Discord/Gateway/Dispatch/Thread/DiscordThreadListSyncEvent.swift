/// Sent when the current user *gains* access to a channel
public struct DiscordThreadListSyncEvent: Codable {
    public enum CodingKeys: String, CodingKey {
        case guildId = "guild_id"
        case channelIds = "channel_ids"
        case threads
        case members
    }

    /// The id of the guild.
    public var guildId: GuildID?
    /// The parent channel ids whose threads are being synced. If omitted, then
    /// threads were synced for the entire guild. This array may contain channel_ids
    /// that have no active threads as well, so you know to clear that data.
    public var channelIds: [ChannelID]?
    /// All active threads in the given channels that the current user can access.
    public var threads: [DiscordChannel]
    /// All thread member objects from the synced threads for the current user,
    /// indicating which threads the current user has been added to.
    public var members: [DiscordThreadMember]
}
