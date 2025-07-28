
// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Login",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "Login", targets: ["Login"])
    ],
    dependencies: [
        .package(path: "../../Core/Networking")
    ],
    targets: [
        .target(name: "Login", dependencies: ["Networking"]),
        .testTarget(name: "LoginTests", dependencies: ["Login"])
    ]
)
