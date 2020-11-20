import Foundation

class JsonGetter: GetDataProtocol {
    func gettingData() -> [Language]? {
        let path = Bundle.module.path(forResource: "languages", ofType: "json") ?? "languages.json"
        var languages = [] as [Language]
        if let json = FileManager.default.contents(atPath: path) {
            do {
                try languages = JSONDecoder().decode([Language].self, from: json)
            } catch {
                return nil
            }
            return languages
        }
        else{
            return nil
        }
    }
}
