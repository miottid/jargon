import PackageDescription

let package = Package(
    name: "jargon",
    dependencies: [
        .Package(url: "https://github.com/kylef/Commander", Version(0,6,0)),
        .Package(url: "https://github.com/yaslab/CSV.swift", Version(1,1,2)),
		.Package(url: "https://github.com/jpsim/Yams.git", majorVersion: 0),
    ]
)
