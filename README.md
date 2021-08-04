# Discord Client for Swift

[![Linux](https://github.com/fwcd/swift-discord/actions/workflows/linux.yml/badge.svg)](https://github.com/fwcd/swift-discord/actions/workflows/linux.yml)
[![macOS](https://github.com/fwcd/swift-discord/actions/workflows/mac.yml/badge.svg)](https://github.com/fwcd/swift-discord/actions/workflows/mac.yml)
[![Docs](https://github.com/fwcd/swift-discord/actions/workflows/docs.yml/badge.svg)](https://fwcd.github.io/swift-discord)

A client library for the [Discord API](https://discord.com/developers/docs) written in Swift.

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
            message.channel?.send("pong")
        }
    }
}

let bot = Bot()
dispatchMain()
```

Check out the [Getting Started](UsageDocs/Getting%20Started.md) page for a quickstart guide.

## Features

- macOS and Linux support
- v9 API (including threads, interactions, slash commands and message components)
- Configurable sharding

## Requirements

- Swift 5+

## Building

`swift build`
