// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "geocoding_darwin",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "geocoding-darwin", targets: ["geocoding_darwin"])
    ],
    targets: [
        .target(
            name: "geocoding_darwin",
            resources: [
                .process("PrivacyInfo.xcprivacy"),
            ],
            cSettings: [
                .headerSearchPath("include/geocoding_darwin")
            ]
        )
    ]
)
