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

///
/// Declares that a type will be a delegate for a `DiscordClient`. After the client handles any events,
/// the corresponding delegate method will be called.
///
public protocol DiscordClientDelegate : AnyObject {
    // MARK: Methods

    ///
    /// Called when the client connects to Discord.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didConnect: Should always be true.
    ///
    func client(_ client: DiscordClient, didConnect connected: Bool)

    ///
    /// Called when the client disconnects from discord.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didDisconnectWithReason: The reason the client disconnected.
    /// - parameter closed: Whether the connection was closed.
    ///
    func client(_ client: DiscordClient, didDisconnectWithReason reason: DiscordGatewayCloseReason, closed: Bool)

    ///
    /// Whether the client should attempt resuming a gateway connection after a disconnect.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didDisconnectWithReason: The reason the client disconnected.
    /// - parameter closed: Whether the connection was closed.
    ///
    func client(_ client: DiscordClient, shouldAttemptResuming reason: DiscordGatewayCloseReason, closed: Bool) -> Bool

    ///
    /// Called when the client creates a new channel.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didCreateChannel: The channel that was created.
    ///
    func client(_ client: DiscordClient, didCreateChannel channel: DiscordChannel)

    ///
    /// Called when the client deletes a channel.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didDeleteChannel: The channel that was deleted.
    ///
    func client(_ client: DiscordClient, didDeleteChannel channel: DiscordChannel)

    ///
    /// Called when the client updates a channel.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didUpdateChannel: The channel that was updated.
    ///
    func client(_ client: DiscordClient, didUpdateChannel channel: DiscordChannel)

    ///
    /// Called when the client creates a new thread.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didCreateThread: The thread that was created.
    ///
    func client(_ client: DiscordClient, didCreateThread thread: DiscordChannel)

    ///
    /// Called when the client deletes a thread.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didDeleteThread: The thread that was deleted.
    ///
    func client(_ client: DiscordClient, didDeleteThread thread: DiscordChannel)

    ///
    /// Called when the client updates a thread.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didUpdateThread: The thread that was updated.
    ///
    func client(_ client: DiscordClient, didUpdateThread thread: DiscordChannel)

    ///
    /// Called when the client creates a new guild.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didCreateGuild: The guild that was created.
    ///
    func client(_ client: DiscordClient, didCreateGuild guild: DiscordGuild)

    ///
    /// Called when the client deletes a guild.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didDeleteGuild: The guild that was deleted.
    ///
    func client(_ client: DiscordClient, didDeleteGuild guild: DiscordGuild)

    ///
    /// Called when the client updates a guild.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didUpdateGuild: The guild that was updated.
    ///
    func client(_ client: DiscordClient, didUpdateGuild guild: DiscordGuild)

    ///
    /// Called when the client adds a new guild member.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didAddGuildMember: The guild member that was added.
    ///
    func client(_ client: DiscordClient, didAddGuildMember member: DiscordGuildMember)

    ///
    /// Called when the client removes a guild member.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didRemoveGuildMember: The guild member that was removed.
    ///
    func client(_ client: DiscordClient, didRemoveGuildMember member: DiscordGuildMember)

    ///
    /// Called when the client updates a guild member.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didUpdateGuildMember: The guild member that was updated.
    ///
    func client(_ client: DiscordClient, didUpdateGuildMember member: DiscordGuildMember)

    ///
    /// Called when the client receives a message update from Discord.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didUpdateMessage: The message that was received.
    ///
    func client(_ client: DiscordClient, didUpdateMessage message: DiscordMessage)

    ///
    /// Called when the client receives a message from Discord.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didCreateMessage: The message that was received.
    ///
    func client(_ client: DiscordClient, didCreateMessage message: DiscordMessage)

    ///
    /// Called when a user adds a reaction to a message.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter reaction: The reaction that was added.
    /// - parameter messageID: The ID of the message the reaction was added to.
    /// - parameter channel: The channel the message was on.
    /// - parameter userID: The ID of the user who added the reaction.
    ///
    func client(_ client: DiscordClient, didAddReaction reaction: DiscordEmoji, toMessage messageID: MessageID, onChannel channel: DiscordChannel, user userID: UserID)

    ///
    /// Called when a user removes a reaction to a message.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter reaction: The reaction that was added.
    /// - parameter messageID: The ID of the message the reaction was removed from.
    /// - parameter channel: The channel the message was on.
    /// - parameter userID: The ID of the user who added the reaction.
    ///
    func client(_ client: DiscordClient, didRemoveReaction reaction: DiscordEmoji, fromMessage messageID: MessageID, onChannel channel: DiscordChannel, user userID: UserID)

    ///
    /// Called when all reactions are removed from a message.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter messageID: The ID of the message all
    /// - parameter channel: The channel the message was on
    ///
    func client(_ client: DiscordClient, didRemoveAllReactionsFrom messageID: MessageID, onChannel channel: DiscordChannel)

    ///
    /// Called when the client adds a new role.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didCreateRole: The role that was created.
    /// - parameter onGuild: The guild the role was created on.
    ///
    func client(_ client: DiscordClient, didCreateRole role: DiscordRole, onGuild guild: DiscordGuild)

    ///
    /// Called when the client deletes a role.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didDeleteRole: The role that was deleted.
    /// - parameter fromGuild: The guild the role was deleted from.
    ///
    func client(_ client: DiscordClient, didDeleteRole role: DiscordRole, fromGuild guild: DiscordGuild)

    ///
    /// Called when the client updates a role.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didUpdateRole: The role that was updated.
    /// - parameter onGuild: The guild the role was updated on.
    ///
    func client(_ client: DiscordClient, didUpdateRole role: DiscordRole, onGuild guild: DiscordGuild)

