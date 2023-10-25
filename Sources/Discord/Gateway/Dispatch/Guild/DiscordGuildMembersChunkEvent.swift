/// Sent in response to Guild Request Members. You can use `chunk_index` and `chunk_count`
/// to calculate how many chunks are left for your request.
public struct DiscordGuildMembersChunkEvent: Codable {
    public enum CodingKeys: String, CodingKey {
        case guildId = "guild_id"
        case members
        case chunkIndex = "chunk_index"
        case chunkCount = "chunk_count"
        case notFound = "not_found"
        case presences
        case nonce
    }

    /// The id of the guild.
    public var guildId: GuildID?
    /// Set of guild members.
    public var members: [DiscordGuildMember]
    /// The chunk index in the expected chunks for this response
    /// (0 <= chunkIndex < chunkCount).
    public var chunkIndex: Int
    /// The total number of expected chunks for this response.
    public var chunkCount: Int
    /// When passing an invalid id to the Guild Members Request, it will
    /// be returned here.
    public var notFound: [Snowflake]?
    /// When passing true to the Guild Members Request, presences of the
    /// returned members.
    public var presences: [DiscordPresence]?
    /// The nonce used in the Guild Members Request.
    public var nonce: String?
}
