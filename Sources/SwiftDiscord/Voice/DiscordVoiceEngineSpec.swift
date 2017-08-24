// The MIT License (MIT)
// Copyright (c) 2016 Erik Little

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

import COPUS
import Foundation

/// Declares that a type will be a voice engine.
public protocol DiscordVoiceEngineSpec : DiscordWebSocketable, DiscordGatewayable {
    // MARK: Properties

    /// The encoder for this engine. The encoder is responsible for turning raw audio data into OPUS encoded data.
    var source: DiscordVoiceEngineDataSource! { get }

    /// The secret key used for encryption.
    var secret: [UInt8]! { get }

    // MARK: Methods

    ///
    /// Stops encoding and requests a new encoder. A `voiceEngine.ready` event will be fired when the encoder is ready.
    ///
    func requestNewDataSource() throws

    ///
    /// Sends whether we are speaking or not.
    ///
    /// - parameter speaking: Our speaking status.
    ///
    func sendSpeaking(_ speaking: Bool)

    ///
    /// Sends OPUS encoded voice data to Discord.
    ///
    /// - parameter data: An array of OPUS encoded voice data.
    ///
    func sendVoiceData(_ data: [UInt8])

    #if !os(iOS)
    ///
    /// Takes a process that outputs random audio data, and sends it to a hidden FFmpeg process that turns the data
    /// into raw PCM.
    ///
    /// Example setting up youtube-dl to play music.
    ///
    /// ```swift
    /// youtube = EncoderProcess()
    /// youtube.launchPath = "usrlocalbinyoutube-dl"
    /// youtube.arguments = ["-f", "bestaudio", "-q", "-o", "-", link]
    ///
    /// voiceEngine.setupMiddleware(youtube) {
    ///     print("youtube died")
    /// }
    /// ```
    ///
    /// - parameter middleware: The process that will output audio data.
    /// - parameter terminationHandler: Called when the middleware is done. Does not mean that all encoding is done.
    ///
    func setupMiddleware(_ middleware: Process, terminationHandler: (() -> ())?)
    #endif
}

/// Declares that a type will be a client for a voice engine.
public protocol DiscordVoiceEngineDelegate : class {
    // MARK: Methods

    ///
    /// Handles received opus voice data from a voice engine.
    ///
    /// - parameter data: The voice data that was received
    ///
    func voiceEngine(_ engine: DiscordVoiceEngine, didReceiveOpusVoiceData data: DiscordOpusVoiceData)

    ///
    /// Handles received raw voice data from a voice engine.
    ///
    /// - parameter data: The voice data that was received
    ///
    func voiceEngine(_ engine: DiscordVoiceEngine, didReceiveRawVoiceData data: DiscordRawVoiceData)

    ///
    /// Called when the voice engine disconnects.
    ///
    /// - parameter engine: The engine that disconnected.
    ///
    func voiceEngineDidDisconnect(_ engine: DiscordVoiceEngine)

    ///
    /// Called when the voice engine needs an encoder.
    ///
    /// - parameter engine: The engine that needs an encoder.
    /// - returns: An encoder.
    ///
    func voiceEngineNeedsDataSource(_ engine: DiscordVoiceEngine) throws -> DiscordVoiceEngineDataSource?

    ///
    /// Called when the voice engine is ready.
    ///
    /// - parameter engine: The engine that's ready.
    ///
    func voiceEngineReady(_ engine: DiscordVoiceEngine)
}

/// Specifies that a type will be a data source for a VoiceEngine.
public protocol DiscordVoiceEngineDataSource {
    // MARK: Properties

    /// The size of a frame in samples per channel. Needed to calculate the maximum size of a frame.
    var frameSize: Int { get }

    // MARK: Methods

    ///
    /// Called when the engine needs voice data. If there is no more data left,
    /// a `DiscordVoiceEngineDataSourceStatus.done` error should be thrown.
    ///
    /// - parameter engine: The voice engine that needs data.
    /// - returns: An array of Opus encoded bytes.
    ///
    func engineNeedsData(_ engine: DiscordVoiceEngine) throws -> [UInt8]

    ///
    /// Call when you want data collection to stop.
    ///
    func finishUpAndClose()

    /// Causes the internal `DispatchIO` to start reading.
    func startReading()
}

/// Used to report the status of a data request if data could not be returned.
public enum DiscordVoiceEngineDataSourceStatus : Error {
    /// Thrown when there is no more data left to be consumed.
    case done

    /// Thrown when an error occurs during a request.
    case error

    /// Thrown when there is no data to be read.
    case noData
}

/// Declares that a type has enough information to encode/decode Opus data.
public protocol DiscordOpusCodeable {
    // MARK: Properties

    /// The number of channels.
    var channels: Int { get }

    /// The sampling rate.
    var sampleRate: Int { get }

    // MARK: Methods

    ///
    /// Returns the maximum number of bytes that a frame can contain given a
    /// frame size in number of samples per channel.
    ///
    /// - parameter assumingSize: The size of the frame, in number of samples per channel.
    /// - returns: The number of bytes in this frame.
    ///
    func maxFrameSize(assumingSize size: Int) -> Int
}

public extension DiscordOpusCodeable {
    ///
    /// Returns the maximum number of bytes that a frame can contain given a
    /// frame size in number of samples per channel.
    ///
    /// - parameter assumingSize: The size of the frame, in number of samples per channel.
    /// - returns: The number of bytes in this frame.
    ///
    public func maxFrameSize(assumingSize size: Int) -> Int {
        return size * channels * MemoryLayout<opus_int16>.size
    }
}

/// A struct that is used to configure the high-level functions of a VoiceEngine
public struct DiscordVoiceEngineConfiguration {
    /// Whether or not this engine should capture voice.
    public var captureVoice = true

    /// Whether or not this engine should try and decode incoming voice into raw PCM.
    public var decodeVoice = false
}
