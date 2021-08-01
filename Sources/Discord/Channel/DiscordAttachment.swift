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

/// Represents an attachment.
public struct DiscordAttachment: Identifiable, Codable, Hashable {
    public enum CodingKeys: String, CodingKey {
        case id
        case filename
        case height
        case proxyUrl = "proxy_url"
        case size
        case url
        case width
    }

    // MARK: Properties

    /// The snowflake id of this attachment.
    public var id: AttachmentID

    /// The name of the file.
    public var filename: String

    /// The height, if this is an image.
    public var height: Int? = nil

    /// The proxy url for this attachment.
    public var proxyUrl: URL? = nil

    /// The size of this attachment.
    public var size: Int? = nil

    /// The url of this attachment.
    public var url: URL? = nil

    /// The width, if this is an image.
    public var width: Int? = nil
}
