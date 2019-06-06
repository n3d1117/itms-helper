import Routing
import Vapor

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)


public func routes(_ router: Router) throws {
    router.get("request") { req -> Response in
        guard let bundle = req.query[String.self, at: "bundle"] else {
            throw Abort(.badRequest)
        }
        guard let link = req.query[String.self, at: "link"] else {
            throw Abort(.badRequest)
        }
        print(bundle)
        print(link)

        let directory = DirectoryConfig.detect()
        let workPath = directory.workDir

        let filename = UUID().uuidString + ".plist"
        let plistsFolder = "Public/plists"

        let plists = URL(fileURLWithPath: workPath).appendingPathComponent(plistsFolder, isDirectory: true)
        let saveURL = plists.appendingPathComponent(filename, isDirectory: false)

        let data = getPlist(bundle: bundle, link: link)

        guard FileManager.default.createFile(atPath: saveURL.path, contents: data, attributes: nil) else {
            throw Abort(.badRequest)
        }

        return Response(location: ("plists/" + saveURL.lastPathComponent))

    }
}

struct Response: Content {
    var location: String
}


func getPlist(bundle: String, link: String) -> Data {

    let stringData = """
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>items</key>
    <array>
        <dict>
            <key>assets</key>
            <array>
                <dict>
                    <key>kind</key>
                    <string>software-package</string>
                    <key>url</key>
                    <string>\(link)</string>
                </dict>
            </array>
            <key>metadata</key>
            <dict>
                <key>bundle-identifier</key>
                <string>\(bundle)</string>
                <key>bundle-version</key>
                <string>1.0</string>
                <key>kind</key>
                <string>software</string>
                <key>title</key>
                <string></string>
            </dict>
        </dict>
    </array>
</dict>
</plist>
"""

    return Data(stringData.utf8)
}
