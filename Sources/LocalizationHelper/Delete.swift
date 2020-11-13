import Foundation

class DeleteData: DeletingProtocol {

    func deleteWithKey(key: String, language: String, keys: [String], languages: inout [Language]) {
        guard keys.contains(key) else {
            print("Not Found")
            exit(0)
        }
        for i in 0...languages.count - 1 {
            if languages[i].words.keys.contains(key) {
                for (wordKey, _) in languages[i].words
                    where wordKey == key {
                    languages[i].words.removeValue(forKey: key)
                    print("Word \(key) was deleted from language \(languages[i].key)")
                    break
                }
            }
        }
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