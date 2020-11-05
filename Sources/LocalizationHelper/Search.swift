import Foundation

func search(languages: inout [Language], key: String, language: String) throws {

    let keys = getKeys(languages: languages)
    let languagesKeys = getLanguagesKeys(languages: languages)

    if language == "" && key == "" {
        printWithOutArg(keys: keys, languages: languages)
    } else if language == "" && key != "" {
        printWithKey(key: key, language: language, keys: keys, languages: languages)
    } else if language != "" && key == "" {
        printWithLanguage(key: key, language: language, languagesKeys: languagesKeys, languages: languages)
    } else {
        printWitAllArg(key: key, language: language, languagesKeys: languagesKeys, languages: languages)
    }
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

func getLanguagesKeys(languages: [Language]) -> [String] {
    var languagesKeys: [String] = []
    for i in 0...languages.count - 1 {
        if languagesKeys.contains(languages[i].key) == false {
            languagesKeys.append(languages[i].key)
        }
    }
    return languagesKeys
}

func printWithOutArg(keys: [String], languages: [Language]) {
    for item in keys {
        print(item)
        for n in 0...languages.count - 1 {
            for (key, value) in languages[n].words
                where item == key {
                print("\t\(languages[n].key) = \(value)")
            }
        }
    }
}

func printWithLanguage(key: String, language: String, languagesKeys: [String], languages: [Language]) {
    guard languagesKeys.contains(language) else {
        print("Not Found")
        exit(0)
    }
    for i in 0...languages.count - 1 {
        if languages[i].key == language {
            for (key, value) in languages[i].words {
                print("\(key) = \(value)")
            }
        }
    }
}

func printWithKey(key: String, language: String, keys: [String], languages: [Language]) {
    guard keys.contains(key) else {
        print("Not Found")
        exit(0)
    }
    print(key)
    for i in 0...languages.count - 1 {
        if languages[i].words.keys.contains(key) {
            for (key, value) in languages[i].words
                where key == key {
                print("\t\(languages[i].key): \(value)")
                break
            }
        }
    }
}

func printWitAllArg(key: String, language: String, languagesKeys: [String], languages: [Language]) {
    guard languagesKeys.contains(language) else {
        print("Not Found")
        exit(0)
    }

    for i in 0...languages.count - 1 {
        for (key, value) in languages[i].words
            where key == key && languages[i].key == language {
            print("\(value)")
            exit(0)
        }
    }
    print("Not found")
}




