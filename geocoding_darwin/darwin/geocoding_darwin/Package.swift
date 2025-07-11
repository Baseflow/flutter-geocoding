// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "geocoding_darwin",
    platforms: [
        .iOS("12.0"),
        .macOS("10.15")
    ],
    products: [
        .library(name: "geocoding-darwin", targets: ["geocoding_darwin"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "geocoding_darwin",
            dependencies: [],
            resources: [
                .process("PrivacyInfo.xcprivacy"),
            ],
        )
    ]
)