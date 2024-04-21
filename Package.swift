// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FunctionalSwift",
    platforms: [.iOS(.v14), .macOS(.v12)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "FunctionalSwift",
            targets: ["FunctionalSwift"]
        )
    ],
    targets: [
        .target(
            name: "FunctionalSwift",
            dependencies: []
        ),

        .testTarget(
            name: "FunctionalSwiftTests",
            dependencies: ["FunctionalSwift"]
        )
    ]
)
