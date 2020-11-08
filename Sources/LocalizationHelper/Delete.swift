import Foundation

func delete(languages: inout [Language], key: String, language: String, updatingDataClass: SetDataProtocol) throws {

    let keys = getKeys(languages: languages)
    let languagesKeys = getLanguagesKeys(languages: languages)
    if language == "" && key != "" {
        deleteWithKey(, keys: keys, languages: &languages)
    } else if language != "" && key == "" {
        deleteWithLanguage(key: key, language: languages, languagesKeys: languagesKeys, languages: &languages)
    } else if language != "" && key != "" {
        deleteWithAllArg(key: key, language: languages, languagesKeys: languagesKeys, languages: &languages)
    }
    try updatingDataClass.settingData(languages: &languages)
}

func deleteWithKey(key: String, language: String, keys: [String], languages: inout [Language]) {
    guard keys.contains(.key) else {
        print("Not Found")
        exit(0)
    }
    for i in 0...languages.count - 1 {
        if languages[i].words.keys.contains(key) {
            for (key, _) in languages[i].words
                where key == key {
                languages[i].words.removeValue(forKey: key)
                print("Word \(key) was deleted from language \(languages[i].key)")
                break
            }
        }
    }
}

func deleteWithLanguage( key: String, language: String, languagesKeys: [String], languages: inout [Language]) {
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

func deleteWithAllArg( key: String, language: String, languagesKeys: [String], languages: inout [Language]) {
    guard languagesKeys.contains(language) else {
        print("Not Found")
        exit(0)
    }
    for i in 0...languages.count - 1 {
        for (key, value) in languages[i].words
            where key == key && languages[i].key == language {
            languages[i].words.removeValue(forKey: key)
            print("Word \(value) was deleted from language \(languages[i].key)")
            break
        }
    }
}