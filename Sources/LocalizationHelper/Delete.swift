import Foundation

class DeleteData: DeletingProtocol {

    func deleteWithKey(indexValue: Int, key: String, languages: [Language]) {
        languages[indexValue].words.removeValue(forKey: key)
    }

    func deleteWithLanguage(key: String, language: String, languagesKeys: [String], languages: inout [Language]) {
        guard languagesKeys.contains(language) else {
            print("Not Found")
            exit(0)
        }
        for i in 0...languages.count - 1 {
            if languages[i].key == language {
                print("Language \(languages[i].key) was deleted")
                languages.remove(at: i)
                break
            }
        }
    }

    func deleteWithAllArg(indexValue: Int, key: String, languages: inout [Language]) {
        languages[indexValue].words.removeValue(forKey: key)
    }
}