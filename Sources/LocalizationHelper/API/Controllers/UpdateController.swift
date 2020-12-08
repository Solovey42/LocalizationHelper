import Vapor
import Fluent
import Foundation

struct UpdateController: RouteCollection {
    let updateClass: UpdatingProtocol

    init(updateClass: UpdatingProtocol) {
        self.updateClass = updateClass
    }

    func boot(routes: RoutesBuilder) throws {
        let app = routes.grouped("update")
        app.post(use: update)
    }

    func update(req: Request) -> EventLoopFuture<String> {
        let param = try? req.query.decode(Parameters.self)

        let result = updateClass.startUpdating(key: param?.key ?? "", language: param?.language ?? "", word: param?.word ?? "").mapError {
            $0 as Error
        }
        return req.eventLoop.future(result: result)
    }

}

extension UpdateController {
    struct Parameters: Content {
        let key: String
        let language: String
        let word: String
    }
}