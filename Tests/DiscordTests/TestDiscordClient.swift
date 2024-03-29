//
// Created by Erik Little on 3/26/17.
//

import Foundation
import XCTest
@testable import Discord

public class TestDiscordClient: XCTestCase, DiscordClientDelegate {
    func testClientCreatesGuild() {
        expectations[.guildCreate] = expectation(description: "Client should call guild create method")

        client.handleDispatch(event: .guildCreate(testGuild))

        waitForExpectations(timeout: 0.2)
    }

    func testClientUpdatesGuild() {
        expectations[.guildCreate] = expectation(description: "Client should call guild create method")
        expectations[.guildUpdate] = expectation(description: "Client should call guild update method")

        client.handleDispatch(event: .guildCreate(testGuild))
        client.handleDispatch(event: .guildUpdate(.init(
            id: 100,
            name: "A new name"
        )))

        waitForExpectations(timeout: 0.2)
    }

    func testClientDeletesGuild() {
        expectations[.guildCreate] = expectation(description: "Client should call guild create method")
        expectations[.guildDelete] = expectation(description: "Client should call guild delete method")

        client.handleDispatch(event: .guildCreate(testGuild))

        // Force guild's channels into the channel cache
        for channelId in (testGuild.channels ?? [:]).keys {
            _ = client.findChannel(fromId: channelId)
        }

        client.handleDispatch(event: .guildDelete(.init(id: testGuild.id)))

        waitForExpectations(timeout: 0.2)
    }

    func testClientHandlesGuildMemberAdd() {
        expectations[.guildCreate] = expectation(description: "Client should call guild create method")
        expectations[.guildMemberAdd] = expectation(description: "Client should call guild member add method")

        var tMember = testMember
        var tUser = testUser

        tUser.id = 30
        tMember.guildId = 100
        tMember.user = tUser
        tMember.nick = "test nick"

        client.handleDispatch(event: .guildCreate(testGuild))
        client.handleDispatch(event: .guildMemberAdd(tMember))

        waitForExpectations(timeout: 0.2)
    }

    func testClientHandlesGuildMemberUpdate() {
        expectations[.guildCreate] = expectation(description: "Client should call guild member update method")
        expectations[.guildMemberUpdate] = expectation(description: "Client should call guild member update method")

        var tMember = testMember
        var tUser = testUser

        tUser.id = 15
        tMember.guildId = 100
        tMember.user = tUser
        tMember.nick = "a new nick"

        client.handleDispatch(event: .guildCreate(testGuild))
        client.handleDispatch(event: .guildMemberUpdate(tMember))

        waitForExpectations(timeout: 0.2)
    }

    func testClientHandlesGuildMemberRemove() {
        expectations[.guildCreate] = expectation(description: "Client should call guild member remove method")
        expectations[.guildMemberRemove] = expectation(description: "Client should call guild member remove method")

        var tMember = testMember
        var tUser = testUser

        tUser.id = 15
        tMember.guildId = 100
        tMember.user = tUser

        client.handleDispatch(event: .guildCreate(testGuild))
        client.handleDispatch(event: .guildMemberRemove(.init(guildId: tMember.guildId!, user: tMember.user)))

        waitForExpectations(timeout: 0.2)
    }

    func testClientCreatesGuildChannel() {
        expectations[.guildCreate] = expectation(description: "Client should call guild member remove method")
        expectations[.channelCreate] = expectation(description: "Client should call create create method")

        var tChannel = testGuildTextChannel

        tChannel.id = 205
        tChannel.name = "A new channel"

        client.handleDispatch(event: .guildCreate(testGuild))
        client.handleDispatch(event: .channelCreate(tChannel))

        waitForExpectations(timeout: 0.2)
    }

    func testClientCreatesDMChannel() {
        expectations[.channelCreate] = expectation(description: "Client should call create create method")

        client.handleDispatch(event: .channelCreate(testDMChannel))

        waitForExpectations(timeout: 0.2)
    }

    func testClientCreatesGroupDMChannel() {
        expectations[.channelCreate] = expectation(description: "Client should call create create method")

        client.handleDispatch(event: .channelCreate(testGroupDMChannel))

        waitForExpectations(timeout: 0.2)
    }

