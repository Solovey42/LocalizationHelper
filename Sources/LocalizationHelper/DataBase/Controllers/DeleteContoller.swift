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

    func getWords(result: Result<[(languageKey: String, key: String, value: String)], Error>, key: String) -> [String: String] {
        var words: [String: String] = [:]
        switch result {
        case .success(let items):
            for item in items {
                if item.key == key {
                    words[item.languageKey] = item.value
                }
            }
            return words
        case .failure:
            return [:]
        }
    }
}

extension DeleteController {
    struct Parameters: Content {
        let key: String?
        let language: String?
    }
}