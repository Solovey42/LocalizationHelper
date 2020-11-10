import Foundation

class SearchData: SearchingProtocol {
    func run(languages: inout [Language], key: String, language: String) throws {
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
                for (wordKey, value) in languages[i].words
                    where wordKey == key {
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
            for (wordKey, value) in languages[i].words
                where wordKey == key && languages[i].key == language {
                print("\(value)")
                exit(0)
            }
        }
        print("Not found")
    }
}




