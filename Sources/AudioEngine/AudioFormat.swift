//
//  AudioFormat.swift
//  AudioEngine
//
//  Created by Therla Venkata Balaji Royal on 08/04/25.
//

/// Represents supported audio formats for conversion operations.
///
/// Each case in `AudioFormat` corresponds to a commonly used audio format that can be used as an input or output in audio conversion processes.
public enum AudioFormat: String, CaseIterable {
    /// MPEG-4 Audio format (.m4a)
    case m4a
    /// MPEG Layer III Audio format (.mp3)
    case mp3
    /// Waveform Audio File format (.wav)
    case wav
    /// Ogg Vorbis format (.ogg)
    case ogg
    /// Ogg Audio format, often synonymous with `.ogg` but may indicate container-specific variations (.oga)
    case oga
    /// MPEG Audio format (.mpeg)
    case mpeg
    /// Adaptive Multi-Rate Audio Codec format (.amr)
    case amr
    
    /// The file extension associated with the audio format.
    ///
    /// This value matches the raw value of the enum case.
    public var fileExtension: String {
        return rawValue
    }
    
    /// The MIME type associated with the audio format.
    ///
    /// This is useful when working with HTTP requests, file uploads, or media metadata.
    public var mimeType: String {
        switch self {
        case .m4a: return "audio/m4a"
        case .mp3: return "audio/mpeg"
        case .wav: return "audio/wav"
        case .ogg, .oga: return "audio/ogg"
        case .mpeg: return "audio/mpeg"
        case .amr: return "audio/amr"
        }
    }
}

