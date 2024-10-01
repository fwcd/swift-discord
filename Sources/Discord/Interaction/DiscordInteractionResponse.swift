import Foundation

public struct DiscordInteractionResponse: Encodable {
    // MARK: Properties

    /// The type of response
    public let type: DiscordInteractionResponseType

    /// An optional response message
    public let data: DiscordInteractionApplicationCommandCallbackData?

    public init(
        type: DiscordInteractionResponseType,
        data: DiscordInteractionApplicationCommandCallbackData? = nil
    ) {
        self.type = type
        self.data = data
    }
}

public enum DiscordInteractionResponseType: Int, Encodable {
    /// Ack a ping
    case pong = 1

    /// Ack a command without sending a message, eating the user's input
    @available(*, deprecated, message: "This type no longer seems to be supported")
    case acknowledge = 2

    /// Respond with a message, eating the user's input
    @available(*, deprecated, message: "This type no longer seems to be supported")
    case channelMessage = 3

    /// Respond to an interaction with a message
    case channelMessageWithSource = 4

    /// ACK an interaction and edit a response later, the user sees a loading state
    case deferredChannelMessageWithSource = 5

    /// For components, ACK an interaction and edit the original message later; the user does not see a loading state
    case deferredUpdateMessage = 6

    /// For components, edit the message the component was attached to
    case updateMessage = 7

    /// Respond to an autocomplete interaction with suggested choices
    case applicationCommandAutocompleteResult = 8

    /// Respond to an interaction with a popup modal. Not available for `MODAL_SUBMIT` and `PING` interactions.
    case modal = 9

    /// Respond to an interaction with an upgrade button, only available for apps with monetization enabled
    @available(*, deprecated, message: "Deprecated in the official API docs")
    case premiumRequired = 10

    /// Launch the Activity associated with the app. Only available for apps with Activities enabled
    case launchActivity = 12

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

public struct DiscordInteractionApplicationCommandCallbackData: Encodable {
    public enum CodingKeys: String, CodingKey {
        case tts
        case content
        case embeds
        case allowedMentions = "allowed_mentions"
    }

    public let tts: Bool?
    public let content: String?
    public let embeds: [DiscordEmbed]?
    public let allowedMentions: DiscordAllowedMentions?

    public init(
        tts: Bool? = nil,
        content: String? = nil,
        embeds: [DiscordEmbed]? = nil,
        allowedMentions: DiscordAllowedMentions? = nil
    ) {
        self.tts = tts
        self.content = content
        self.embeds = embeds
        self.allowedMentions = allowedMentions
    }
}
