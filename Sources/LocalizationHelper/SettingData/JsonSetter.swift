import Foundation

class JsonSetter: SetDataProtocol {
    func settingData(languages: inout [Language]) throws {
        let path = Bundle.module.path(forResource: "languages", ofType: "json") ?? "languages.json"
        do {
            let json = try JSONEncoder().encode(languages.self)
            try json.write(to: URL(fileURLWithPath: path))
        } catch {
            print("Ошибка сохранения данных")
        }
    }
}