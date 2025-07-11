// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
//  Generated file. Do not edit.
//

import PackageDescription

let package = Package(
    name: "FlutterGeneratedPluginSwiftPackage",
    platforms: [
        .macOS("10.15")
    ],
    products: [
        .library(name: "FlutterGeneratedPluginSwiftPackage", type: .static, targets: ["FlutterGeneratedPluginSwiftPackage"])
    ],
    dependencies: [
        .package(name: "url_launcher_macos", path: "/Users/maurits/.pub-cache/hosted/pub.dev/url_launcher_macos-3.2.2/macos/url_launcher_macos"),
        .package(name: "geocoding_darwin", path: "/Users/maurits/sources/Baseflow/Internal/Flutter/geocoding/geocoding_darwin/darwin/geocoding_darwin")
    ],
    targets: [
        .target(
            name: "FlutterGeneratedPluginSwiftPackage",
            dependencies: [
                .product(name: "url-launcher-macos", package: "url_launcher_macos"),
                .product(name: "geocoding-darwin", package: "geocoding_darwin")
            ]
        )
    ]
)
