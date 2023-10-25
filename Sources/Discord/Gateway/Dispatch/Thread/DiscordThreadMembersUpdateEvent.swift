/// Sent when anyone is added/removed from a thread.
public struct DiscordThreadMembersUpdateEvent: Codable {
    public enum CodingKeys: String, CodingKey {
        case id
        case guildId = "guild_id"
        case memberCount = "member_count"
        case addedMembers = "added_members"
        case removedMemberIds = "removed_member_ids"
    }

    /// The id of the thread.
    public var id: ChannelID
    /// The id of the guild.
    public var guildId: GuildID
    /// The approximate number of members in the thread, capped at 50.
    public var memberCount: Int
    /// The users added to the thread.
    public var addedMembers: [DiscordThreadMember]?
    /// The ids of the users removed from the thread.
    public var removedMemberIds: [UserID]?
}
