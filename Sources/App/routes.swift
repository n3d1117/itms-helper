import Routing
import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    router.get("request") { req -> Response in
        guard let bundle = req.query[String.self, at: "bundle"], let link = req.query[String.self, at: "link"] else {
            throw Abort(.badRequest)
        }

        let uuid = UUID().uuidString
        let filename = uuid + ".plist"
        let saveURL = Util.getPlistsFolder().appendingPathComponent(filename, isDirectory: false)

        let data = Util.getPlist(bundle: bundle, link: link)

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
