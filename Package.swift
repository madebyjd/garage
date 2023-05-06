// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "garage",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
    ],
    products: [
        .library(
            name: "garage",
            targets: ["garage"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "garage",
            dependencies: []),
            resources: [
                .process("first-names.txt"),
                .process("last-names.txt"),
                .process("streets.txt"),
                .process("lorem.txt"),
                .process("countries.csv"),
            ]),
        .testTarget(
            name: "garageTests",
            dependencies: ["garage"]),
    ]
)
