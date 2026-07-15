// swift-tools-version: 6.3
import PackageDescription

let package = Package(
    name: "RealityAudio",
    platforms: [
        .iOS(.v15),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "RealityAudio",
            targets: ["RealityAudio"]
        ),
    ],
    targets: [
        .target(
            name: "RealityAudio",
            linkerSettings: [
                .linkedFramework("RealityKit"),
                .linkedFramework("AVFoundation"),
            ]
        ),
        .testTarget(
            name: "RealityAudioTests",
            dependencies: ["RealityAudio"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
