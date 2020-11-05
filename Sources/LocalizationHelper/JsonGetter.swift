import Foundation

class JsonGetter: GetDataProtocol {
    func gettingData() throws -> [Language] {
        let path = Bundle.module.path(forResource: "languages", ofType: "json") ?? "languages.json"
        let lang = try getJson(path: path)
        return lang
    }
}
