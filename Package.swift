// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "KinderMap",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "KinderMap", targets: ["KinderMap"])
    ],
    targets: [
        .executableTarget(
            name: "KinderMap",
            path: ".",
            exclude: ["README.md", ".vscode", "LICENSE"],
            sources: ["App", "Model", "Protocol", "Services", "ViewModel", "Views"],
            resources: [.process("Resources/question.json")]
        )
    ]
)
