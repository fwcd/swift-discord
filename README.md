# Discord Client for Swift

[![Build](https://github.com/fwcd/swift-discord/actions/workflows/build.yml/badge.svg)](https://github.com/fwcd/swift-discord/actions/workflows/build.yml)
[![Docs](https://github.com/fwcd/swift-discord/actions/workflows/docs.yml/badge.svg)](https://fwcd.github.io/swift-discord/documentation/discord)

A client library for the [Discord API](https://discord.com/developers/docs) written in Swift.

This project is a fork of [nuclearace's](https://github.com/nuclearace) [`SwiftDiscord`](https://github.com/nuclearace/SwiftDiscord), which is no longer actively maintained as of 2023. Among other changes, the codebase has been [refactored](https://github.com/fwcd/swift-discord/pull/4) to employ modern Swift patterns, such as value types and `Codable`, along with support for the v9 API.

## Example

A simple Discord bot that responds to every "ping" message with "pong" could be implemented as follows:

```swift
import Discord
import Dispatch

class PingPongBot: DiscordClientDelegate {
    private var client: DiscordClient!

    init() {
        client = DiscordClient(
            token: "Bot <your token>",
            delegate: self,
            configuration: [.intents([.guildMessages, .messageContent])]
        )
        client.connect()
    }

    func client(_ client: DiscordClient, didCreateMessage message: DiscordMessage) {
        if message.content == "ping" {
            client.sendMessage("pong", to: message.channelId)
        }
    }
}

let bot = PingPongBot()
dispatchMain()
```

You can run this example (which is provided as a [snippet](Snippets/PingPongBot.swift)) with

```sh
swift run PingPongBot <your token>
```

Check out the [docs](https://fwcd.github.io/swift-discord/documentation/discord) for more detailed information about the API.

## Features

- macOS and Linux support
- v9 API (including threads, interactions, slash commands and message components)
- Configurable sharding

## Requirements

- Swift 5.7+

## Building

`swift build`
