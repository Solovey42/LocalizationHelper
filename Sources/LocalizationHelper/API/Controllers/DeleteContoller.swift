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
        app.get(use: delete)
        let form = routes.grouped("deleteForm")
        form.get(use: deleteForm)
    }

    func deleteForm(req: Request) -> EventLoopFuture<View> {
        req.view.render("deleteForm")
    }


    func delete(req: Request) -> EventLoopFuture<View> {

        let param = try? req.query.decode(Parameters.self)
        var language = param?.language
        var key = param?.key

        if language == "" {
            language = nil
        }
        if key == "" {
            key = nil
        }

        let result = deleteClass.startDeleting(key: key, language: language)

        switch result {
        case .success(let value):
            return req.view.render("result", ["result": "Слово \(value) было удалено"])
        case .failure(let error):
            return req.view.render("result", ["result": error.encodable])
        }
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