import PackageDescription

let package = Package(
    name: "CoreJSON",
    targets: [
        Target(name: "CoreJSON"),
        Target(name: "CoreJSONConvenience", dependencies: ["CoreJSON"]),
        Target(name: "CoreJSONFoundation", dependencies: ["CoreJSON"]),
        Target(name: "CoreJSONLiterals", dependencies: ["CoreJSON"]),
        Target(name: "CoreJSONSubscript", dependencies: ["CoreJSON"]),
        Target(name: "CoreJSONPointer", dependencies: ["CoreJSON"]),
    ],
    dependencies: []
)
