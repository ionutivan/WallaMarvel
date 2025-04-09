// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MarvelDomain",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MarvelDomain",
            targets: ["MarvelDomain"]),
    ],
    dependencies: [.package(path: "../MarvelData")],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MarvelDomain",
        dependencies: ["MarvelData"]
        ),
        .testTarget(
            name: "MarvelDomainTests",
            dependencies: ["MarvelDomain"]
        ),
    ]
)
