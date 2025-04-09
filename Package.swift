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
        .package(url: "https://github.com/sbooth/SFBAudioEngine.git", from: "0.7.1"),
        .package(url: "https://github.com/element-hq/swift-ogg", from: "0.0.3")
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
