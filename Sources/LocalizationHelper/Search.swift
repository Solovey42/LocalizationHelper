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
    var outputClass: OutputProtocol?

    func run(command: String, key: String, language: String, word: String, gettingDataClass: GetDataProtocol, updatingDataClass: SetDataProtocol, getterStrings: GetStringKeysProtocol, deleterClass: DeletingProtocol, updaterClass: UpdatingProtocol, outputClass: OutputProtocol) throws {
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
        self.outputClass = outputClass


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
            outputClass?.printWord(word: item)
            for n in 0...languages.count - 1 {
                for (key, value) in languages[n].words
                    where item == key {
                    outputClass?.printWithAllArg(key: languages[n].key, value: value)
                }
            }
        }
    }

    func searchWithLanguage(key: String, language: String, languagesKeys: [String], languages: inout [Language]) {
        guard languagesKeys.contains(language) else {
            outputClass?.printNotFound()
            exit(0)
        }
        for i in 0...languages.count - 1 {
            if languages[i].key == language {
                if command == "search" {
                    for (key, value) in languages[i].words {
                        outputClass?.printWithAllArg(key: key, value: value)
                    }
                } else if command == "delete" {
                    deleterClass?.deleteWithLanguage(indexValue: i, languages: &languages)
                    outputClass?.printDeleteLanguage(value: language)
                    break
                }
            }
        }
    }


    func searchWithKey(key: String, language: String, keys: [String], languages: inout [Language]) {
        guard keys.contains(key) else {
            outputClass?.printNotFound()
            exit(0)
        }
        outputClass?.printWord(word: key)
        for i in 0...languages.count - 1 {
            if languages[i].words.keys.contains(key) {
                for (wordKey, value) in languages[i].words
                    where wordKey == key {
                    if command == "search" {
                        outputClass?.printWithAllArg(key: languages[i].key, value: value)
                        break
                    } else if command == "delete" {
                        deleterClass?.deleteWithKey(indexValue: i, key: key, languages: &languages)
                        outputClass?.printDeleteWord(key: key, value: languages[i].key)
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
                        outputClass?.printWord(word: value)
                        break
                    } else if command == "delete" {
                        deleterClass?.deleteWithAllArg(indexValue: i, key: key, languages: &languages)
                        outputClass?.printDeleteWord(key: languages[i].key, value: value)
                        break
                    } else if command == "update" {
                        updaterClass?.update(indexValue: i, word: word, key: key, languages: &languages)
                        outputClass?.printUpdate(value: value)

                    }
                }
            }
            return
        }
        outputClass?.printNotFound()
    }

}




