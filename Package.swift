// swift-tools-version: 6.2

import PackageDescription

// RFC 1950: ZLIB Compressed Data Format Specification
let package = Package(
    name: "swift-rfc-1950",
    platforms: [
        .macOS(.v15),
        .iOS(.v18),
        .tvOS(.v18),
        .watchOS(.v11),
    ],
    products: [
        .library(name: "RFC 1950", targets: ["RFC 1950"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-standards/swift-standards", from: "0.8.0"),
        .package(path: "../swift-rfc-1951"),
    ],
    targets: [
        .target(
            name: "RFC 1950",
            dependencies: [
                .product(name: "Standards", package: "swift-standards"),
                .product(name: "RFC 1951", package: "swift-rfc-1951"),
            ]
        ),
        .testTarget(
            name: "RFC 1950".tests,
            dependencies: ["RFC 1950"]
        ),
    ],
    swiftLanguageModes: [.v6]
)

extension String {
    var tests: Self { self + " Tests" }
}

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    target.swiftSettings = (target.swiftSettings ?? []) + [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
    ]
}
