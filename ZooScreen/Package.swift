// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ZooScreen",
    platforms: [.iOS(.v17)],
    products: [
        .executable(name: "ZooScreen", targets: ["ZooScreen"])
    ],
    targets: [
        .executableTarget(
            name: "ZooScreen",
            path: ".",
            resources: [.process("Info.plist")]
        )
    ]
)
