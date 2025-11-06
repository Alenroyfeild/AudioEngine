# 🎧 AudioEngine SDK – Advanced Audio Conversion for iOS

**AudioEngine SDK** is a lightweight, high-performance iOS framework that brings robust **audio format conversion** capabilities to your app—particularly for formats that Apple does **not support natively**, such as **OGG**, **OGA**, and **MPEG**.

Built on top of powerful open-source libraries like **SFBAudioEngine** and **SwiftOgg**, this SDK makes it easy to **convert, encode, and decode** a wide range of audio formats for both playback and processing.

---

## 🚀 Features

- 🔄 **Bidirectional Format Conversion**
  - Convert `.m4a`, `.wav` ➝ `.mp3`, `.ogg`
  - Convert `.ogg`, `.oga`, `.mpeg` ➝ `.mp3`, `.m4a`

- ⚙️ **Powered by Proven Libraries**
  - 🎧 **SFBAudioEngine**: High-quality encoding and decoding for MP3 and other popular formats
  - 🌀 **SwiftOgg**: Native support for Ogg and Oga formats

- 📱 **Seamless Integration**
  - Optimized for use in any iOS app requiring audio format compatibility
  - Straightforward API for converting files with minimal setup

---

## 📦 Installation

### Swift Package Manager (Recommended)

Add the following to your `Package.swift`:

```swift
.package(url: "https://github.com/Alenroyfeild/AudioEngine.git", from: "0.0.1")
```

Or via Xcode:

1. Go to **File > Add Packages**
2. Enter the repo URL: `https://github.com/your-org/AudioEngine.git`
3. Choose your version and target
4. Finish integration

> ✅ The SDK internally uses `SFBAudioEngine` and `SwiftOgg` for codec support — no extra configuration is required.

---

## 📌 Why Use AudioEngine SDK?

### ❌ Native iOS Limitations:
- No built-in support for **OGG**, **OGA**, and some **MPEG** formats
- Cannot **encode to MP3**
- `.m4a` (default iOS format) isn’t ideal for cross-platform use

### ✅ AudioEngine SDK Solves This By:
- Supporting conversion of audio to widely used formats like **MP3** and **OGG**
- Enabling your app to **play, upload, or share** non-native formats
- Offering a clean and modern API to handle audio format needs effortlessly

---

## 🔁 Example Conversion Scenarios

| Use Case              | Conversion Path                  |
|-----------------------|----------------------------------|
| Playback Support      | `.ogg`, `.mpeg` ➝ `.mp3`         |
| Upload Compatibility  | `.m4a`, `.wav` ➝ `.mp3`, `.ogg`  |
| Audio Processing      | Any ➝ Target format of choice    |

---

## 🧱 Usage

### Option 1: Manual Request Initialization

```swift
let request = AudioConversionRequest(
    sourceURL: inputFileURL,
    inputFormat: .wav,
    outputFormat: .mp3,
    outputURL: outputFileURL
)

try AudioEngine.shared.convert(request)
```

### Option 2: Using the Builder Pattern (Recommended)

```swift
let request = try AudioConversionRequestBuilder()
    .setSourceURL(inputFileURL)
    .setInputFormat(.ogg)
    .build()

try AudioEngine.shared.convert(request)
```

> ℹ️ **Note:** If the input format is `.ogg` or `.oga`, the output format is automatically set to `.m4a` and cannot be changed.

### Optional: Set Output Format and Output URL

```swift
let request = try AudioConversionRequestBuilder()
    .setSourceURL(inputFileURL)
    .setInputFormat(.wav)
    .setOutputFormat(.mp3)
    .setOutputURL(customOutputURL)
    .build()
```

---

## ⚙️ Format Handling Rules

- `.ogg` and `.oga` inputs:
  - Output format is **forced to `.m4a`**
  - Attempting to override will be ignored
- If `outputURL` is not set:
  - A default file will be generated in the same directory, with a `_converted` suffix

---

## ✅ Benefits

- 🧩 **Fills a Native Gap** – Adds support for audio formats missing on iOS
- ⚡ **Fast & Efficient** – Optimized for large audio files
- 🧪 **Production Ready** – Verified in real-world use cases
- 🛠️ **Extensible** – Easily fits into any audio pipeline

---

## 📂 Perfect For

- 🎙️ Audio recording or podcast apps
- 📤 Media upload and sharing tools
- 🎛️ Custom audio processing utilities
- 📱 Any iOS app needing format compatibility

---

## 🔐 Licensing & Maintenance

- ✅ Fully approved under licenses compatible with commercial apps
- 🔄 Maintained for compatibility with latest iOS versions
- 🛡️ Built-in error handling and fallbacks reduce failure risk

---

## 📣 Coming Soon

- 📊 Conversion progress monitoring
- 📁 Batch conversion API
- 🎚️ Output quality presets

---

## 💬 Need Help?

Open an issue or reach out to the maintainers via GitHub Discussions.

---

**AudioEngine SDK** gives you full control over audio formats—making your app more compatible, more powerful, and future-proof.

---

