# ``Discord``

Write chat bots using the Discord API.

## Overview

The `Discord` library provides a client wrapper for interacting with the Discord API, e.g. to build a chat bot. For a simple example, refer to [the project's `README`](https://github.com/fwcd/swift-discord#example).

## Example

```swift
import Discord
import Dispatch

class Bot: DiscordClientDelegate {
    private var client: DiscordClient!

    init() {
        client = DiscordClient(token: "Bot myjwt.from.discord", delegate: self)
        client.connect()
    }

    func client(_ client: DiscordClient, didCreateMessage message: DiscordMessage) {
        if message.content == "ping" {
            client.sendMessage("pong", to: message.channelId)
        }
    }
}

let bot = Bot()
dispatchMain()
```
