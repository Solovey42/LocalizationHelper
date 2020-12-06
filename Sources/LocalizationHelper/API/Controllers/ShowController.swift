import Vapor
import Fluent
import Foundation

struct ShowController: RouteCollection {
    let showClass: ShowingProtocol

    init(showClass: ShowingProtocol) {
        self.showClass = showClass
    }

    func boot(routes: RoutesBuilder) throws {
        let app = routes.grouped("search")
        app.get(use: search)
    }


    func search(req: Request) -> EventLoopFuture<[String: [String: String]]> {
        let param = try? req.query.decode(Parameters.self)
        let result = showClass.startShowing(key: param?.key, language: param?.language).mapError {
            $0 as Error
        }

        let allWords = result

        return req.eventLoop.future(result: result).map { value in
            value.reduce(into: [:]) { result, key in
                result[key.key] = getWords(result: allWords, key: key.key)
            }
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

extension ShowController {
    struct Parameters: Content {
        let key: String?
        let language: String?
    }
}