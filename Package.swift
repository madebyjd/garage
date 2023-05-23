// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "garage",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "garage",
            targets: ["garage"]
        )
    ],
    dependencies: [
        .package(name: "SLLog", url: "https://github.com/shial4/LogSwift.git", branch: "master"),
        .package(url: "https://github.com/groue/Semaphore.git", branch: "main"),
        .package(name: "ViewInspector", url: "https://github.com/nalexn/ViewInspector.git", branch: "0.9.7")
    ],
    targets: [
        .target(
            name: "garage",
            dependencies: [
                "SLLog",
                "Semaphore"
            ],
            resources: [
                .process("first-names.txt"),
                .process("last-names.txt"),
                .process("streets.txt"),
                .process("lorem.txt"),
                .process("countries.csv")
            ]),
        .testTarget(
            name: "garageTests",
            dependencies: [
                "garage",
                "ViewInspector"
            ],
            resources: [
                .copy("test.png")
            ]
        )
    ]
)
