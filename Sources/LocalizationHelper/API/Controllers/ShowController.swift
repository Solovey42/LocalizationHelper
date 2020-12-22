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
        let form = routes.grouped("searchForm")
        form.get(use: searchForm)

    }

    func searchForm(req: Request) -> EventLoopFuture<View> {
        req.view.render("searchForm")
    }

    func search(req: Request) -> EventLoopFuture<View> {
        let param = try? req.query.decode(Parameters.self)

        var language = param?.language
        var key = param?.key

        if language == "" {
            language = nil
        }
        if key == "" {
            key = nil
        }

        let result = showClass.startShowing(key: key, language: language)

        switch result {
        case .success(let values):
            return req.view.render("result", ["result": values.map { value in
                "\(value.languageKey) \(value.key) \(value.value)"
            }])
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

extension ShowController {
    struct Response: Content {
        let results: [SearchResults]

        struct SearchResults: Codable {
            let key: String
            let elements: [Element]

            struct Element: Codable {
                let language: String
                let value: String
            }
        }
    }
}

extension ShowController {
    struct Parameters: Content {
        let key: String?
        let language: String?
    }
}