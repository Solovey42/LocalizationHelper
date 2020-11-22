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

    func startShowing(key: String?, language: String?) -> ExitCodes {
        if let languages = gettingDataClass.gettingData() {
            self.languages = languages
        } else {
            outputClass.printErrorRead()
            return ExitCodes.ReadError
        }

        self.keys = getterStrings.getKeys(languages: languages)
        self.languagesKeys = getterStrings.getLanguagesKeys(languages: languages)

        if language == nil && key == nil {
            let words = searchCLass.searchWithOutArg(keys: keys, languages: languages)
            return showWithOutArg(items: words)
        } else if let argLanguage = language, let argKey = key {
            let word = searchCLass.searchWitAllArg(languagesKeys: languagesKeys, language: argLanguage, languages: languages, key: argKey)
            return showWithAllArg(argLanguage: argLanguage, argKey: argKey, item: word)
        } else if let argKey = key {
            let words = searchCLass.searchWithKey(keys: keys, key: argKey, languages: languages)
            return showWithKey(argKey: argKey, key: argKey, items: words)
        } else if let argLanguage = language {
            let indexLanguage = searchCLass.searchWithLanguage(languagesKeys: languagesKeys, language: argLanguage, languages: languages)
            return showWithLanguage(argLanguage: argLanguage, indexLanguage: indexLanguage)
        } else {
            return ExitCodes.ShowError
        }
    }


    func showWithOutArg(items: [(key: String, languageKey: String, value: String)]) -> ExitCodes {
        for key in keys {
            outputClass.printWord(word: key)
            for item in items {
                if key == item.key {
                    outputClass.printWithAllArg(key: item.languageKey, value: item.value)
                }
            }
        }
        return ExitCodes.Success
    }

    func showWithKey(argKey: String, key: String, items: [(indexValue: Int, key: String, value: String)]?) -> ExitCodes {
        guard searchCLass.checkKey(keys: keys, key: argKey) else {
            outputClass.printNotFoundKey()
            return ExitCodes.UnknownKey
        }
        outputClass.printWord(word: key)
        if let words = items {
            for item in words {
                outputClass.printWithAllArg(key: languagesKeys[item.indexValue], value: item.value)
            }
        }
        return ExitCodes.Success
    }

    func showWithLanguage(argLanguage: String, indexLanguage: Int?) -> ExitCodes {
        guard searchCLass.checkLanguage(languagesKeys: languagesKeys, language: argLanguage) else {
            outputClass.printNotFoundLanguage()
            return ExitCodes.UnknownLanguage
        }
        if let index = indexLanguage {
            for (key, value) in languages[index].words {
                outputClass.printWithAllArg(key: key, value: value)
            }
        }
        return ExitCodes.Success
    }

    func showWithAllArg(argLanguage: String, argKey: String, item: (indexValue: Int, key: String, value: String)?) -> ExitCodes {
        guard searchCLass.checkLanguage(languagesKeys: languagesKeys, language: argLanguage) else {
            outputClass.printNotFoundLanguage()
            return ExitCodes.UnknownLanguage
        }
        guard searchCLass.checkKey(keys: keys, key: argKey) else {
            outputClass.printNotFoundKey()
            return ExitCodes.UnknownKey
        }
        if let word = item?.value {
            outputClass.printWord(word: word)
            return ExitCodes.Success
        } else {
            outputClass.printNotFoundWord()
            return ExitCodes.UnknownWord
        }
    }
}
