// swift-tools-version:5.5

import PackageDescription

let package = Package(
  
  name: "SlashCows",

  platforms: [
    .macOS(.v10_15), .iOS(.v13)
  ],
  
  products: [
    .executable(name: "SlashCows", targets: [ "SlashCows" ]),
  ],
  
  dependencies: [
    .package(url: "https://github.com/SwiftBlocksUI/SwiftBlocksUI.git",
             from: "0.9.4"),
    .package(url: "https://github.com/AlwaysRightInstitute/cows.git",
             from: "1.0.1")
  ],
  
  targets: [
    .executableTarget(name: "SlashCows", 
                      dependencies: [ "SwiftBlocksUI", "cows" ])
  ]
)
