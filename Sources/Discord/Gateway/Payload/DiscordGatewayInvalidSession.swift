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

/// Indicates one of three situations:
///   - The gateway could not initialize a session after opcode 2 identify
///   - The gateway could not resume a previous session after opcode 6 resume
///   - The gateway has invalidated an active session and is requesting client action
public struct DiscordGatewayInvalidSession: RawRepresentable, Codable {
    /// Whether the session is resumsable.
    public var isResumable: Bool

    public var rawValue: Bool {
        get { isResumable }
        set { isResumable = newValue }
    }

    public init(isResumable: Bool) {
        self.isResumable = isResumable
    }

    public init(rawValue: Bool) {
        self.init(isResumable: rawValue)
    }
}
