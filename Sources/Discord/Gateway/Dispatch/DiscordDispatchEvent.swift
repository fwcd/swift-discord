// The MIT License (MIT)
// Copyright (c) 2016 Erik Little
// Copyright (c) 2021 fwcd

// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
// documentation files (the "Software"), to deal in the Software without restriction, including without
// limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
// Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
// Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
// BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
// ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.

import Foundation

// A gateway event from Discord.
public enum DiscordDispatchEvent: Decodable {
    case ready(DiscordReadyEvent)
    case resumed

    // Messaging
    case messageCreate(DiscordMessageCreateEvent)
    case messageDelete(DiscordMessageDeleteEvent)
    case messageDeleteBulk(DiscordMessageDeleteBulkEvent)
    case messageReactionAdd(DiscordMessageReactionAddEvent)
    case messageReactionRemove(DiscordMessageReactionRemoveEvent)
    case messageReactionRemoveAll(DiscordMessageReactionRemoveAllEvent)
    case messageUpdate(DiscordMessageUpdateEvent)

    // Guilds
    case guildBanAdd(DiscordGuildBanAddEvent)
    case guildBanRemove(DiscordGuildBanRemoveEvent)
    case guildCreate(DiscordGuildCreateEvent)
    case guildDelete(DiscordGuildDeleteEvent)
    case guildEmojisUpdate(DiscordGuildEmojisUpdateEvent)
    case guildIntegrationsUpdate(DiscordGuildIntegrationsUpdateEvent)
    case guildMemberAdd(DiscordGuildMemberAddEvent)
    case guildMemberUpdate(DiscordGuildMemberUpdateEvent)
    case guildMemberRemove(DiscordGuildMemberRemoveEvent)
    case guildMembersChunk(DiscordGuildMembersChunkEvent)
    case guildRoleCreate(DiscordGuildRoleCreateEvent)
    case guildRoleUpdate(DiscordGuildRoleUpdateEvent)
    case guildRoleDelete(DiscordGuildRoleDeleteEvent)
    case guildUpdate(DiscordGuildUpdateEvent)

    // Channels
    case channelCreate(DiscordChannelCreateEvent)
    case channelDelete(DiscordChannelDeleteEvent)
    case channelPinsUpdate(DiscordChannelPinsUpdateEvent)
    case channelUpdate(DiscordChannelUpdateEvent)
    case typingStart(DiscordTypingStartEvent)

    // Threads
    case threadCreate(DiscordThreadCreateEvent)
    case threadUpdate(DiscordThreadUpdateEvent)
    case threadDelete(DiscordThreadDeleteEvent)
    case threadListSync(DiscordThreadListSyncEvent)
    case threadMemberUpdate(DiscordThreadMemberUpdateEvent)
    case threadMembersUpdate(DiscordThreadMembersUpdateEvent)

    // Voice
    case voiceServerUpdate(DiscordVoiceServerUpdateEvent)
    case voiceStateUpdate(DiscordVoiceStateUpdateEvent)

    // Users
    case userUpdate(DiscordUserUpdateEvent)
    case presenceUpdate(DiscordPresenceUpdateEvent)

    // Webhooks
    case webhooksUpdate(DiscordWebhooksUpdateEvent)

    // Applications
    case applicationCommandCreate(DiscordApplicationCommandCreateEvent)
    case applicationCommandUpdate(DiscordApplicationCommandUpdateEvent)

    // Interactions
    case interactionCreate(DiscordInteractionCreateEvent)

    public enum CodingKeys: String, CodingKey {
        case type = "t"
        case data = "d"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(DiscordDispatchEventType.self, forKey: .type)

