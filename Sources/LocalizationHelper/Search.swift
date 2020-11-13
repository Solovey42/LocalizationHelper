import Foundation

class SearchData: SearchingProtocol {
    var command: String = ""
    var languages: [Language] = []
    var key: String?
    var language: String?
    var word: String?
    var gettingDataClass: GetDataProtocol?
    var updatingDataClass: SetDataProtocol?
    var getterStrings: GetStringKeysProtocol?
    var keys: [String] = []
    var languagesKeys: [String] = []
    var deleterClass: DeletingProtocol?

    func run(command: String, key: String, language: String, word: String, gettingDataClass: GetDataProtocol, updatingDataClass: SetDataProtocol, getterStrings: GetStringKeysProtocol, deleterClass: DeletingProtocol) throws {
        self.command = command
        self.languages = try gettingDataClass.gettingData()
        self.key = key
        self.language = language
        self.word = word
        self.gettingDataClass = gettingDataClass
        self.updatingDataClass = updatingDataClass
        self.getterStrings = getterStrings
        self.keys = getterStrings.getKeys(languages: languages)
        self.languagesKeys = getterStrings.getLanguagesKeys(languages: languages)
        self.deleterClass = deleter

        if language == "" && key == "" {
            printWithOutArg(keys: keys, languages: languages)
        } else if language == "" && key != "" {
            if command == "search" {
                printWithKey(key: key, language: language, keys: keys, languages: languages)
            } else {
                deleter.deleteWithKey(key: key, language: language, keys: keys, languages: &languages)
                try updatingDataClass.settingData(languages: &languages)
            }
        } else if language != "" && key == "" {
            if command == "search" {
                printWithLanguage(key: key, language: language, languagesKeys: languagesKeys, languages: languages)
            } else {
                deleter.deleteWithLanguage(key: key, language: language, languagesKeys: languagesKeys, languages: &languages)
                try updatingDataClass.settingData(languages: &languages)
            }
        } else {
            if command == "search" {
                try printWitAllArg(key: key, language: language, languagesKeys: languagesKeys, languages: &languages)
            } else if command == "delete" {
                try printWitAllArg(key: key, language: language, languagesKeys: languagesKeys, languages: &languages)
                try updatingDataClass.settingData(languages: &languages)
            } else if command == "update" {
                print("обновление")
            }
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

    func printWitAllArg(key: String, language: String, languagesKeys: [String], languages: inout [Language]) {
        guard !languagesKeys.contains(language) else {
            for i in 0...languages.count - 1 {
                for (wordKey, value) in languages[i].words
                    where wordKey == key && languages[i].key == language {
                    if command == "search" {
                        print("\(value)")
                        break
                    } else if command == "delete" {
                        deleter.deleteWithAllArg(indexValue: i, key: key, languages: &languages)
                        print("Word \(value) was deleted from language \(languages[i].key)")
                        break
                    }
                }
            }
            return
        }
        print("Not Found")
    }
}




