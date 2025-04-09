// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AudioEngine",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AudioEngine",
            targets: ["AudioEngine"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/your-org/SFBAudioEngine.git", from: "1.0.0"),
        .package(url: "https://github.com/your-org/SwiftOgg.git", from: "1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AudioEngine",
            dependencies: [
                "SFBAudioEngine",
                "SwiftOgg"
            ],
            path: "Sources/AudioEngine"
        ),
        .testTarget(
            name: "AudioEngineTests",
            dependencies: ["AudioEngine"],
            path: "Tests/AudioEngineTests"
        )
    ]
)
