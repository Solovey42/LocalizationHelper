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
    var updaterClass: UpdatingProtocol?

    func run(command: String, key: String, language: String, word: String, gettingDataClass: GetDataProtocol, updatingDataClass: SetDataProtocol, getterStrings: GetStringKeysProtocol, deleterClass: DeletingProtocol, updaterClass: UpdatingProtocol) throws {
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
        self.deleterClass = deleterClass
        self.updaterClass = updaterClass


        if language == "" && key == "" {
            searchWithOutArg(keys: keys, languages: languages)
        } else if language == "" && key != "" {
            searchWithKey(key: key, language: language, keys: keys, languages: &languages)
            if command == "delete" {
                try updatingDataClass.settingData(languages: &languages)
            }
        } else if language != "" && key == "" {
            searchWithLanguage(key: key, language: language, languagesKeys: languagesKeys, languages: &languages)
            if command == "delete" {
                try updatingDataClass.settingData(languages: &languages)
            }
        } else {
            searchWitAllArg(word: word, key: key, language: language, languagesKeys: languagesKeys, languages: &languages)
            if command == "delete" || command == "update" {
                try updatingDataClass.settingData(languages: &languages)
            }
        }
    }

    func searchWithOutArg(keys: [String], languages: [Language]) {
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

    func searchWithLanguage(key: String, language: String, languagesKeys: [String], languages: inout [Language]) {
        guard languagesKeys.contains(language) else {
            print("Not Found")
            exit(0)
        }
        for i in 0...languages.count - 1 {
            if languages[i].key == language {
                if command == "search" {
                    for (key, value) in languages[i].words {
                        print("\(key) = \(value)")
                    }
                } else if command == "delete" {
                    deleterClass?.deleteWithLanguage(indexValue: i, languages: &languages)
                    print("Language \(language) was deleted")
                    break
                }
            }
        }
    }


    func searchWithKey(key: String, language: String, keys: [String], languages: inout [Language]) {
        guard keys.contains(key) else {
            print("Not Found")
            exit(0)
        }
        print(key)
        for i in 0...languages.count - 1 {
            if languages[i].words.keys.contains(key) {
                for (wordKey, value) in languages[i].words
                    where wordKey == key {
                    if command == "search" {
                        print("\t\(languages[i].key): \(value)")
                        break
                    } else if command == "delete" {
                        deleterClass?.deleteWithKey(indexValue: i, key: key, languages: &languages)
                        print("Word \(key) was deleted from language \(languages[i].key)")
                        break
                    }
                }
            }
        }
    }

    func searchWitAllArg(word: String, key: String, language: String, languagesKeys: [String], languages: inout [Language]) {
        guard !languagesKeys.contains(language) else {
            for i in 0...languages.count - 1 {
                for (wordKey, value) in languages[i].words
                    where wordKey == key && languages[i].key == language {
                    if command == "search" {
                        print("\(value)")
                        break
                    } else if command == "delete" {
                        deleterClass?.deleteWithAllArg(indexValue: i, key: key, languages: &languages)
                        print("Word \(value) was deleted from language \(languages[i].key)")
                        break
                    } else if command == "update" {
                        updaterClass?.update(indexValue: i, word: word, key: key, languages: &languages)
                        print("Word \(value) was updated")
                    }
                }
            }
            return
        }
        print("Not Found")
    }

}




