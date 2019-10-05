// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "CoreJSON",
    products: [
        .library(name: "CoreJSON", targets: [
            "CoreJSON",
            "CoreJSONConvenience",
            "CoreJSONFoundation",
            "CoreJSONLiterals",
            "CoreJSONSubscript",
            "CoreJSONPointer",
            "CoreJSONCodable"
        ])
    ],
    dependencies: [],
    targets: [
        .target(name: "CoreJSON"),
        .testTarget(name: "CoreJSONTests", dependencies: ["CoreJSON"]),
        .target(name: "CoreJSONConvenience", dependencies: ["CoreJSON"]),
        .testTarget(name: "CoreJSONConvenienceTests", dependencies: ["CoreJSON", "CoreJSONConvenience"]),
        .target(name: "CoreJSONFoundation", dependencies: ["CoreJSON"]),
        .testTarget(name: "CoreJSONFoundationTests", dependencies: ["CoreJSON", "CoreJSONFoundation"]),
        .target(name: "CoreJSONLiterals", dependencies: ["CoreJSON"]),
        .testTarget(name: "CoreJSONLiteralsTests", dependencies: ["CoreJSON", "CoreJSONLiterals"]),
        .target(name: "CoreJSONSubscript", dependencies: ["CoreJSON"]),
        .testTarget(name: "CoreJSONSubscriptTests", dependencies: ["CoreJSON", "CoreJSONSubscript", "CoreJSONConvenience", "CoreJSONLiterals"]),
        .target(name: "CoreJSONPointer", dependencies: ["CoreJSON"]),
        .testTarget(name: "CoreJSONPointerTests", dependencies: ["CoreJSON", "CoreJSONPointer"]),
        .target(name: "CoreJSONCodable", dependencies: ["CoreJSON"]),
        .testTarget(name: "CoreJSONCodableTests", dependencies: ["CoreJSON", "CoreJSONCodable"]),
    ]
)
