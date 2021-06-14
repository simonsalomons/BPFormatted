// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BPFormatted",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "BPFormatted",
            targets: ["BPFormatted"]),
    ],
    targets: [
        .target(
            name: "BPFormatted",
            dependencies: []),
        .testTarget(
            name: "BPFormattedTests",
            dependencies: ["BPFormatted"]),
    ]
)
