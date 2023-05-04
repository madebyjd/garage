// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "garage",
    products: [
        .library(
            name: "garage",
            targets: ["garage"]),
        .library(
            name: "interface",
            targets: ["interface"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "garage",
            dependencies: []),
        .target(
            name: "interface",
            dependencies: []),
        .testTarget(
            name: "garageTests",
            dependencies: ["garage"]),
    ]
)
