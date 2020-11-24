//
// Created by solo on 16.11.2020.
//

import Foundation

class ShowData: ShowingProtocol {

    var languages: [Language] = []
    var gettingDataClass: GetDataProtocol
    var updatingDataClass: SetDataProtocol
    var getterStrings: GetStringKeysProtocol
    var keys: [String] = []
    var languagesKeys: [String] = []
    var outputClass: OutputProtocol
    var searchClass: SearchingProtocol

    init(gettingDataClass: GetDataProtocol, updatingDataClass: SetDataProtocol, getterStrings: GetStringKeysProtocol, outputClass: OutputProtocol, searchingClass: SearchingProtocol) {
        self.gettingDataClass = gettingDataClass
        self.updatingDataClass = updatingDataClass
        self.getterStrings = getterStrings
        self.outputClass = outputClass
        self.searchClass = searchingClass
    }

    func startShowing(key: String?, language: String?) throws {
        self.languages = try gettingDataClass.gettingData()
        self.keys = getterStrings.getKeys(languages: languages)
        self.languagesKeys = getterStrings.getLanguagesKeys(languages: languages)

        if language == nil && key == nil {
            let words = searchClass.searchWithOutArg(keys: keys, languages: languages)
            showWithOutArg(items: words)
        } else if let argLanguage = language, let argKey = key {
            let word = searchClass.searchWitAllArg(languagesKeys: languagesKeys, language: argLanguage, languages: languages, key: argKey)
            showWithAllArg(item: word)
        } else if let argKey = key {
            let words = searchClass.searchWithKey(keys: keys, key: argKey, languages: languages)
            showWithKey(key: argKey, items: words)
        } else if let argLanguage = language {
            let indexLanguage = searchClass.searchWithLanguage(languagesKeys: languagesKeys, language: argLanguage, languages: languages)
            showWithLanguage(indexLanguage: indexLanguage)
        }
    }


    func showWithOutArg(items: [(key: String, languageKey: String, value: String)]) {
        for key in keys {
            outputClass.printWord(word: key)
            for item in items {
                if key == item.key {
                    outputClass.printWithAllArg(key: item.languageKey, value: item.value)
                }
            }
        }
    }

    func showWithKey(key: String, items: [(indexValue: Int, key: String, value: String)]?) {
        outputClass.printWord(word: key)
        if let words = items {
            for item in words {
                outputClass.printWithAllArg(key: languagesKeys[item.indexValue], value: item.value)
            }
        }
    }

    func showWithLanguage(indexLanguage: Int?) {
        if let index = indexLanguage {
            for (key, value) in languages[index].words {
                outputClass.printWithAllArg(key: key, value: value)
            }
        }
    }

    func showWithAllArg(item: (indexValue: Int, key: String, value: String)?) {
        if let word = item?.value {
            outputClass.printWord(word: word)
        }
    }

}
