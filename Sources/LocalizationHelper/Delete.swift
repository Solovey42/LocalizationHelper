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

    func startDeleting(key: String?, language: String?) -> ExitCodes {
        if let languages = gettingDataClass.gettingData() {
            self.languages = languages
        } else {
            outputClass.printErrorRead()
            return ExitCodes.ReadError
        }

        self.keys = getterStrings.getKeys(languages: languages)
        self.languagesKeys = getterStrings.getLanguagesKeys(languages: languages)

        if let argLanguage = language, let argKey = key {
            let word = searchCLass.searchWitAllArg(keys: keys, languagesKeys: languagesKeys, language: argLanguage, languages: languages, key: argKey)
            return deleteWithAllArg(argLanguage: argLanguage, argKey: argKey, item: word)
        } else if let argKey = key {
            let words = searchCLass.searchWithKey(keys: keys, key: argKey, languages: languages)
            return deleteWithKey(argKey: argKey, items: words)
        } else if let argLanguage = language {
            let indexLanguage = searchCLass.searchWithLanguage(languagesKeys: languagesKeys, language: argLanguage, languages: languages)
            return deleteWithLanguage(argLanguage: argLanguage, indexLanguage: indexLanguage)
        } else {
            return .DeleteError
        }
    }

    func deleteWithKey(argKey: String, items: Result<[(indexValue: Int, key: String, value: String)], ExitCodes>) -> ExitCodes {
        switch items {
        case .success(let words):
            for item in words {
                languages[item.indexValue].words.removeValue(forKey: item.key)
                guard updatingDataClass.settingData(languages: &languages) != nil else {
                    outputClass.printErrorWrite()
                    return .WriteError
                }
                outputClass.printDeleteWord(key: languages[item.indexValue].key, value: item.value)
            }
            return .Success
        case .failure(let error):
            outputClass.printError(error: error)
            return error
        }
    }

    func deleteWithLanguage(argLanguage: String, indexLanguage: Result<Int, ExitCodes>) -> ExitCodes {

        switch indexLanguage {
        case .success(let index):
            languages.remove(at: index)
            guard updatingDataClass.settingData(languages: &languages) != nil else {
                outputClass.printErrorWrite()
                return .WriteError
            }
            outputClass.printDeleteLanguage(value: languagesKeys[index])
            return .Success
        case .failure(let error):
            outputClass.printError(error: error)
            return error
        }
    }

    func deleteWithAllArg(argLanguage: String, argKey: String, item: Result<(indexValue: Int, key: String, value: String), ExitCodes>) -> ExitCodes {
        switch item {
        case .success(let deletingWord):
            languages[deletingWord.indexValue].words.removeValue(forKey: deletingWord.key)
            guard updatingDataClass.settingData(languages: &languages) != nil else {
                outputClass.printErrorWrite()
                return .WriteError
            }
            outputClass.printDeleteWord(key: languages[deletingWord.indexValue].key, value: deletingWord.value)
            return .Success
        case .failure(let error):
            outputClass.printError(error: error)
            return error
        }
    }
}