// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
        name: "LocalizationHelper",
        platforms: [
            .macOS(.v10_15)
        ],
        dependencies: [
            // Dependencies declare other packages that this package depends on.
            // .package(url: /* package url */, from: "1.0.0"),
            .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "0.3.0")),
            .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
            .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
            .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.0.0")
        ],
        targets: [
            // Targets are the basic building blocks of a package. A target can define a module or a test suite.
            // Targets can depend on other targets in this package, and on products in packages this package depends on.
            .target(
                    name: "LocalizationHelper",
                    dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser"), .product(name: "Vapor", package: "vapor"), .product(name: "Fluent", package: "fluent"),.product(name: "FluentPostgresDriver", package: "fluent-postgres-driver")],
                    resources: [.process("languages.json")]),
            .target(
                    name: "Run",
                    dependencies: ["LocalizationHelper"]),
            .target(
                    name: "APIRun",
                    dependencies: ["LocalizationHelper"]),
            .testTarget(
                    name: "LocalizationHelperTests",
                    dependencies: ["LocalizationHelper"]),
        ]
)
