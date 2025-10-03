// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SheetKit",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v14), .iOS(.v17), .visionOS(.v1), .tvOS(.v17), .watchOS(.v10)
    ],
    products: [
        .library(name: "SheetKit", targets: ["SheetKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/SzpakKamil/TabKit", branch: "main")
    ],
    targets: [
        .target(
            name: "SheetKit",
            dependencies: [
              .product(
                name: "TabKit",
                package: "TabKit",
                condition: .when(platforms: [.iOS, .tvOS, .visionOS])
              ),
            ],
            resources: [
                .process("Resources/Localizable.xcstrings")
            ]
        )
    ]
)
