// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Home",
    platforms: [.iOS(.v18)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Home",
            targets: ["Home"]
        ),
    ],
    dependencies: [
      .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "8.15.2")),
      .package(url: "https://github.com/deanira/common-musicpreview.git", from: "1.0.1"),
      .package(path: "../Core"),
      .package(path: "../DesignSystem"),
      .package(path: "../Player"),
      .package(path: "../Profile"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Home",
            dependencies: [
              "Kingfisher",
              .product(name: "Common", package: "common-musicpreview"),
              "Core",
              "DesignSystem",
              "Player",
              "Profile",
            ],
            resources: [.process("Resources")],
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ],
        ),
        .testTarget(
            name: "HomeTests",
            dependencies: ["Home"],
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ],
        ),
    ]
)
