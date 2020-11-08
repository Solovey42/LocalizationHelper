import Foundation

func update(languages: inout [Language], word: String, key: String, language: String, updatingDataClass: SetDataProtocol ) throws {
    let languagesKeys = getLanguagesKeys(languages: languages)
    guard languagesKeys.contains(language) else {
        print("Not Found")
        exit(0)
    }
    for i in 0...languages.count - 1 {
        for (key, value) in languages[i].words
            where key == key && languages[i].key == language {
            languages[i].words.updateValue(word, forKey: key)
            try updatingDataClass.settingData(languages: &languages)
            print("Word \(value) was updated")
            exit(0)
        }
    }
    print("Not found")
}