    func testClientDeletesGuildChannel() {
        expectations[.guildCreate] = expectation(description: "Client should call guild member remove method")
        expectations[.channelCreate] = expectation(description: "Client should call channel create method")
        expectations[.channelDelete] = expectation(description: "Client should call delete channel method")

        var tChannel = testGuildTextChannel

        tChannel.id = 205
        tChannel.name = "A new channel"

        client.handleDispatch(event: .guildCreate(testGuild))
        client.handleDispatch(event: .channelCreate(tChannel))
        client.handleDispatch(event: .channelDelete(tChannel))

        waitForExpectations(timeout: 0.2)
    }

    func testClientDeletesGuildChannelCategory() {
        expectations[.guildCreate] = expectation(description: "Client should call guild member remove method")
        expectations[.channelCreate] = expectation(description: "Client should call channel create method")
        expectations[.channelDelete] = expectation(description: "Client should call delete channel method")

        var tChannel = testGuildChannelCategory

        tChannel.id = 205

        client.handleDispatch(event: .guildCreate(testGuild))
        client.handleDispatch(event: .channelCreate(tChannel))
        client.handleDispatch(event: .channelDelete(tChannel))

        waitForExpectations(timeout: 0.2)
    }

    func testClientDeletesDirectChannel() {
        expectations[.channelCreate] = expectation(description: "Client should call channel create method")
        expectations[.channelDelete] = expectation(description: "Client should call channel delete method")

        client.handleDispatch(event: .channelCreate(testDMChannel))
        client.handleDispatch(event: .channelDelete(testDMChannel))

        waitForExpectations(timeout: 0.2)
    }

    func testClientDeletesGroupDMChannel() {
        expectations[.channelCreate] = expectation(description: "Client should call create create method")
        expectations[.channelDelete] = expectation(description: "Client should call channel delete method")

        client.handleDispatch(event: .channelCreate(testGroupDMChannel))
        client.handleDispatch(event: .channelDelete(testGroupDMChannel))

        waitForExpectations(timeout: 0.2)
    }

    func testClientUpdatesGuildChannel() {
        expectations[.guildCreate] = expectation(description: "Client should call guild member remove method")
        expectations[.channelUpdate] = expectation(description: "Client should call update channel method")

        var tChannel = testGuildTextChannel

        tChannel.name = "A new channel"

        client.handleDispatch(event: .guildCreate(testGuild))
        client.handleDispatch(event: .channelUpdate(tChannel))

        waitForExpectations(timeout: 0.2)
    }

    func testClientUpdatesGuildChannelCategory() {
        expectations[.guildCreate] = expectation(description: "Client should call guild member remove method")
        expectations[.channelCreate] = expectation(description: "Client should create a category channel")
        expectations[.channelUpdate] = expectation(description: "Client should call update channel method")

        var tChannel = testGuildChannelCategory

        tChannel.id = 205
        tChannel.name = "A new channel"

        client.handleDispatch(event: .guildCreate(testGuild))
        client.handleDispatch(event: .channelCreate(tChannel))
        client.handleDispatch(event: .channelUpdate(tChannel))

        waitForExpectations(timeout: 0.2)
    }

    func testClientHandlesGuildEmojiUpdate() {
        expectations[.guildCreate] = expectation(description: "Client should call guild member remove method")
        expectations[.guildEmojisUpdate] = expectation(description: "Client should call guild emoji update method")

        client.handleDispatch(event: .guildCreate(testGuild))
        client.handleDispatch(event: .guildEmojisUpdate(.init(
            guildId: testGuild.id,
            emojis: createEmojiObjects(n: 20)
        )))

        waitForExpectations(timeout: 0.2)
    }

    func testClientHandlesRoleCreate() {
        expectations[.guildCreate] = expectation(description: "Client should call guild member remove method")
        expectations[.guildRoleCreate] = expectation(description: "Client should call guild role create method")

        client.handleDispatch(event: .guildCreate(testGuild))
        client.handleDispatch(event: .guildRoleCreate(.init(
            guildId: testGuild.id,
            role: testRole
        )))

        waitForExpectations(timeout: 0.2)
    }

