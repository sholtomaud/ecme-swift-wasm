// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "ECME",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "ecme", targets: ["ECME"]),
        .library(name: "ECMECore", targets: ["Core"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftwasm/JavaScriptKit", from: "0.20.0"),
        .package(url: "https://github.com/stephencelis/SQLite.swift", from: "0.15.0"),
    ],
    targets: [
        // Shared Core Logic
        .target(
            name: "Core",
            dependencies: [],
            path: "Sources/Core"
        ),
        // Native CLI Target
        .executableTarget(
            name: "ECME",
            dependencies: [
                "Core",
                .product(name: "SQLite", package: "SQLite.swift")
            ],
            path: "Sources/ECME"
        ),
        // WASM Target (must be executableTarget for Carton/main.swift)
        .executableTarget(
            name: "ECMEWasm",
            dependencies: [
                "Core",
                .product(name: "JavaScriptKit", package: "JavaScriptKit")
            ],
            path: "Sources/ECMEWasm"
        ),
        // Test Target
        .testTarget(
            name: "ECMETests",
            dependencies: ["Core", "ECME"],
            path: "Tests/ECMETests"
        ),
    ]
)