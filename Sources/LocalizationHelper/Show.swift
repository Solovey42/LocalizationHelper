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
    var searchCLass: SearchingProtocol

    init(gettingDataClass: GetDataProtocol, updatingDataClass: SetDataProtocol, getterStrings: GetStringKeysProtocol, outputClass: OutputProtocol, searchingClass: SearchingProtocol) {
        self.gettingDataClass = gettingDataClass
        self.updatingDataClass = updatingDataClass
        self.getterStrings = getterStrings
        self.outputClass = outputClass
        self.searchCLass = searchingClass
    }

    func startShowing(key: String, language: String, word: String) throws {
        self.languages = try gettingDataClass.gettingData()
        self.keys = getterStrings.getKeys(languages: languages)
        self.languagesKeys = getterStrings.getLanguagesKeys(languages: languages)

        if language == "" && key == "" {
            let words = searchCLass.searchWithOutArg(keys: keys, languages: languages)
            showWithOutArg(items: words)
        } else if language == "" && key != "" {
            let words = searchCLass.searchWithKey(keys: keys, key: key, languages: languages)
            showWithKey(key: key, items: words)
        } else if language != "" && key == "" {
            let indexLanguage = searchCLass.searchWithLanguage(languagesKeys: languagesKeys, language: language, languages: languages)
            showWithLanguage(indexLanguage: indexLanguage)
        } else {
            let word = searchCLass.searchWitAllArg(languagesKeys: languagesKeys, language: language, languages: languages, key: key, word: word)
            showWithAllArg(item: word)
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

    func showWithAllArg(item: (indexValue: Int, word: String, key: String, value: String)?) {
        if let word = item?.value {
            outputClass.printWord(word: word)
        }
    }


}
