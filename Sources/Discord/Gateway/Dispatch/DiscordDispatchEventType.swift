/// An enum that represents the dispatch events Discord sends.
public struct DiscordDispatchEventType: RawRepresentable, Codable, Hashable {
    public let rawValue: String

    public static let ready = DiscordDispatchEventType(rawValue: "READY")
    public static let resumed = DiscordDispatchEventType(rawValue: "RESUMED")

    // Messaging

    public static let messageCreate = DiscordDispatchEventType(rawValue: "MESSAGE_CREATE")
    public static let messageDelete = DiscordDispatchEventType(rawValue: "MESSAGE_DELETE")
    public static let messageDeleteBulk = DiscordDispatchEventType(rawValue: "MESSAGE_DELETE_BULK")
    public static let messageReactionAdd = DiscordDispatchEventType(rawValue: "MESSAGE_REACTION_ADD")
    public static let messageReactionRemoveAll = DiscordDispatchEventType(rawValue: "MESSAGE_REACTION_REMOVE_ALL")
    public static let messageReactionRemove = DiscordDispatchEventType(rawValue: "MESSAGE_REACTION_REMOVE")
    public static let messageUpdate = DiscordDispatchEventType(rawValue: "MESSAGE_UPDATE")

    // Guilds

    public static let guildBanAdd = DiscordDispatchEventType(rawValue: "GUILD_BAN_ADD")
    public static let guildBanRemove = DiscordDispatchEventType(rawValue: "GUILD_BAN_REMOVE")
    public static let guildCreate = DiscordDispatchEventType(rawValue: "GUILD_CREATE")
    public static let guildDelete = DiscordDispatchEventType(rawValue: "GUILD_DELETE")
    public static let guildEmojisUpdate = DiscordDispatchEventType(rawValue: "GUILD_EMOJIS_UPDATE")
    public static let guildIntegrationsUpdate = DiscordDispatchEventType(rawValue: "GUILD_INTEGRATIONS_UPDATE")
    public static let guildMemberAdd = DiscordDispatchEventType(rawValue: "GUILD_MEMBER_ADD")
    public static let guildMemberRemove = DiscordDispatchEventType(rawValue: "GUILD_MEMBER_REMOVE")
    public static let guildMemberUpdate = DiscordDispatchEventType(rawValue: "GUILD_MEMBER_UPDATE")
    public static let guildMembersChunk = DiscordDispatchEventType(rawValue: "GUILD_MEMBERS_CHUNK")
    public static let guildRoleCreate = DiscordDispatchEventType(rawValue: "GUILD_ROLE_CREATE")
    public static let guildRoleDelete = DiscordDispatchEventType(rawValue: "GUILD_ROLE_DELETE")
    public static let guildRoleUpdate = DiscordDispatchEventType(rawValue: "GUILD_ROLE_UPDATE")
    public static let guildUpdate = DiscordDispatchEventType(rawValue: "GUILD_UPDATE")

    // Channels

    public static let channelCreate = DiscordDispatchEventType(rawValue: "CHANNEL_CREATE")
    public static let channelDelete = DiscordDispatchEventType(rawValue: "CHANNEL_DELETE")
    public static let channelPinsUpdate = DiscordDispatchEventType(rawValue: "CHANNEL_PINS_UPDATE")
    public static let channelUpdate = DiscordDispatchEventType(rawValue: "CHANNEL_UPDATE")

    // Threads

    public static let threadCreate = DiscordDispatchEventType(rawValue: "THREAD_CREATE")
    public static let threadUpdate = DiscordDispatchEventType(rawValue: "THREAD_UPDATE")
    public static let threadDelete = DiscordDispatchEventType(rawValue: "THREAD_DELETE")
    public static let threadListSync = DiscordDispatchEventType(rawValue: "THREAD_LIST_SYNC")
    public static let threadMemberUpdate = DiscordDispatchEventType(rawValue: "THREAD_MEMBER_UPDATE")
    public static let threadMembersUpdate = DiscordDispatchEventType(rawValue: "THREAD_MEMBERS_UPDATE")

    // Voice

    public static let voiceServerUpdate = DiscordDispatchEventType(rawValue: "VOICE_SERVER_UPDATE")
    public static let voiceStateUpdate = DiscordDispatchEventType(rawValue: "VOICE_STATE_UPDATE")
    public static let presenceUpdate = DiscordDispatchEventType(rawValue: "PRESENCE_UPDATE")
    public static let typingStart = DiscordDispatchEventType(rawValue: "TYPING_START")

    // Webhooks

    public static let webhooksUpdate = DiscordDispatchEventType(rawValue: "WEBHOOKS_UPDATE")

    // Applications

    public static let applicationCommandCreate = DiscordDispatchEventType(rawValue: "APPLICATION_COMMAND_CREATE")
    public static let applicationCommandUpdate = DiscordDispatchEventType(rawValue: "APPLICATION_COMMAND_UPDATE")

    // Users
    
    public static let userUpdate = DiscordDispatchEventType(rawValue: "USER_UPDATE")

    // Interactions

    public static let interactionCreate = DiscordDispatchEventType(rawValue: "INTERACTION_CREATE")

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
