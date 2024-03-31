// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FunctionalSwift",
    platforms: [.iOS(.v14), .macOS(.v12)],
    products: [
        .library(
            name: "FunctionalSwift",
            targets: ["FunctionalSwift"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/realm/SwiftLint.git", from: .init(0, 5, 0))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "FunctionalSwift",
            dependencies: [],
            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]
        ),

        .testTarget(
            name: "FunctionalSwiftTests",
            dependencies: ["FunctionalSwift"]
        )
    ]
)
