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

/// A gateway payload to be sent.
public enum DiscordGatewayCommand: Encodable, Equatable {
    /// Starts a new session during the initial handshake.
    case identify(DiscordGatewayIdentify)
    /// Fired periodically by the client to keep the connection alive.
    case heartbeat(DiscordGatewayHeartbeat)
    /// Resumes a previous session that was disconnected.
    case resume(DiscordGatewayResume)
    /// Updates the clients presence.
    case presenceUpdate(DiscordPresenceUpdate)
    /// Request information about offline guild members in a large guild.
    case requestGuildMembers(DiscordGatewayRequestGuildMembers)

    public enum CodingKeys: String, CodingKey {
        case opcode = "op"
        case data = "d"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .identify(let identify): 
            try container.encode(DiscordGatewayOpcode.identify, forKey: .opcode)
            try container.encode(identify, forKey: .data)
        case .heartbeat(let heartbeat):
            try container.encode(DiscordGatewayOpcode.heartbeat, forKey: .opcode)
            try container.encode(heartbeat, forKey: .data)
        case .resume(let resume):
            try container.encode(DiscordGatewayOpcode.resume, forKey: .opcode)
            try container.encode(resume, forKey: .data)
        case .presenceUpdate(let update):
            try container.encode(DiscordGatewayOpcode.presenceUpdate, forKey: .opcode)
            try container.encode(update, forKey: .data)
        case .requestGuildMembers(let request):
            try container.encode(DiscordGatewayOpcode.requestGuildMembers, forKey: .opcode)
            try container.encode(request, forKey: .data)
        }
    }
}