    func testClientHandlesRoleUpdate() {
        expectations[.guildCreate] = expectation(description: "Client should call guild member remove method")
        expectations[.guildRoleCreate] = expectation(description: "Client should call guild role create method")
        expectations[.guildRoleUpdate] = expectation(description: "Client should call guild role update method")

        var event = DiscordGuildRoleCreateEvent(
            guildId: testGuild.id,
            role: testRole
        )

        client.handleDispatch(event: .guildCreate(testGuild))
        client.handleDispatch(event: .guildRoleCreate(event))

        event.role.name = "A dank role"

        client.handleDispatch(event: .guildRoleUpdate(event))

        waitForExpectations(timeout: 0.2)
    }

    func testClientHandlesRoleRemove() {
        expectations[.guildCreate] = expectation(description: "Client should call guild member remove method")
        expectations[.guildRoleCreate] = expectation(description: "Client should call guild role create method")
        expectations[.guildRoleDelete] = expectation(description: "Client should call guild role delete method")

        client.handleDispatch(event: .guildCreate(testGuild))
        client.handleDispatch(event: .guildRoleCreate(.init(guildId: testGuild.id, role: testRole)))
        client.handleDispatch(event: .guildRoleDelete(.init(guildId: testGuild.id, roleId: testRole.id)))

        waitForExpectations(timeout: 0.2)
    }

    func testClientCallsUnhandledEventMethod() {
        expectations[.typingStart] = expectation(description: "Client should call the unhandled event method")

        client.handleDispatch(event: .typingStart(.init(channelId: testGuildTextChannel.id, guildId: testGuild.id, userId: testUser.id, timestamp: 0, member: nil)))

        waitForExpectations(timeout: 0.2)
    }

    func testClientFindsGuildTextChannel() {
        expectations[.guildCreate] = expectation(description: "Client should call guild create method")

        client.handleDispatch(event: .guildCreate(testGuild))

        assertFindChannel(channelFixture: testGuildTextChannel, channelType: .text)

        waitForExpectations(timeout: 0.2)
    }

    func testClientFindsGuildVoiceChannel() {
        expectations[.guildCreate] = expectation(description: "Client should call guild create method")

        client.handleDispatch(event: .guildCreate(testGuild))

        assertFindChannel(channelFixture: testGuildVoiceChannel, channelType: .voice)

        waitForExpectations(timeout: 0.2)
    }

    func testClientFindsDirectChannel() {
        expectations[.channelCreate] = expectation(description: "Client should call guild create method")

        client.handleDispatch(event: .channelCreate(testDMChannel))

        assertFindChannel(channelFixture: testDMChannel, channelType: .dm)

        waitForExpectations(timeout: 0.2)
    }

    func testClientFindsGroupDMChannel() {
        expectations[.channelCreate] = expectation(description: "Client should call guild create method")

        client.handleDispatch(event: .channelCreate(testGroupDMChannel))

        assertFindChannel(channelFixture: testDMChannel, channelType: .groupDM)

        waitForExpectations(timeout: 0.2)
    }

    func testClientCorrectlyAddsPresenceToGuild() {
        expectations[.guildCreate] = expectation(description: "Client should call guild create method")
        expectations[.presenceUpdate] = expectation(description: "Client should call presence update method")

        client.handleDispatch(event: .guildCreate(testGuild))
        client.handleDispatch(event: .presenceUpdate(testPresence))

        waitForExpectations(timeout: 0.2)
    }

    func testClientCorrectlyCreatesMessage() {
        expectations[.messageCreate] = expectation(description: "Client should call the message create method")

        client.handleDispatch(event: .messageCreate(testMessage))

        waitForExpectations(timeout: 0.2)
    }

    func testClientCreatesThread() {
        expectations[.threadCreate] = expectation(description: "Client should create thread")

        client.handleDispatch(event: .guildCreate(testGuild))
        client.handleDispatch(event: .threadCreate(testThread))

        waitForExpectations(timeout: 0.2)
    }

