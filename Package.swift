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
        .package(url: "https://github.com/Darock-Studio/RadarKitCore", from: "1.0.0"),
        .package(url: "https://github.com/Darock-Package-Distribution/MarkdownUI", from: "1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .binaryTarget(name: "RadarKit", url: "https://github.com/darock-studio/radarkit/releases/download/1.0.0/RadarKit.xcframework.zip", checksum: "c7b1043be1c5d10c9305765ec5d6f3d583744b13f840f17378340b64bd0c13c8"),
        .target(name: "_RadarKitDependenciesWrapper", dependencies: [
            "RadarKitCore",
            "MarkdownUI"
        ])
    ]
)
