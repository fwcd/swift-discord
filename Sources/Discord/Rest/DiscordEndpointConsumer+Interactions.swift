import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public extension DiscordEndpointConsumer where Self: DiscordUserActor {
    /// Default implementation
    func createInteractionResponse(for interactionId: InteractionID,
                                   token interactionToken: String,
                                   response: DiscordInteractionResponse,
                                   callback: ((Data?, HTTPURLResponse?) -> ())? = nil){
        let requestCallback: DiscordRequestCallback = { data, response, error in
            callback?(data, response)
        }
        rateLimiter.executeRequest(endpoint: .interactionsCallback(interactionId: interactionId, interactionToken: interactionToken),
                                   token: token,
                                   requestInfo: .post(content: .json((try? DiscordJSON.encode(response)) ?? Data()), extraHeaders: nil),
                                   callback: requestCallback)
    }
}