    func testClientArchivesThread() {
        expectations[.threadCreate] = expectation(description: "Client should create thread")
        expectations[.threadUpdate] = expectation(description: "Client should update thread")

        var thread = testThread
        thread.threadMetadata = DiscordThreadMetadata(
            archived: false,
            autoArchiveDuration: 60,
            archiveTimestamp: Date(),
            locked: false
        )

        client.handleDispatch(event: .guildCreate(testGuild))
        client.handleDispatch(event: .threadCreate(thread))

        thread.threadMetadata?.archived = true
        client.handleDispatch(event: .threadUpdate(thread))

        waitForExpectations(timeout: 0.2)
    }

    func testClientDeletesThread() {
        expectations[.threadCreate] = expectation(description: "Client should create thread")
        expectations[.threadDelete] = expectation(description: "Client should delete thread")

        client.handleDispatch(event: .guildCreate(testGuild))
        client.handleDispatch(event: .threadCreate(testThread))
        client.handleDispatch(event: .threadDelete(testThread))

        waitForExpectations(timeout: 0.2)
    }

    var client: DiscordClient!
    var expectations = [DiscordDispatchEventType: XCTestExpectation]()

    public override func setUp() {
        client = DiscordClient(token: "Testing", delegate: self)
        expectations = [DiscordDispatchEventType: XCTestExpectation]()
    }
}

extension TestDiscordClient {
    // MARK: Channel testing

    enum ChannelTestType {
        case create
        case delete
    }

    func assertGuildChannel(_ channel: DiscordChannel, expectedGuildChannels expected: Int,
                            testType type: ChannelTestType) {
        guard let clientGuild = client.guilds[channel.guildId!] else {
            XCTFail("Guild for channel should be in guilds")
            return
        }

        switch type {
        case .create:
            XCTAssertEqual(clientGuild.channels?[channel.id]?.id, channel.id, "Channels should be the same")
        case .delete:
            XCTAssertNil(clientGuild.channels?[channel.id], "Channel should be removed from guild")
        }

        XCTAssertEqual(clientGuild.channels?.count, expected, "Number of channels should be predictable")
    }

    func assertDMChannel(_ channel: DiscordChannel, testType type: ChannelTestType) {
        switch type {
        case .create:
            XCTAssertNotNil(client.directChannels[channel.id], "Created DM Channel should be in direct channels")
        case .delete:
            XCTAssertNil(client.directChannels[channel.id], "Deleted DM Channel should not be in direct channels")
        }

        XCTAssertEqual(channel.id, testUser.id, "Channel create should index channels by recipient id")
    }

    func assertGroupDMChannel(_ channel: DiscordChannel, testType type: ChannelTestType) {
        switch type {
        case .create:
            XCTAssertNotNil(client.directChannels[channel.id], "Created Group DM Channel should be in direct channels")
        case .delete:
            XCTAssertNil(client.directChannels[channel.id], "Deleted Group DM Channel should not be in direct channels")
        }

        XCTAssertEqual(channel.name, "A Group DM", "Channel create should index channels by recipient id")
    }

    func assertFindChannel(channelFixture: DiscordChannel, channelType: DiscordChannelType) {
        guard let channel = client.findChannel(fromId: channelFixture.id) else {
            XCTFail("Client did not find channel")

            return
        }

        XCTAssertEqual(channel.id, channelFixture.id, "findChannel should find the correct channel")
        XCTAssertNotNil(client.channelCache[channel.id], "Found channel should be in cache")
    }
}

public extension TestDiscordClient {
    // MARK: DiscordClientDelegate

    func client(_ client: DiscordClient, didCreateChannel channel: DiscordChannel) {
        switch channel.type {
        case .dm:
            assertDMChannel(channel, testType: .create)
        case .groupDM:
            assertGroupDMChannel(channel, testType: .create)
        default:
            assertGuildChannel(channel, expectedGuildChannels: 3, testType: .create)
        }

        expectations[.channelCreate]?.fulfill()
    }

    func client(_ client: DiscordClient, didDeleteChannel channel: DiscordChannel) {
        switch channel.type {
        case .dm:
            assertDMChannel(channel, testType: .delete)
        case .groupDM:
            assertGroupDMChannel(channel, testType: .delete)
        default:
            assertGuildChannel(channel, expectedGuildChannels: 2, testType: .delete)
        }

        expectations[.channelDelete]?.fulfill()
    }

