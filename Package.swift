// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OandaAPI",
				platforms: [.macOS(.v10_15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
								.library(name: "Oanda", targets: ["Oanda"]),
								.library(name: "OandaAPI", targets: ["OandaAPI"]),
    ],
    dependencies: [
								// Monitoring
								.package(url: "https://github.com/apple/swift-log.git", from: "1.4.4"),
								
								// Testing & Mocking
								.package(url: "https://github.com/WeTransfer/Mocker.git", from: "3.0.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
								.target(name: "Oanda", dependencies: []),
								.testTarget(
												name: "OandaTests",
												dependencies: ["Oanda"]),

        .target(
            name: "OandaAPI",
												dependencies: [
																"Oanda",
																.product(name: "Logging", package: "swift-log"),
												]),
        .testTarget(
            name: "OandaAPITests",
												dependencies: ["OandaAPI", .product(name: "Mocker", package: "Mocker"),]),
    ]
)
