import Foundation

/// Represents a slash-command invocation by the user.
public struct DiscordInteraction: Identifiable, Codable, Hashable {
    public enum CodingKeys: String, CodingKey {
        case id
        case type
        case data
        case message
        case guildId = "guild_id"
        case channelId = "channel_id"
        case member
        case token
        case version
    }

    // MARK: Properties

    /// ID of the interaction
    public let id: InteractionID

    /// Type of the interaction
    public let type: DiscordInteractionType?


    /// Command data payload
    /// Always specified for DiscordApplicationCommand interaction
    /// types, but optional for future-proofing.
    public let data: DiscordInteractionData?

    /// The message a user interacted with, e.g. when pressing a button.
    public let message: DiscordMessage?

    /// Guild it was sent from
    public let guildId: GuildID

    /// Channel it was sent from
    public let channelId: ChannelID

    /// Guild member data for the invoking user
    public let member: DiscordGuildMember?

    /// Continuation token for responding to the interaction
    public let token: String

    /// Read-only property, always 1
    public let version: Int
}

public struct DiscordInteractionType: RawRepresentable, Hashable, Codable {
    public var rawValue: Int

    public static let ping = DiscordInteractionType(rawValue: 1)
    public static let applicationCommand = DiscordInteractionType(rawValue: 2)
    public static let messageComponent = DiscordInteractionType(rawValue: 3)

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

public struct DiscordInteractionData: Codable, Hashable {
    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case customId = "custom_id"
        case options
    }

    /// The ID of the invoked command
    public var id: CommandID?

    /// The name of the invoked command
    public var name: String?

    /// A custom (developer-defined) id attached to e.g. a button interaction.
    public var customId: String?

    /// The params + values by the user
    public var options: [DiscordInteractionDataOption]?
}

public struct DiscordInteractionDataOption: Codable, Hashable {
    /// The name of the parameter.
    public var name: String

    // TODO: Add this and type it property, e.g. using an enum that
    //       encodes itself using an internally tagged representation.
    //       See https://discord.com/developers/docs/interactions/slash-commands#application-command-object-application-command-option-type
    // /// The value of the pair. Type is the OptionType of the command.
    // public var value: Any?

    /// Present if this option is a group or subcommand.
    public var options: [DiscordInteractionDataOption]?
}
