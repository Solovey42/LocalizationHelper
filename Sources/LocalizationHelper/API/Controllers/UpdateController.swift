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

        let a = req.db.query(Lang.self).all().map { element3 in
            updateClass.startUpdating(key: param?.key ?? "", language: param?.language ?? "", word: param?.word ?? "", data: transformToLanguages(lang: element3)).map { word in Lang.query(on: req.db)
                    .filter(\.$key == param?.language ?? "")
                    .filter(\.$words == [param?.key ?? "":word])
                    .set(\.$words, to: [param?.key ?? "": param?.word ?? ""])
                    .update()}.mapError {
                $0 as Error
            }
        }
        return a.map { val in getEvent(event: val)}
        //return req.eventLoop.future(a)
    }
    func getEvent(event:Result<EventLoopFuture<Void>, Error>) -> String {
        switch event {
        case .success:
            return "complete updating"
        case .failure(let error):
            return error.localizedDescription
        }
    }

    func getRes(result: Result<Void, Error>) -> String {
        switch result {
        case .success():
            return "complete updating"
        case .failure(let error):
            return error.localizedDescription
        }
    }

    func transformToLanguages(lang: [Lang]) -> [Language] {
        var languages = [] as [Language]
        for item in lang {
            languages.append(Language(key: item.key, words: item.words))
        }
        return languages

    }
}

extension UpdateController {
    struct Parameters: Content {
        let key: String
        let language: String
        let word: String
    }
}