    func client(_ client: DiscordClient, didUpdateChannel channel: DiscordChannel) {
        guard let guildId = channel.guildId else {
            XCTFail("Channel has no guild id")
            return
        }

        guard let clientGuild = client.guilds[guildId] else {
            XCTFail("Guild for channel should be in guilds")
            return
        }

        switch channel.type {
        case .category:
            XCTAssertEqual(clientGuild.channels?.count, 3, "Guild should have three channels")
            XCTAssertEqual(channel.name, "A new channel", "A new channel should have been updated")
        default:
            XCTAssertEqual(clientGuild.channels?.count, 2, "Guild should have two channels")
            XCTAssertEqual(channel.name, "A new channel", "A new channel should have been updated")
        }

        expectations[.channelUpdate]?.fulfill()
    }

    func client(_ client: DiscordClient, didCreateThread thread: DiscordChannel) {
        guard let guildId = thread.guildId else {
            XCTFail("Thread has no guild id")
            return
        }

        guard let clientGuild = client.guilds[guildId] else {
            XCTFail("Guild for thread should be in guilds")
            return
        }

        XCTAssertEqual(clientGuild.threads?.count, 1, "Guild should have a thread")

        expectations[.threadCreate]?.fulfill()
    }

    func client(_ client: DiscordClient, didUpdateThread thread: DiscordChannel) {
        guard let guildId = thread.guildId else {
            XCTFail("Thread has no guild id")
            return
        }

        guard let clientGuild = client.guilds[guildId] else {
            XCTFail("Guild for thread should be in guilds")
            return
        }

        if thread.threadMetadata?.archived ?? false {
            XCTAssertEqual(clientGuild.threads?.count, 0, "Guild should have archived the thread")
        }

        expectations[.threadUpdate]?.fulfill()
    }

    func client(_ client: DiscordClient, didDeleteThread thread: DiscordChannel) {
        guard let guildId = thread.guildId else {
            XCTFail("Thread has no guild id")
            return
        }

        guard let clientGuild = client.guilds[guildId] else {
            XCTFail("Guild for thread should be in guilds")
            return
        }

        XCTAssertEqual(clientGuild.threads?.count, 0, "Guild should have deleted the thread")

        expectations[.threadDelete]?.fulfill()
    }

    func client(_ client: DiscordClient, didAddGuildMember member: DiscordGuildMember) {
        guard let guildId = member.guildId,
              let clientGuild = client.guilds[guildId] else {
            XCTFail("Guild for member should be in guilds")
            return
        }

        XCTAssertEqual(member.nick, "test nick", "Guild member add should correctly create a member")
        XCTAssertNotNil(clientGuild.members?[member.user.id], "Member should be in guild after being added")
        XCTAssertEqual(clientGuild.members?.count, 21, "Guild member add should correctly add a new member to members")
        XCTAssertEqual(clientGuild.memberCount, 21, "Guild member add should correctly increment the number of members")

        expectations[.guildMemberAdd]?.fulfill()
    }

    func client(_ client: DiscordClient, didRemoveGuildMember member: DiscordGuildMember) {
        guard let guildId = member.guildId,
              let clientGuild = client.guilds[guildId] else {
            XCTFail("Guild for member should be in guilds")
            return
        }

        XCTAssertNil(clientGuild.members?[member.user.id], "Guild member remove should remove member")
        XCTAssertEqual(clientGuild.members?.count, 19, "Guild member remove should correctly remove a member")
        XCTAssertEqual(clientGuild.memberCount, 19, "Guild member remove should correctly decrement the number of members")

        expectations[.guildMemberRemove]?.fulfill()
    }

    func client(_ client: DiscordClient, didUpdateGuildMember member: DiscordGuildMember) {
        guard let guildId = member.guildId,
              let guildMember = client.guilds[guildId]?.members?[member.user.id] else {
            XCTFail("Guild member should be in guild")
            return
        }

        XCTAssertEqual(guildMember.nick, "a new nick", "Member on guild should be updated")

        expectations[.guildMemberUpdate]?.fulfill()
    }

