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
        app.get(use: update)
        let form = routes.grouped("updateForm")
        form.get(use: updateForm)
    }

    func updateForm(req: Request) -> EventLoopFuture<View> {
        req.view.render("updateForm")
    }

    func update(req: Request) -> EventLoopFuture<View> {
        let param = try? req.query.decode(Parameters.self)

        var language = param?.language
        var key = param?.key
        var word = param?.word

        if language == "" {
            language = nil
        }
        if key == "" {
            key = nil
        }
        if word == "" {
            word = nil
        }

        let result = updateClass.startUpdating(key: key ?? "", language: language ?? "", word: param?.word ?? "")

        switch result {
        case .success(let value):
            return req.view.render("result", ["result": "Введенное слово обновлено на \(value)"])
        case .failure(let error):
            return req.view.render("result", ["result": error.encodable])
        }
    }
}

extension UpdateController {
    struct Parameters: Content {
        let key: String
        let language: String
        let word: String
    }
}