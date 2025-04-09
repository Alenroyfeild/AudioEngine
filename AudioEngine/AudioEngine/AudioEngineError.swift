//
//  AudioEngineError.swift
//  AudioEngine
//
//  Created by Therla Venkata Balaji Royal on 09/04/25.
//

import Foundation

/// An error type representing various failures that can occur during audio conversion operations.
///
/// `AudioEngineError` is used throughout the `AudioEngine` system to describe problems such as invalid input files,
/// unsupported format conversions, or runtime errors encountered during encoding or decoding.
///
/// You can inspect the specific case to determine what went wrong and provide meaningful feedback to the user.
public enum AudioEngineError: Error, LocalizedError {
    
    /// The requested conversion is not supported between the provided input and output formats.
    ///
    /// This typically occurs when the combination of input and output types is not supported by the underlying engine.
    /// For example, converting from `.oga` to `.mp3` might not be supported.
    case unsupportedConversion(from: AudioFormat, to: AudioFormat)
    
    /// The file at the specified URL could not be found.
    ///
    /// This error is thrown if the `sourceURL` provided in the conversion request does not point to an existing file.
    case fileNotFound(URL)
    
    /// The file at the specified URL is invalid or cannot be interpreted as a valid audio file.
    ///
    /// This may happen if the file is corrupted, has an unsupported codec, or is not an audio file.
    case invalidFile(URL)
    
    /// A general-purpose error indicating that the conversion process failed for a given reason.
    ///
    /// This is used to surface failures from underlying libraries (e.g., encoder or decoder errors),
    /// or when a specific failure reason needs to be propagated.
    case conversionFailed(reason: String)
    
    /// A localized error message describing what went wrong.
    public var errorDescription: String? {
        switch self {
        case .unsupportedConversion(let from, let to):
            return "Conversion from '\(from.rawValue)' to '\(to.rawValue)' is not supported."
        case .fileNotFound(let url):
            return "The file at path '\(url.path)' was not found."
        case .invalidFile(let url):
            return "The file at path '\(url.path)' is not a valid or readable audio file."
        case .conversionFailed(let reason):
            return "Audio conversion failed: \(reason)"
        }
    }
}

