import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import Logging

fileprivate let logger = Logger(label: "DiscordEndpointEmoji")

public extension DiscordEndpointConsumer where Self: DiscordUserActor {
    // Default implementation
    func createGuildEmoji(on guildId: GuildID,
                                name: String,
                                image: String,
                                roles: [RoleID],
                                callback: ((DiscordEmoji?, HTTPURLResponse?) -> ())? = nil) {
        var createJSON = [String: Encodable]()

        createJSON["name"] = name
        createJSON["image"] = image
        createJSON["roles"] = roles.map { String($0.rawValue) }

        guard let contentData = try? DiscordJSON.encode(GenericEncodableDictionary(createJSON)) else { return }

        let requestCallback: DiscordRequestCallback = { data, response, error in
            guard let emoji: DiscordEmoji = DiscordJSON.decodeResponse(data: data, response: response) else {
                callback?(nil, response)
                return
            }

            callback?(emoji, response)
        }

        rateLimiter.executeRequest(endpoint: .guildEmojis(guild: guildId),
                                   token: token,
                                   requestInfo: .post(content: .json(contentData), extraHeaders: nil),
                                   callback: requestCallback)
    }

    // Default implementation
    func getGuildEmojis(on guildId: GuildID,
                                callback: @escaping ([DiscordEmoji], HTTPURLResponse?) -> ()) {
        let requestCallback: DiscordRequestCallback = { data, response, error in
            guard let emojis: [DiscordEmoji] = DiscordJSON.decodeResponse(data: data, response: response) else {
                callback([], response)
                return
            }

            callback(emojis, response)
        }

        rateLimiter.executeRequest(endpoint: .guildEmojis(guild: guildId),
                                   token: token,
                                   requestInfo: .get(params: nil, extraHeaders: nil),
                                   callback: requestCallback)
    }

    // Default implementation
    func getGuildEmoji(on guildId: GuildID,
                                for emojiId: EmojiID,
                                callback: @escaping (DiscordEmoji?, HTTPURLResponse?) -> ()) {
        let requestCallback: DiscordRequestCallback = { data, response, error in
            guard let emoji: DiscordEmoji = DiscordJSON.decodeResponse(data: data, response: response) else {
                callback(nil, response)
                return
            }

            callback(emoji, response)
        }

        rateLimiter.executeRequest(endpoint: .guildEmoji(guild: guildId, emoji: emojiId),
                                   token: token,
                                   requestInfo: .get(params: nil, extraHeaders: nil),
                                   callback: requestCallback)
    }

    // Default implementation
    func deleteGuildEmoji(on guildId: GuildID,
                                    for emojiId: EmojiID,
                                    callback: ((Bool, HTTPURLResponse?) -> ())? = nil) {
        rateLimiter.executeRequest(endpoint: .guildEmoji(guild: guildId, emoji: emojiId),
                                   token: token,
                                   requestInfo: .delete(content: nil, extraHeaders: nil),
                                   callback: { _, response, _ in callback?(response?.statusCode == 204, response) })
    }
}
