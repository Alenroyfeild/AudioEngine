//
//  AudioConversionRequestBuilder.swift
//  AudioEngine
//
//  Created by Therla Venkata Balaji Royal on 09/04/25.
//

import Foundation

/*
 Sample Usage – AudioConversionRequestBuilder
 
 The builder pattern makes it easy to construct audio conversion requests
 while handling special format rules and defaults internally.
 
 - For input types `.ogg` and `.oga`, the output format will be set to `.m4a` automatically.
 - For all other input formats, output format is configurable using `.setOutputFormat(_:)`.
 - If `outputURL` is not configured, a default output URL will be generated
 using the source file name and desired output format.
 
 Examples:
 // 🟢 Input type: .oga → Output automatically set to .m4a, output URL auto-generated
 let request = try AudioConversionRequestBuilder()
     .setSourceURL(inputURL)
     .setInputFormat(.oga)
     .build()

 // 🔄 Input type: .m4a → Custom output format and auto-generated output URL
 let request2 = try AudioConversionRequestBuilder()
     .setSourceURL(inputURL)
     .setInputFormat(.m4a)
     .setOutputFormat(.mp3)
     .build()

 // 🔧 Input type: .wav → Custom output format and output URL explicitly set
 let request3 = try AudioConversionRequestBuilder()
     .setSourceURL(inputURL)
     .setInputFormat(.wav)
     .setOutputFormat(.ogg)
     .setOutputURL(customOutputURL)
     .build()
*/

public final class AudioConversionRequestBuilder {
    private var sourceURL: URL?
    private var inputFormat: AudioFormat?
    private var outputFormat: AudioFormat?
    private var outputURL: URL?
    
    public init() {}
    
    /// Sets the input file URL.
    @discardableResult
    public func setSourceURL(_ url: URL) -> Self {
        self.sourceURL = url
        return self
    }
    
    /// Sets the input format. Automatically sets output to `.m4a` if input is `.ogg` or `.oga`.
    @discardableResult
    public func setInputFormat(_ format: AudioFormat) -> Self {
        self.inputFormat = format
        
        // Automatically force output to `.m4a` for `.ogg` or `.oga`
        if format == .ogg || format == .oga {
            self.outputFormat = .m4a
        }
        
        return self
    }
    
    /// Sets the desired output format, if allowed.
    ///
    /// Will be ignored for `.ogg` or `.oga` inputs where `.m4a` is enforced.
    @discardableResult
    public func setOutputFormat(_ format: AudioFormat) -> Self {
        if inputFormat == .ogg || inputFormat == .oga {
            return self // Silently ignore or optionally log a debug warning
        }
        
        self.outputFormat = format
        return self
    }
    
    /// Optionally sets a custom output file URL.
    @discardableResult
    public func setOutputURL(_ url: URL) -> Self {
        self.outputURL = url
        return self
    }
    
    /// Validates and builds the final `AudioConversionRequest`.
    ///
    /// Will generate `outputURL` if not explicitly set.
    public func build() throws -> AudioConversionRequest {
        guard let sourceURL else {
            throw AudioEngineError.conversionFailed(reason: "Source URL is not set.")
        }
        
        guard let inputFormat else {
            throw AudioEngineError.conversionFailed(reason: "Input format is not set.")
        }
        
        guard let outputFormat else {
            throw AudioEngineError.conversionFailed(reason: "Output format is not set.")
        }
        
        // Enforce output format validation if needed
        if (inputFormat == .oga || inputFormat == .ogg) && outputFormat != .m4a {
            throw AudioEngineError.unsupportedConversion(from: inputFormat, to: outputFormat)
        }
        
        let finalOutputURL = outputURL ?? generateDefaultOutputURL(from: sourceURL, format: outputFormat)
        
        return AudioConversionRequest(
            sourceURL: sourceURL,
            inputFormat: inputFormat,
            outputFormat: outputFormat,
            outputURL: finalOutputURL
        )
    }
    
    /// Generates a default output URL in the same folder with `_converted` suffix and new extension.
    private func generateDefaultOutputURL(from source: URL, format: AudioFormat) -> URL {
        let baseName = source.deletingPathExtension().lastPathComponent
        let folder = source.deletingLastPathComponent()
        let fileName = "\(baseName)_converted.\(format.fileExtension)"
        return folder.appendingPathComponent(fileName)
    }
}
