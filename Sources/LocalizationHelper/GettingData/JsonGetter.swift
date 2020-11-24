import Foundation

class JsonGetter: GetDataProtocol {
    func gettingData() throws -> [Language] {
        let path = Bundle.module.path(forResource: "languages", ofType: "json") ?? "languages.json"
        var languages = [] as [Language]
        if let json = FileManager.default.contents(atPath: path) {
            try languages = JSONDecoder().decode([Language].self, from: json)
        }
        return languages
    }
}
