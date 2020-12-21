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

        /*     let a =  req.db.query(Lang.self).all().map { element3 in
            deleteClass.startDeleting(key: param?.key, language: param?.language, data: transformToLanguages(lang: element3)).mapError {
                $0 as Error
            }.map
        }*/
        if param?.language == nil && param?.key != nil {
            req.db.query(Lang.self).all().map { element3 in
                deleteClass.startDeleting(key: param?.key, language: param?.language, data: transformToLanguages(lang: element3)).mapError {
                    $0 as Error
                }.map { word in
                    Lang.query(on: req.db)
                            .filter(\.$key == param?.language ?? "")
                            .delete()
                }
            }
        }//удаления языка
        return req.eventLoop.future("")
    }
}

func asd(language: QueryBuilder<Lang>, word: String, param: DeleteController.Parameters?) {
    language
            .filter(\.$key == param?.language ?? "")
            .filter(\.$words == [param?.key ?? "": word])
}

func aaa(language: QueryBuilder<Lang>, word: String, param: DeleteController.Parameters?) {
    language
            .filter(\.$key == param?.language ?? "")
            .filter(\.$words == [param?.key ?? "": word])
            .set(\.$words, to: ["": ""])
}

func deleteWithKeyAndValue(language: (), param: DeleteController.Parameters?) {

}

func transformToLanguages(lang: [Lang]) -> [Language] {
    var languages = [] as [Language]
    for item in lang {
        languages.append(Language(key: item.key, words: item.words))
    }
    return languages
}

func getRes(result: Result<String, Error>) -> String {
    switch result {
    case .success(let res):
        return res
    case .failure(let error):
        return error.localizedDescription
    }
}

extension DeleteController {
    struct Parameters: Content {
        let key: String?
        let language: String?
    }
}