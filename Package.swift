// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SheetKit",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v13), .iOS(.v16), .visionOS(.v1), .tvOS(.v17), .watchOS(.v10)
    ],
    products: [
        .library(name: "SheetKit", targets: ["SheetKit"])
    ],
    targets: [
        .binaryTarget(
            name: "SheetKit",
            path: "./Sources/SheetKit.xcframework")
    ]
)
