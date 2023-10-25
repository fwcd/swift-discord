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

/// Used to request all members for a guild or a list of guilds.
public struct DiscordGatewayRequestGuildMembers: Codable, Hashable {
    /// The id of the guild to get members for.
    public var guildId: GuildID
    /// String that username starts with (allows empty string for all).
    /// Either `query` or `userIds` is needed.
    public var query: String? = nil
    /// Used to specify which users we wish to fetch.
    /// Either `query` or `userIds` is needed.
    public var userIds: [UserID]? = nil
    /// Maximum number of members to send matching the `query`.
    /// Limit of 0 may be used to return all members.
    public var limit: Int = 0
    /// Used to specify if we want the presenced of the matched members.
    public var presences: Bool? = false
    /// Nonce to identify the guild members chunk response.
    public var nonce: String? = nil
}