        switch type {
        case .ready: self = .ready(try container.decode(DiscordReadyEvent.self, forKey: .data))
        case .resumed: self = .resumed
        case .messageCreate: self = .messageCreate(try container.decode(DiscordMessageCreateEvent.self, forKey: .data))
        case .messageDelete: self = .messageDelete(try container.decode(DiscordMessageDeleteEvent.self, forKey: .data))
        case .messageDeleteBulk: self = .messageDeleteBulk(try container.decode(DiscordMessageDeleteBulkEvent.self, forKey: .data))
        case .messageReactionAdd: self = .messageReactionAdd(try container.decode(DiscordMessageReactionAddEvent.self, forKey: .data))
        case .messageReactionRemove: self = .messageReactionRemove(try container.decode(DiscordMessageReactionRemoveEvent.self, forKey: .data))
        case .messageReactionRemoveAll: self = .messageReactionRemoveAll(try container.decode(DiscordMessageReactionRemoveAllEvent.self, forKey: .data))
        case .messageUpdate: self = .messageUpdate(try container.decode(DiscordMessageUpdateEvent.self, forKey: .data))
        case .guildBanAdd: self = .guildBanAdd(try container.decode(DiscordGuildBanAddEvent.self, forKey: .data))
        case .guildBanRemove: self = .guildBanRemove(try container.decode(DiscordGuildBanRemoveEvent.self, forKey: .data))
        case .guildCreate: self = .guildCreate(try container.decode(DiscordGuildCreateEvent.self, forKey: .data))
        case .guildDelete: self = .guildDelete(try container.decode(DiscordGuildDeleteEvent.self, forKey: .data))
        case .guildEmojisUpdate: self = .guildEmojisUpdate(try container.decode(DiscordGuildEmojisUpdateEvent.self, forKey: .data))
        case .guildIntegrationsUpdate: self = .guildIntegrationsUpdate(try container.decode(DiscordGuildIntegrationsUpdateEvent.self, forKey: .data))
        case .guildMemberAdd: self = .guildMemberAdd(try container.decode(DiscordGuildMemberAddEvent.self, forKey: .data))
        case .guildMemberUpdate: self = .guildMemberUpdate(try container.decode(DiscordGuildMemberUpdateEvent.self, forKey: .data))
        case .guildMemberRemove: self = .guildMemberRemove(try container.decode(DiscordGuildMemberRemoveEvent.self, forKey: .data))
        case .guildMembersChunk: self = .guildMembersChunk(try container.decode(DiscordGuildMembersChunkEvent.self, forKey: .data))
        case .guildRoleCreate: self = .guildRoleCreate(try container.decode(DiscordGuildRoleCreateEvent.self, forKey: .data))
        case .guildRoleUpdate: self = .guildRoleUpdate(try container.decode(DiscordGuildRoleUpdateEvent.self, forKey: .data))
        case .guildRoleDelete: self = .guildRoleDelete(try container.decode(DiscordGuildRoleDeleteEvent.self, forKey: .data))
        case .guildUpdate: self = .guildUpdate(try container.decode(DiscordGuildUpdateEvent.self, forKey: .data))
        case .presenceUpdate: self = .presenceUpdate(try container.decode(DiscordPresenceUpdateEvent.self, forKey: .data))
        case .channelCreate: self = .channelCreate(try container.decode(DiscordChannelCreateEvent.self, forKey: .data))
        case .channelDelete: self = .channelDelete(try container.decode(DiscordChannelDeleteEvent.self, forKey: .data))
        case .channelPinsUpdate: self = .channelPinsUpdate(try container.decode(DiscordChannelPinsUpdateEvent.self, forKey: .data))
        case .channelUpdate: self = .channelUpdate(try container.decode(DiscordChannelUpdateEvent.self, forKey: .data))
        case .threadCreate: self = .threadCreate(try container.decode(DiscordThreadCreateEvent.self, forKey: .data))
        case .threadUpdate: self = .threadUpdate(try container.decode(DiscordThreadUpdateEvent.self, forKey: .data))
        case .threadDelete: self = .threadDelete(try container.decode(DiscordThreadDeleteEvent.self, forKey: .data))
        case .threadListSync: self = .threadListSync(try container.decode(DiscordThreadListSyncEvent.self, forKey: .data))
        case .threadMemberUpdate: self = .threadMemberUpdate(try container.decode(DiscordThreadMemberUpdateEvent.self, forKey: .data))
        case .threadMembersUpdate: self = .threadMembersUpdate(try container.decode(DiscordThreadMembersUpdateEvent.self, forKey: .data))
        case .voiceServerUpdate: self = .voiceServerUpdate(try container.decode(DiscordVoiceServerUpdateEvent.self, forKey: .data))
        case .voiceStateUpdate: self = .voiceStateUpdate(try container.decode(DiscordVoiceStateUpdateEvent.self, forKey: .data))
        case .typingStart: self = .typingStart(try container.decode(DiscordTypingStartEvent.self, forKey: .data))
        case .userUpdate: self = .userUpdate(try container.decode(DiscordUserUpdateEvent.self, forKey: .data))
        case .webhooksUpdate: self = .webhooksUpdate(try container.decode(DiscordWebhooksUpdateEvent.self, forKey: .data))
        case .applicationCommandCreate: self = .applicationCommandCreate(try container.decode(DiscordApplicationCommandCreateEvent.self, forKey: .data))
        case .applicationCommandUpdate: self = .applicationCommandUpdate(try container.decode(DiscordApplicationCommandUpdateEvent.self, forKey: .data))
        case .interactionCreate: self = .interactionCreate(try container.decode(DiscordInteractionCreateEvent.self, forKey: .data))
        default: throw DiscordDispatchEventError.unknownEventType(type)
        }
    }
}
