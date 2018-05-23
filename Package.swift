// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "SystemIntegrityTool",
    products: [
        .executable(name: "SystemIntegrityTool", targets: ["SystemIntegrityTool"]),
        .library(name: "SystemIntegrityKit", targets: ["SystemIntegrityKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pvieito/CommandLineKit.git", .branch("master")),
        .package(url: "https://github.com/pvieito/LoggerKit.git", .branch("master"))
    ],
    targets: [
        .target(name: "SystemIntegrityTool", dependencies: ["LoggerKit", "CommandLineKit", "SystemIntegrityKit"], path: "SystemIntegrityTool"),
        .target(name: "SystemIntegrityKit", path: "SystemIntegrityKit"),
    ]
)
