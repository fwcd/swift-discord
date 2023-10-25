public struct DiscordReadyEvent: Codable {
    public enum CodingKeys: String, CodingKey {
        case gatewayVersion = "v"
        case user
        case guilds
        case sessionId = "session_id"
        case shard
        case application
    }

    /// The gateway version.
    public var gatewayVersion: Int?

    /// Information about the user including email.
    public var user: DiscordUser?

    /// The guilds the user is in.
    /// Note that the guilds are unavailable and thus only have their
    /// `id` and `unavailable` fields specified.
    public var guilds: [DiscordGuild]? = nil

    /// Used for resuming connections.
    public var sessionId: String? = nil

    /// The shard information associated with this session, if sent
    /// when identifying. An array of two integers:
    /// - shard_id
    /// - num_shards
    public var shard: [Int]? = nil

    /// The partial application object (contains `id` and `flags`).
    public var application: DiscordApplication? = nil
}
