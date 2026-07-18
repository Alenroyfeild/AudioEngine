import Foundation
import XCTest
@testable import AudioEngine

final class AudioConversionRequestBuilderTests: XCTestCase {
    func testOggInputForcesM4AOutputAndGeneratesDestination() throws {
        let source = URL(fileURLWithPath: "/tmp/voice.ogg")

        let request = try AudioConversionRequestBuilder()
            .setSourceURL(source)
            .setInputFormat(.ogg)
            .setOutputFormat(.mp3)
            .build()

        XCTAssertEqual(request.inputFormat, .ogg)
        XCTAssertEqual(request.outputFormat, .m4a)
        XCTAssertEqual(request.outputURL, URL(fileURLWithPath: "/tmp/voice_converted.m4a"))
    }

    func testConfiguredOutputIsPreserved() throws {
        let source = URL(fileURLWithPath: "/tmp/source.wav")
        let destination = URL(fileURLWithPath: "/tmp/export.mp3")

        let request = try AudioConversionRequestBuilder()
            .setSourceURL(source)
            .setInputFormat(.wav)
            .setOutputFormat(.mp3)
            .setOutputURL(destination)
            .build()

        XCTAssertEqual(request.outputURL, destination)
        XCTAssertEqual(request.outputFormat, .mp3)
    }

    func testMissingSourceThrows() {
        XCTAssertThrowsError(
            try AudioConversionRequestBuilder()
                .setInputFormat(.wav)
                .setOutputFormat(.mp3)
                .build()
        )
    }
}
