// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Anime",
  platforms: [.iOS(.v16)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "Anime",
      targets: ["Anime"])
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    .package(url: "https://github.com/realm/realm-cocoa.git", .upToNextMajor(from: "10.0.0")),
    .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.0.0")),
    .package(path: "../Core")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "Anime",
      dependencies: [
        .product(name: "RealmSwift", package: "realm-cocoa"),
        "Alamofire",
        "Core"
      ]),
    .testTarget(
      name: "AnimeTests",
      dependencies: ["Anime"])
  ]
)
