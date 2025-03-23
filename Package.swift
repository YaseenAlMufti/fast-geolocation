// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "FastGeolocation",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "FastGeolocation",
            targets: ["FastGeolocationPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "FastGeolocationPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/FastGeolocationPlugin"),
        .testTarget(
            name: "FastGeolocationPluginTests",
            dependencies: ["FastGeolocationPlugin"],
            path: "ios/Tests/FastGeolocationPluginTests")
    ]
)