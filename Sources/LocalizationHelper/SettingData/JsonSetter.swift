import Foundation

class JsonSetter: SetDataProtocol {
    func settingData(languages: inout [Language]) throws  {
        if let path = Bundle.module.path(forResource: "languages", ofType: "json") {
            do {
                let json = try JSONEncoder().encode(languages.self)
                try json.write(to: URL(fileURLWithPath: path))
            } catch {
                throw ExitCodes.WriteError
            }
        } else {
            throw ExitCodes.WriteError
        }
    }
}
