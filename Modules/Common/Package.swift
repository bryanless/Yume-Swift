// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Common",
  defaultLocalization: "en",
  platforms: [.iOS(.v16)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "Common",
      targets: ["Common"])
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", .upToNextMajor(from: "2.0.0")),
    .package(url: "https://github.com/bryanless/Yume-Core-Module.git", .upToNextMajor(from: "1.0.0")),
    .package(path: "../Anime")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "Common",
      dependencies: [
        .product(name: "Core", package: "Yume-Core-Module"),
        "Anime",
        "SDWebImageSwiftUI"
      ]),
    .testTarget(
      name: "CommonTests",
      dependencies: ["Common"])
  ]
)
