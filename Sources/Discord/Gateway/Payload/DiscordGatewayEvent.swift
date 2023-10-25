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

/// A gateway payload to be received.
public enum DiscordGatewayEvent: Decodable {
    /// An event was dispatched (receive).
    case dispatch(DiscordGatewayDispatch)
    /// We should attempt to reconnect and resume immediately.
    case reconnect
    /// A heartbeat.
    case heartbeat
    /// The session has been invalidated. We should reconnect and identify/
    /// resume accordinly.
    case invalidSession(DiscordGatewayInvalidSession)
    /// Sent immediately after connecting, contains the `heartbeat_interval`.
    case hello(DiscordGatewayHello)
    /// Sent in response to receiving a heartbeat to acknowledge that it has
    /// been received.
    case heartbeatAck

    public enum CodingKeys: String, CodingKey {
        case opcode = "op"
        case data = "d"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let opcode = try container.decode(DiscordGatewayOpcode.self, forKey: .opcode)
        switch opcode {
        case .dispatch: self = .dispatch(try DiscordGatewayDispatch(from: decoder))
        case .reconnect: self = .reconnect
        case .invalidSession: self = .invalidSession(try container.decode(DiscordGatewayInvalidSession.self, forKey: .data))
        case .hello: self = .hello(try container.decode(DiscordGatewayHello.self, forKey: .data))
        case .heartbeat: self = .heartbeat
        case .heartbeatAck: self = .heartbeatAck
        default: throw DiscordGatewayEventError.unrecognizedOpcode(opcode)
        }
    }
}
