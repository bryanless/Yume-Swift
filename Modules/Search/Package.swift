// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Search",
  platforms: [.iOS(.v16)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "Search",
      targets: ["Search"])
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    .package(path: "../Anime"),
    .package(path: "../Common"),
    .package(path: "../Core")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "Search",
      dependencies: [
        "Anime",
        "Common",
        "Core"
      ]),
    .testTarget(
      name: "SearchTests",
      dependencies: ["Search"])
  ]
)