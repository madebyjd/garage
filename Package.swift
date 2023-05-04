// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "garage",
    platforms: [
        .iOS(.v14),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "garage",
            targets: ["garage", "interface", "datetime", "extensions"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "extensions",
            dependencies: []),
        .target(
            name: "garage",
            dependencies: []),
        .target(
            name: "interface",
            dependencies: []),
        .target(
            name: "datetime",
            dependencies: ["extensions"]),
        .testTarget(
            name: "garageTests",
            dependencies: ["garage", "interface", "datetime", "extensions"]),
    ]
)
