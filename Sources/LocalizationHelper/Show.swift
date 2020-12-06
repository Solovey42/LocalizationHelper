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

    func startShowing(key: String?, language: String?) -> Result<[(languageKey: String,key: String, value: String)], ExitCodes> {
        let data = gettingDataClass.gettingData()
        switch data {
        case .success(let languages):
            self.languages = languages
        case .failure(let error):
            outputClass.printError(error: error)
            return .failure(.ReadError)
        }

        self.keys = getterStrings.getKeys(languages: languages)
        self.languagesKeys = getterStrings.getLanguagesKeys(languages: languages)

        if language == nil && key == nil {
        let words = searchClass.searchWithOutArg(keys: keys, languages: languages)
        return showWithOutArg(items: words)
        } else if let argLanguage = language, let argKey = key {
            let word = searchClass.searchWitAllArg(keys: keys, languagesKeys: languagesKeys, language: argLanguage, languages: languages, key: argKey)
            return showWithAllArg(argLanguage: argLanguage, argKey: argKey, item: word)
        } else if let argKey = key {
            let words = searchClass.searchWithKey(keys: keys, key: argKey, languages: languages)
            return showWithKey(argKey: argKey, key: argKey, items: words)
        } else if let argLanguage = language {
            let indexLanguage = searchClass.searchWithLanguage(languagesKeys: languagesKeys, language: argLanguage, languages: languages)
            return showWithLanguage(argLanguage: argLanguage, indexLanguage: indexLanguage)
        } else {
            return .failure(.ShowError)
        }
    }


    func showWithOutArg(items: [(key: String, languageKey: String, value: String)]) -> Result<[(languageKey: String,key: String, value: String)], ExitCodes> {
        var result: [(languageKey: String, key: String, value: String)] = []
        for key in keys {
            outputClass.printWord(word: key)
            for item in items {
                if key == item.key {
                    outputClass.printWithAllArg(key: item.languageKey, value: item.value)
                    result.append((languageKey: item.languageKey , key: item.key, value: item.value))
                }
            }
        }
        return .success(result)
    }

    func showWithKey(argKey: String, key: String, items: Result<[(indexValue: Int, key: String, value: String)], ExitCodes>) -> Result<[(languageKey: String,key: String, value: String)], ExitCodes> {
        switch items {
        case .success(let words):
            var result: [(languageKey: String, key: String, value: String)] = []
            for item in words {
                outputClass.printWithAllArg(key: languagesKeys[item.indexValue], value: item.value)
                result.append((languageKey: languagesKeys[item.indexValue] , key: item.key, value: item.value))
            }
            return .success(result)
        case .failure(let error):
            outputClass.printError(error: error)
            return .failure(error)
        }
    }

    func showWithLanguage(argLanguage: String, indexLanguage: Result<Int, ExitCodes>) -> Result<[(languageKey: String,key: String, value: String)], ExitCodes> {
        switch indexLanguage {
        case .success(let index):
            var result: [(languageKey: String, key: String, value: String)] = []
            for (key, value) in languages[index].words {
                outputClass.printWithAllArg(key: key, value: value)
                result.append((languageKey:  languagesKeys[index] , key: key, value: value))
            }
            return .success(result)
        case .failure(let error):
            outputClass.printError(error: error)
            return .failure(error)
        }
    }

    func showWithAllArg(argLanguage: String, argKey: String, item: Result<(indexValue: Int, key: String, value: String), ExitCodes>) -> Result<[(languageKey: String,key: String, value: String)], ExitCodes> {
        switch item {
        case .success(let word):
            var result: [(languageKey: String, key: String, value: String)] = []
            outputClass.printWord(word: word.value)
            result.append((languageKey: languagesKeys[word.indexValue] , key: word.key, value: word.value))
            return .success(result)
        case .failure(let error):
            outputClass.printError(error: error)
            return .failure(error)
        }
    }
}
