// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "SystemIntegrityTool",
    products: [
        .executable(
            name: "SystemIntegrityTool",
            targets: ["SystemIntegrityTool"]
        ),
        .library(
            name: "SystemIntegrityKit",
            targets: ["SystemIntegrityKit"]
        )
    ],
    dependencies: [
        .package(url: "git@github.com:pvieito/LoggerKit.git", .branch("master")),
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "0.0.1")),
    ],
    targets: [
        .target(
            name: "SystemIntegrityTool",
            dependencies: ["LoggerKit", "SystemIntegrityKit", .product(name: "ArgumentParser", package: "swift-argument-parser")],
            path: "SystemIntegrityTool"
        ),
        .target(
            name: "SystemIntegrityKit",
            path: "SystemIntegrityKit"
        ),
        .testTarget(
            name: "SystemIntegrityKitTests",
            dependencies: ["SystemIntegrityKit"]
        )
    ]
)
