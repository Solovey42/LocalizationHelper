import Foundation

class UpdateData {
    func update(languages: inout [Language], word: String, key: String, language: String, updatingDataClass: SetDataProtocol) throws {
        let languagesKeys = getLanguagesKeys(languages: languages)
        guard languagesKeys.contains(language) else {
            print("Not Found")
            exit(0)
        }
        for i in 0...languages.count - 1 {
            for (wordKey, value) in languages[i].words
                where wordKey == key && languages[i].key == language {
                languages[i].words.updateValue(word, forKey: key)
                try updatingDataClass.settingData(languages: &languages)
                print("Word \(value) was updated")
                exit(0)
            }
        }
        print("Not found")
    }
    func getLanguagesKeys(languages: [Language]) -> [String] {
        var languagesKeys: [String] = []
        for i in 0...languages.count - 1 {
            if languagesKeys.contains(languages[i].key) == false {
                languagesKeys.append(languages[i].key)
            }
        }
        return languagesKeys
    }
    func getKeys(languages: [Language]) -> [String] {
        var keys: [String] = []
        for i in 0...languages.count - 1 {
            for (key, _) in languages[i].words {
                if keys.contains(key) == false {
                    keys.append(key)
                }
            }
        }
        return keys
    }
}
