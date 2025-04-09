//
//  AudioConversionRequest.swift
//  AudioEngine
//
//  Created by Therla Venkata Balaji Royal on 08/04/25.
//

import Foundation

/// A model representing a request to convert an audio file from one format to another.
///
/// `AudioConversionRequest` is used by `AudioEngine` to perform audio format conversions.
/// It encapsulates the necessary metadata required for the conversion, including the source and destination URLs and formats.
public struct AudioConversionRequest {
    
    /// The file URL of the source audio file to be converted.
    public let sourceURL: URL
    
    /// The format of the input audio file.
    public let inputFormat: AudioFormat
    
    /// The desired output format for the audio file.
    public let outputFormat: AudioFormat
    
    /// The file URL where the converted audio file will be saved.
    public let outputURL: URL
    
    /// Initializes a new audio conversion request.
    ///
    /// - Parameters:
    ///   - sourceURL: The URL of the input audio file.
    ///   - inputFormat: The format of the input file.
    ///   - outputFormat: The format you want to convert the file to.
    ///   - outputURL: The destination URL where the output file should be saved.
    public init(
        sourceURL: URL,
        inputFormat: AudioFormat,
        outputFormat: AudioFormat,
        outputURL: URL
    ) {
        self.sourceURL = sourceURL
        self.inputFormat = inputFormat
        self.outputFormat = outputFormat
        self.outputURL = outputURL
    }
}