    ///
    /// Called when the client receives a message from Discord.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didReceivePresenceUpdate: The presence that was received.
    ///
    func client(_ client: DiscordClient, didReceivePresenceUpdate presence: DiscordPresence)

    ///
    /// Called when the client receives a new interaction, i.e.
    /// a slash command invocation.
    ///
    /// - parameter interaction: The invocation data
    ///
    func client(_ client: DiscordClient, didCreateInteraction interaction: DiscordInteraction)

    ///
    /// Called when the client receives a ready event.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didReceiveReady: The presence that was received.
    ///
    func client(_ client: DiscordClient, didReceiveReady ready: DiscordReadyEvent)

    ///
    /// Called when the client receives a voice state update.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didReceiveVoiceStateUpdate: The voice state that was received.
    ///
    func client(_ client: DiscordClient, didReceiveVoiceStateUpdate voiceState: DiscordVoiceState)

    ///
    /// Called when the client handles a guild member chunk.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didHandleGuildMemberChunk: The new members
    /// - parameter forGuild: The guild the members were added to.
    ///
    func client(_ client: DiscordClient, didHandleGuildMemberChunk chunk: [DiscordGuildMember],
                forGuild guild: DiscordGuild)

    ///
    /// Called when the client does not handle a dispatch event.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didNotHandleDispatchEvent: The event that wasn't handled.
    ///
    func client(_ client: DiscordClient, didNotHandleDispatchEvent event: DiscordDispatchEvent)

    ///
    /// Called when the client updates a guild's emojis.
    ///
    /// - parameter client: The client that is calling.
    /// - parameter didUpdateEmojis: The chunk of guild emojis that was updated
    /// - parameter onGuild: The guild the emojis were updated on.
    ///
    func client(_ client: DiscordClient, didUpdateEmojis emojis: [DiscordEmoji],
                onGuild guild: DiscordGuild)
}

public extension DiscordClientDelegate {
    /// Default.
    func client(_ client: DiscordClient, didConnect connected: Bool) { }

    /// Default.
    func client(_ client: DiscordClient, didDisconnectWithReason reason: DiscordGatewayCloseReason, closed: Bool) { }

    /// Default.
    func client(_ client: DiscordClient, shouldAttemptResuming reason: DiscordGatewayCloseReason, closed: Bool) -> Bool {
        false
    }

    /// Default.
    func client(_ client: DiscordClient, didCreateChannel channel: DiscordChannel) { }

    /// Default.
    func client(_ client: DiscordClient, didDeleteChannel channel: DiscordChannel) { }

    /// Default.
    func client(_ client: DiscordClient, didUpdateChannel channel: DiscordChannel) { }

    /// Default.
    func client(_ client: DiscordClient, didCreateThread thread: DiscordChannel) { }

    /// Default.
    func client(_ client: DiscordClient, didDeleteThread thread: DiscordChannel) { }

    /// Default.
    func client(_ client: DiscordClient, didUpdateThread thread: DiscordChannel) { }

    /// Default.
    func client(_ client: DiscordClient, didCreateGuild guild: DiscordGuild) { }

    /// Default.
    func client(_ client: DiscordClient, didDeleteGuild guild: DiscordGuild) { }

    /// Default.
    func client(_ client: DiscordClient, didUpdateGuild guild: DiscordGuild) { }

    /// Default.
    func client(_ client: DiscordClient, didAddGuildMember member: DiscordGuildMember) { }

    /// Default.
    func client(_ client: DiscordClient, didRemoveGuildMember member: DiscordGuildMember) { }

    /// Default.
    func client(_ client: DiscordClient, didUpdateGuildMember member: DiscordGuildMember) { }

    /// Default.
    func client(_ client: DiscordClient, didCreateRole role: DiscordRole, onGuild guild: DiscordGuild) { }

    /// Default.
    func client(_ client: DiscordClient, didDeleteRole role: DiscordRole, fromGuild guild: DiscordGuild) { }

    /// Default.
    func client(_ client: DiscordClient, didUpdateRole role: DiscordRole, onGuild guild: DiscordGuild) { }

    /// Default.
    func client(_ client: DiscordClient, didUpdateMessage message: DiscordMessage) { }

    /// Default.
    func client(_ client: DiscordClient, didCreateMessage message: DiscordMessage) { }

    /// Default.
    func client(_ client: DiscordClient, didAddReaction reaction: DiscordEmoji, toMessage messageID: MessageID, onChannel channel: DiscordChannel, user userID: UserID) { }

    /// Default.
    func client(_ client: DiscordClient, didRemoveReaction reaction: DiscordEmoji, fromMessage messageID: MessageID, onChannel channel: DiscordChannel, user userID: UserID) { }

    /// Default.
    func client(_ client: DiscordClient, didRemoveAllReactionsFrom messageID: MessageID, onChannel channel: DiscordChannel) { }

    /// Default.
    func client(_ client: DiscordClient, didReceivePresenceUpdate presence: DiscordPresence) { }

    /// Default.
    func client(_ client: DiscordClient, didCreateInteraction interaction: DiscordInteraction) { }

    /// Default.
    func client(_ client: DiscordClient, didReceiveReady event: DiscordReadyEvent) { }

    /// Default.
    func client(_ client: DiscordClient, didReceiveVoiceStateUpdate voiceState: DiscordVoiceState) { }

    /// Default.
    func client(_ client: DiscordClient, didHandleGuildMemberChunk chunk: [DiscordGuildMember],
                forGuild guild: DiscordGuild) { }

    /// Default.
    func client(_ client: DiscordClient, didNotHandleDispatchEvent event: DiscordDispatchEvent) { }

    /// Default.
    func client(_ client: DiscordClient, didUpdateEmojis emojis: [DiscordEmoji],
                onGuild guild: DiscordGuild) { }

}
