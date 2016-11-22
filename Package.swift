import PackageDescription

let package = Package(
    name: "RxCouchDB",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura-CouchDB.git", versions: Version(1,0,0)..<Version(2,0,0)),
        .Package(url: "https://github.com/ReactiveX/RxSwift.git", versions: Version(3,0,0)..<Version(4,0,0))
    ]
)