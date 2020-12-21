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

/*                  app.post() { req in
                   LanguageModel.query(on: req.db).all()
               }
               app.get("languages") { req in
                   Lang.query(on: req.db).all()
               }
                    app.post("create") { req -> EventLoopFuture<LanguageModel> in
                          let languageModel = try req.content.decode(LanguageModel.self)
                          return languageModel.create(on: req.db).map { languageModel }
                      }
                      app.post("createWord") { req -> EventLoopFuture<Words> in
                          let words = try req.content.decode(Words.self)
                          return words.create(on: req.db)
                                  .map { words }
                      }*/
        app.post("createLanguage") { req -> EventLoopFuture<Lang> in
            let language = try req.content.decode(Lang.self)
            return language.create(on: req.db).map {
                language
            }
        }
    }


    func search(req: Request) throws -> EventLoopFuture<[String: [String: String]]> {
        var languages = [] as [Language]

/*        let a = req.db.query(Lang.self).all().map { element1 in
            element1.forEach { element3 in
                languages.append(Language(key: element3.key, words: element3.words))
            }
        }*/
        print(languages)
        let param = try? req.query.decode(Parameters.self)


/*        req.eventLoop.future(result: result).map { value in
            value.reduce(into: [:]) { result, key in
                result[key.key] = getWords(result: allWords, key: key.key)
            }
        }*/

       // let allWords = result




        let a =  req.db.query(Lang.self).all().map { element3 in
            showClass.startShowing(key: param?.key, language: param?.language, data: transformToLanguages(lang: element3)).mapError {
                $0 as Error
            }.map { value in
                value.reduce(into: [:]) { res, key in
                    res[key.key] = getWords(result: value, key: key.key)
                }
            }
        }
        return a.map { val in getRes(result: val) }


/*        return  req.eventLoop.future(result: result).map { value in
            value.reduce(into: [:]) { result, key in
                result[key.key] = getWords(result: allWords, key: key.key)
            }
        }*/


/*        let a = req.eventLoop.future(req.db.query(Lang.self).all()).map { element1 in
            element1.map { element2 in
                element2.map { element3 in
                    languages.append(Language(key: element3.key, words: element3.words))
                    print(languages)
                }
            }
        }*/

/*        eventLoop.future(result: showClass.startShowing(key: param?.key, language: param?.language).mapError {
            $0 as Error
        }).map { value in
            value.reduce(into: [:]) { result, key in
                result[key.key] = getWords(result: showClass.startShowing(key: param?.key, language: param?.language).mapError {
                    $0 as Error
                }, key: key.key)
            }
        }*/

/*

        let eventLoop =  Lang.query(on: req.db).all().map { element1 in
            element1.map { element3 in
                languages.append(Language(key: element3.key, words: element3.words))
                print(languages)}
            }
*/


/*        Lang.query(on: req.db).all().map { element1 in
            element1.map { element2 in
                languages.append(Language(key: element2.key, words: element2.words))
                print(languages)
            }

        }*/

    }

    func getRes(result: Result<[String: [String: String]], Error>) -> [String: [String: String]] {
        switch result {
        case .success(let res):
            return res
        case .failure(let error):
            return [error.localizedDescription:[:]]
        }
    }

    func transformToLanguages(lang: [Lang]) -> [Language]{
        var languages = [] as [Language]
        for item in lang{
            languages.append(Language(key: item.key, words: item.words))
        }
        return languages
    }

    func getWords(result: [(languageKey: String, key: String, value: String)], key: String) -> [String: String] {
        var words: [String: String] = [:]

        for item in result {
            if item.key == key {
                words[item.languageKey] = item.value
            }
        }
        return words

    }
}


extension ShowController {
    struct Parameters: Content {
        let key: String?
        let language: String?
    }
}
