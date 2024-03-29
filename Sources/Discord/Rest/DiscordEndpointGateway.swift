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
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

import Dispatch

private struct DiscordGatewayInfo: Codable {
    let url: URL
}

private let gatewaySemaphore = DispatchSemaphore(value: 0)

struct DiscordEndpointGateway {
    static var gatewayURL = getURL()

    static func getURL() -> URL {
        var request = URLRequest(url: URL(string: "https://discord.com/api/gateway")!)
        request.httpMethod = "GET"

        var url = URL(string: "wss://gateway.discord.gg")!

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let info: DiscordGatewayInfo = try? DiscordJSON.decode(data) else {
                gatewaySemaphore.signal()
                return
            }

            url = info.url
            gatewaySemaphore.signal()
        }.resume()

        gatewaySemaphore.wait()

        return url
    }
}
