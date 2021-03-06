import Routing
import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    router.get { req -> Future<View> in
        return try req.view().render("home", [String: String]())
    }

    router.get("request") { req -> Response in

        guard let bundle = req.query[String.self, at: "bundle"], let link = req.query[String.self, at: "link"], let title = req.query[String.self, at: "title"] else {
            throw Abort(.badRequest)
        }

        let uuid = UUID().uuidString
        let filename = uuid + ".plist"
        let saveURL = Util.getPlistsFolder().appendingPathComponent(filename, isDirectory: false)

        var data: Data!
        if let version = req.query[String.self, at: "version"], !version.isEmpty {
            data = Util.getPlist(bundle: bundle, link: link, title: title, version: version)
        } else {
            data = Util.getPlist(bundle: bundle, link: link, title: title)
        }

        do {
            try FileManager.default.createDirectory(at: Util.getPlistsFolder(), withIntermediateDirectories: true, attributes: nil)
        } catch {
            throw Abort(.badRequest)
        }
        
        guard FileManager.default.createFile(atPath: saveURL.path, contents: data, attributes: nil) else {
            throw Abort(.badRequest)
        }

        return Response(uuid: uuid)
    }
}
