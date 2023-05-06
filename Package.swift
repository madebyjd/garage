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
        .package(name: "SLLog", url: "https://github.com/shial4/LogSwift.git", branch: "master")
    ],
    targets: [
        .target(
            name: "garage",
            dependencies: [
                "SLLog",
            ],
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
