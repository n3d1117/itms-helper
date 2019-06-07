import Vapor
import Leaf

private var cleanupTimer: DispatchSourceTimer?

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register Leaf
    try services.register(LeafProvider())
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)

    // Static file serving
    var middleware = MiddlewareConfig.default()
    middleware.use(FileMiddleware.self)
    services.register(middleware)

    // Configure cleanup timer
    cleanupTimer = DispatchSource.makeTimerSource()
    cleanupTimer?.setEventHandler {
        do {
            // Clean up plists folder
            let contents = try FileManager.default.contentsOfDirectory(at: Util.getPlistsFolder(), includingPropertiesForKeys: nil)
            for file in contents {
                try FileManager.default.removeItem(at: file)
            }
        } catch { }
    }
    // Run every 12 hours
    cleanupTimer?.schedule(deadline: .now() + .seconds(86_400), repeating: .seconds(86_400))

    // Start timer
    if #available(OSX 10.12, *) {
        cleanupTimer?.activate()
    } else {
        cleanupTimer?.resume()
    }
}
