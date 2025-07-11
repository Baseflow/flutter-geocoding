// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
//  Generated file. Do not edit.
//

import PackageDescription

let package = Package(
    name: "FlutterGeneratedPluginSwiftPackage",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "FlutterGeneratedPluginSwiftPackage", type: .static, targets: ["FlutterGeneratedPluginSwiftPackage"])
    ],
    dependencies: [
        .package(name: "url_launcher_ios", path: "/Users/maurits/.pub-cache/hosted/pub.dev/url_launcher_ios-6.3.3/ios/url_launcher_ios"),
        .package(name: "integration_test", path: "/Users/maurits/development/flutter/packages/integration_test/ios/integration_test"),
        .package(name: "geocoding_darwin", path: "/Users/maurits/sources/Baseflow/Internal/Flutter/geocoding/geocoding_darwin/darwin/geocoding_darwin")
    ],
    targets: [
        .target(
            name: "FlutterGeneratedPluginSwiftPackage",
            dependencies: [
                .product(name: "url-launcher-ios", package: "url_launcher_ios"),
                .product(name: "integration-test", package: "integration_test"),
                .product(name: "geocoding-darwin", package: "geocoding_darwin")
            ]
        )
    ]
)
