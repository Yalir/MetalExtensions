// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "MetalExtensions",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v11)
    ],
    products: [
        .library(name: "MetalExtensions", targets: ["MetalExtensions"]),
    ],
    targets: [
        .target(name: "MetalExtensions"),
        .testTarget(name: "MetalExtensionsTests", dependencies: ["MetalExtensions"]),
    ]
)
