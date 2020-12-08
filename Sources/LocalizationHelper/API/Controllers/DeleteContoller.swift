import Vapor
import Fluent
import Foundation

struct DeleteController: RouteCollection {
    let deleteClass: DeletingProtocol

    init(deleteClass: DeletingProtocol) {
        self.deleteClass = deleteClass
    }

    func boot(routes: RoutesBuilder) throws {
        let app = routes.grouped("delete")
        app.post(use: delete)
    }


    func delete(req: Request) -> EventLoopFuture<String> {
        let param = try? req.query.decode(Parameters.self)
        let result = deleteClass.startDeleting(key: param?.key, language: param?.language).mapError {
            $0 as Error
        }


        return req.eventLoop.future(result: result)
    }
}

extension DeleteController {
    struct Parameters: Content {
        let key: String?
        let language: String?
    }
}