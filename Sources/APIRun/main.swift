import Vapor
import LocalizationHelper
import Foundation

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
defer {app.shutdown()}
try configure(app: app)
try app.run()
