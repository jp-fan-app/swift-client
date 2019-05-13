// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JPFanAppClient",
    products: [
        .library(name: "JPFanAppClient", targets: ["JPFanAppClient"]),
    ],
    dependencies: [
        .package(url: "https://github.com/cpageler93/Quack.git", from: "1.9.0"),
    ],
    targets: [
        .target(name: "JPFanAppClient", dependencies: ["Quack"]),
        .testTarget(name: "JPFanAppClientTests", dependencies: ["JPFanAppClient"]),
    ]
)
