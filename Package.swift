// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RadarKit",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "RadarKit", targets: ["RadarKit", "_RadarKitDependenciesWrapper"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Darock-Studio/RadarKitCore", branch: "main"),
        .package(url: "https://github.com/Darock-Package-Distribution/MarkdownUI", branch: "main")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .binaryTarget(name: "RadarKit", path: "RadarKit.xcframework"),
        .target(name: "_RadarKitDependenciesWrapper", dependencies: [
            "RadarKitCore",
            "MarkdownUI"
        ])
    ]
)
