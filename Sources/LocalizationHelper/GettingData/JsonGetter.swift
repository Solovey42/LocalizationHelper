import Foundation

class JsonGetter: GetDataProtocol {
    func gettingData() -> Result<[Language],ExitCodes> {
        let path = Bundle.main.path(forResource: "languages", ofType: "json") ?? "languages.json"
        var languages = [] as [Language]
        if let json = FileManager.default.contents(atPath: path) {
            do {
                try languages = JSONDecoder().decode([Language].self, from: json)
            } catch {
                return .failure(.ReadError)
            }
            return .success(languages)
        }
        else{
            return .failure(.ReadError)
        }
    }
}
