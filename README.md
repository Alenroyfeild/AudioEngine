# AudioEngine

AudioEngine is a small iOS Swift package that presents one request-based API for audio conversion. It routes OGG/OGA input through [`swift-ogg`](https://github.com/element-hq/swift-ogg) and other declared formats through [`SFBAudioEngine`](https://github.com/sbooth/SFBAudioEngine).

This repository is a focused wrapper and learning project. It does not claim to replace the underlying codec libraries or provide benchmarked performance guarantees.

## What it demonstrates

- Swift Package Manager library design
- An async, throwing conversion boundary
- A builder that validates required input and creates a default output URL
- Format-specific routing and typed errors
- Dependency-backed audio conversion without exposing dependency APIs to callers

## Requirements

- iOS 15+
- Swift 5.7+
- Xcode 14+

## Installation

In Xcode, select **File → Add Package Dependencies** and enter:

```text
https://github.com/Alenroyfeild/AudioEngine.git
```

The repository does not currently publish a tagged semantic version. When adding it, select the `main` branch or pin an exact commit. A tagged release should be preferred once one is available.

## Usage

```swift
import AudioEngine

let request = try AudioConversionRequestBuilder()
    .setSourceURL(inputURL)
    .setInputFormat(.wav)
    .setOutputFormat(.mp3)
    .setOutputURL(outputURL)
    .build()

let didConvert = try await AudioEngine.convert(request: request)
```

For OGG/OGA input, the builder fixes the output format to M4A:

```swift
let request = try AudioConversionRequestBuilder()
    .setSourceURL(oggURL)
    .setInputFormat(.ogg)
    .build()

try await AudioEngine.convert(request: request)
```

When no output URL is supplied, the builder writes beside the source using `<name>_converted.<extension>`.

## Declared formats and routing

| Input | Requested output | Route |
| --- | --- | --- |
| OGG, OGA | M4A (enforced) | `swift-ogg` |
| M4A, MP3, WAV, MPEG, AMR | Caller-selected declared format | `SFBAudioEngine` |

Actual codec support depends on the underlying libraries and the audio content. A declared enum case is not a guarantee that every codec/container combination will convert successfully; failures are surfaced as `AudioEngineError`.

## Design

```text
AudioConversionRequestBuilder
        ↓ validates and supplies defaults
AudioConversionRequest
        ↓
AudioEngine.convert(request:)
        ├── OGG / OGA → swift-ogg → M4A
        └── other input → SFBAudioEngine AudioConverter
```

## Tests

The test target covers request-builder rules that do not require audio fixtures:

```bash
swift test
```

End-to-end codec tests with licensed fixture files are still to be added. See this as a transparent limitation, not an implied guarantee.

## License

AudioEngine is available under the [MIT License](LICENSE). Applications must also comply with the licenses of `SFBAudioEngine`, `swift-ogg`, and the codecs they use.
