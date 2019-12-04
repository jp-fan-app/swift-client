// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "jp-fan-app-client",
    products: [
        .library(name: "JPFanAppClient", targets: ["JPFanAppClient"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.0.0")
    ],
    targets: [
        .target(name: "JPFanAppClient", dependencies: ["AsyncHTTPClient"]),
        .testTarget(name: "JPFanAppClientTests", dependencies: ["JPFanAppClient"]),
    ]
)
