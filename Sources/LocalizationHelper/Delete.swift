import Foundation

class DeleteData: DeletingProtocol {
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

    func startDeleting(key: String?, language: String?) -> Int {
        if let languages = gettingDataClass.gettingData() {
            self.languages = languages
        } else {
            outputClass.printErrorRead()
            return ExitCodes.ReadError.rawValue
        }

        self.keys = getterStrings.getKeys(languages: languages)
        self.languagesKeys = getterStrings.getLanguagesKeys(languages: languages)

        if let argLanguage = language, let argKey = key {
            let word = searchCLass.searchWitAllArg(languagesKeys: languagesKeys, language: argLanguage, languages: languages, key: argKey)
            return deleteWithAllArg(argLanguage: argLanguage, argKey: argKey, item: word)
        } else if let argKey = key {
            let words = searchCLass.searchWithKey(keys: keys, key: argKey, languages: languages)
            return deleteWithKey(argKey: argKey, items: words)
        } else if let argLanguage = language {
            let indexLanguage = searchCLass.searchWithLanguage(languagesKeys: languagesKeys, language: argLanguage, languages: languages)
            return deleteWithLanguage(argLanguage: argLanguage, indexLanguage: indexLanguage)
        } else {
            return ExitCodes.DeleteError.rawValue
        }
    }

    func deleteWithKey(argKey: String, items: [(indexValue: Int, key: String, value: String)]?) -> Int {
        guard searchCLass.checkKey(keys: keys, key: argKey) else {
            return ExitCodes.UnknownKey.rawValue
        }
        if let words = items {
            for item in words {
                languages[item.indexValue].words.removeValue(forKey: item.key)
                guard updatingDataClass.settingData(languages: &languages) != nil else {
                    outputClass.printErrorWrite()
                    return ExitCodes.WriteError.rawValue
                }
                outputClass.printDeleteWord(key: languages[item.indexValue].key, value: item.value)
            }
        }
        return ExitCodes.Success.rawValue
    }

    func deleteWithLanguage(argLanguage: String, indexLanguage: Int?) -> Int {
        guard searchCLass.checkLanguage(languagesKeys: languagesKeys, language: argLanguage) else {
            return ExitCodes.UnknownLanguage.rawValue
        }
        if let index = indexLanguage {
            languages.remove(at: index)
            guard updatingDataClass.settingData(languages: &languages) != nil else {
                outputClass.printErrorWrite()
                return ExitCodes.WriteError.rawValue
            }
            outputClass.printDeleteLanguage(value: languagesKeys[index])
        }
        return ExitCodes.Success.rawValue
    }

    func deleteWithAllArg(argLanguage: String, argKey: String, item: (indexValue: Int, key: String, value: String)?) -> Int {
        guard searchCLass.checkLanguage(languagesKeys: languagesKeys, language: argLanguage) else {
            return ExitCodes.UnknownLanguage.rawValue
        }
        guard searchCLass.checkKey(keys: keys, key: argKey) else {
            return ExitCodes.UnknownKey.rawValue
        }
        if let deletingWord = item {
            languages[deletingWord.indexValue].words.removeValue(forKey: deletingWord.key)
            guard updatingDataClass.settingData(languages: &languages) != nil else {
                outputClass.printErrorWrite()
                return ExitCodes.WriteError.rawValue
            }
            outputClass.printDeleteWord(key: languages[deletingWord.indexValue].key, value: deletingWord.value)
            return ExitCodes.Success.rawValue
        } else {
            outputClass.printNotFoundWord()
            return ExitCodes.UnknownWord.rawValue
        }
    }
}