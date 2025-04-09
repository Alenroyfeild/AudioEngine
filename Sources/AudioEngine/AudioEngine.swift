//
//  AudioEngine.swift
//  AudioEngine
//
//  Created by Therla Venkata Balaji Royal on 08/04/25.
//

import SwiftOGG
import SFBAudioEngine
import Foundation

/// A utility class that handles audio file conversion between supported formats.
///
/// Depending on the input format, it delegates the conversion to either a general-purpose converter
/// (`SFBAudioEngine`) or a format-specific one (e.g., `SwiftOgg` for `.ogg` and `.oga` formats).
public class AudioEngine {
    
    /// Converts an audio file from one format to another as specified in the request.
    ///
    /// - Parameter request: A configured `AudioConversionRequest` containing source, destination, and format details.
    /// - Returns: A boolean indicating the success of the conversion.
    /// - Throws: `AudioEngineError` if the file does not exist or the conversion fails.
    public static func convert(request: AudioConversionRequest) async throws -> Bool {
        guard FileManager.default.fileExists(atPath: request.sourceURL.path) else {
            throw AudioEngineError.fileNotFound(request.sourceURL)
        }
        
        switch request.inputFormat {
        case .ogg, .oga:
            return try await convertOggTom4a(request: request)
        default:
            return try await convertAudio(request: request)
        }
    }
}

// MARK: - Ogg/Oga Conversion

extension AudioEngine {
    
    /// Converts `.ogg` or `.oga` files to `.m4a` using SwiftOgg.
    ///
    /// - Parameter request: A request containing `.ogg`/`.oga` input format and `.m4a` output.
    /// - Throws: `AudioEngineError.conversionFailed` if the conversion fails.
    private static func convertOggTom4a(request: AudioConversionRequest) async throws -> Bool {
        do {
            try OGGConverter.convertOpusOGGToM4aFile(src: request.sourceURL, dest: request.outputURL)
            return true
        } catch {
            throw AudioEngineError.conversionFailed(reason: error.localizedDescription)
        }
    }
}

// MARK: - General Conversion

extension AudioEngine {
    
    /// Converts any other supported audio formats using SFBAudioEngine.
    ///
    /// - Parameter request: A request containing supported formats (e.g., `.mp3`, `.wav`, `.m4a`, `.amr`).
    /// - Throws: `AudioEngineError.conversionFailed` if the conversion fails.
    private static func convertAudio(request: AudioConversionRequest) async throws -> Bool {
        do {
            try AudioConverter.convert(request.sourceURL, to: request.outputURL)
            return true
        } catch {
            throw AudioEngineError.conversionFailed(reason: error.localizedDescription)
        }
    }
}

