import Discord
import Dispatch

class PingPongBot: DiscordClientDelegate {
    private var client: DiscordClient!

    init(token: String) {
        client = DiscordClient(token: "Bot \(token)", delegate: self)
        client.connect()
    }

    func client(_ client: DiscordClient, didCreateMessage message: DiscordMessage) {
        if message.content == "ping" {
            client.sendMessage("pong", to: message.channelId)
        }
    }
}

let args = CommandLine.arguments

guard args.count > 1 else {
    print("Usage: \(args[0]) <your token>")
    exit(1)
}

let bot = PingPongBot(token: args[1])
dispatchMain()
