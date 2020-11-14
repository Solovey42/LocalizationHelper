import Foundation

class JsonSetter: SetDataProtocol {
    func settingData(languages: inout [Language]) throws {
        do {
            if let path = try Bundle.module.path(forResource: "languages", ofType: "json") {
                do {
                    let json = try JSONEncoder().encode(languages.self)
                    try json.write(to: URL(fileURLWithPath: path))
                } catch {
                    print("Ошибка записи файла")
                }
            } else {
                print("Ошибка поиска пути до файла.")
            }
        }
    }

}
