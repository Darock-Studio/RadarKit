// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RadarKit",
    defaultLocalization: "zh-Hans",
    platforms: [.iOS(.v16), .watchOS(.v9)],
    products: [
        .library(
            name: "RadarKit",
            targets: ["RadarKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Darock-Studio/DarockKit", branch: "main")
    ],
    targets: [
        .target(
            name: "RadarKit",
            dependencies: [
                "DarockKit"
            ],
            resources: [.process("Resources/Localizable.xcstrings")]
        ),
    ]
)