    func client(_ client: DiscordClient, didCreateGuild guild: DiscordGuild) {
        guard let clientGuild = client.guilds[guild.id] else {
            XCTFail("Guild should be in guilds")
            return
        }

        XCTAssertEqual(clientGuild.channels?.count, 2, "Created guild should have two channels")
        XCTAssertEqual(clientGuild.members?.count, 20, "Created guild should have 20 members")
        XCTAssertEqual(clientGuild.presences?.count, 20, "Created guild should have 20 presences")
        XCTAssert(guild.id == clientGuild.id, "Guild on the client should be the same as one passed to handler")

        expectations[.guildCreate]?.fulfill()
    }

    func client(_ client: DiscordClient, didDeleteGuild guild: DiscordGuild) {
        XCTAssertEqual(client.guilds.count, 0, "Client should have no guilds")
        for channel in (guild.channels ?? [:]).keys {
            XCTAssertNil(client.channelCache[channel], "Removing a guild should remove its channels from the channel cache")
        }
        XCTAssertEqual(guild.id, 100, "Test guild should be removed")

        expectations[.guildDelete]?.fulfill()
    }

    func client(_ client: DiscordClient, didUpdateGuild guild: DiscordGuild) {
        guard let clientGuild = client.guilds[guild.id] else {
            XCTFail("Guild should be in guilds")
            return
        }

        XCTAssertEqual(clientGuild.name, "A new name", "Guild should correctly update name")
        XCTAssert(guild.id == clientGuild.id, "Guild on the client should be the same as one passed to handler")

        expectations[.guildUpdate]?.fulfill()
    }

    func client(_ client: DiscordClient, didUpdateEmojis emojis: [DiscordEmoji],
                onGuild guild: DiscordGuild) {
        XCTAssertEqual(guild.emojis?.count, 20, "Update should have 20 emoji")

        expectations[.guildEmojisUpdate]?.fulfill()
    }

    func client(_ client: DiscordClient, didCreateMessage message: DiscordMessage) {
        XCTAssertEqual(message.content, testMessage.content, "Message content should be the same")
        XCTAssertEqual(message.channelId, testMessage.channelId, "Channel id should be the same")

        expectations[.messageCreate]?.fulfill()
    }

    func client(_ client: DiscordClient, didReceivePresenceUpdate presence: DiscordPresence) {
        XCTAssertEqual(presence.user.id, testUser.id, "Presence should be for the test user")
        XCTAssertNotNil(client.guilds[presence.guildId!]?.presences?[presence.user.id])

        expectations[.presenceUpdate]?.fulfill()
    }

    func client(_ client: DiscordClient, didCreateRole role: DiscordRole, onGuild guild: DiscordGuild) {
        guard let clientGuild = client.guilds[guild.id] else {
            XCTFail("Guild should be in guilds")
            return
        }

        XCTAssertNotNil(clientGuild.roles?[role.id], "Role should be in guild")
        XCTAssertEqual(role.name, "My Test Role", "Role create should correctly make role")

        expectations[.guildRoleCreate]?.fulfill()
    }

    func client(_ client: DiscordClient, didDeleteRole role: DiscordRole, fromGuild guild: DiscordGuild) {
        guard let clientGuild = client.guilds[guild.id] else {
            XCTFail("Guild should be in guilds")
            return
        }

        XCTAssertNil(clientGuild.roles?[role.id], "Role should not be in guild")
        XCTAssertEqual(role.name, "My Test Role", "Role create should correctly make role")

        expectations[.guildRoleDelete]?.fulfill()
    }

    func client(_ client: DiscordClient, didUpdateRole role: DiscordRole, onGuild guild: DiscordGuild) {
        guard let clientGuild = client.guilds[guild.id] else {
            XCTFail("Guild should be in guilds")
            return
        }

        XCTAssertNotNil(clientGuild.roles?[role.id], "Role should be in guild")
        XCTAssertEqual(role.name, "A dank role", "Role create should correctly update role")

        expectations[.guildRoleUpdate]?.fulfill()
    }

    func client(_ client: DiscordClient, didNotHandleDispatchEvent event: DiscordDispatchEvent) {
        expectations[.typingStart]?.fulfill()
    }

}

/// An empty class to make sure that all methods have default implementations.
class DummyDelegate: DiscordClientDelegate {}
