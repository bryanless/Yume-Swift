// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AnimeDetail",
  platforms: [.iOS(.v16)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "AnimeDetail",
      targets: ["AnimeDetail"])
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", .upToNextMajor(from: "2.0.0")),
    .package(path: "../Anime"),
    .package(path: "../Common"),
    .package(path: "../Core")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "AnimeDetail",
      dependencies: [
        "Anime",
        "Common",
        "Core",
        "SDWebImageSwiftUI"
      ]),
    .testTarget(
      name: "AnimeDetailTests",
      dependencies: ["AnimeDetail"])
  ]
)
