import Foundation

class DeleteData: DeletingProtocol {
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

    func startDeleting(key: String?, language: String?) -> Result<String, ExitCodes> {

        let data = gettingDataClass.gettingData()
        switch data {
        case .success(let languages):
            self.languages = languages
        case .failure(let error):
            outputClass.printError(error: error)
            return .failure(error)
        }

        self.keys = getterStrings.getKeys(languages: languages)
        self.languagesKeys = getterStrings.getLanguagesKeys(languages: languages)

        if let argLanguage = language, let argKey = key {
            let word = searchClass.searchWitAllArg(keys: keys, languagesKeys: languagesKeys, language: argLanguage, languages: languages, key: argKey)
            return deleteWithAllArg(argLanguage: argLanguage, argKey: argKey, item: word)
        } else if let argKey = key {
            let words = searchClass.searchWithKey(keys: keys, key: argKey, languages: languages)
            return deleteWithKey(argKey: argKey, items: words)
        } else if let argLanguage = language {
            let indexLanguage = searchClass.searchWithLanguage(languagesKeys: languagesKeys, language: argLanguage, languages: languages)
            return deleteWithLanguage(argLanguage: argLanguage, indexLanguage: indexLanguage)
        } else {
            return .failure(.DeleteError)
        }
    }

    func deleteWithKey(argKey: String, items: Result<[(indexValue: Int, key: String, value: String)], ExitCodes>) -> Result<String, ExitCodes> {
        switch items {
        case .success(let words):
            for item in words {
                languages[item.indexValue].words.removeValue(forKey: item.key)
                do {
                    try updatingDataClass.settingData(languages: &languages)
                } catch {
                    outputClass.printError(error: ExitCodes.WriteError)
                    return .failure(.WriteError)
                }
                outputClass.printDeleteWord(key: languages[item.indexValue].key, value: item.value)
            }
            return .success(argKey)
        case .failure(let error):
            outputClass.printError(error: error)
            return .failure(error)
        }
    }

    func deleteWithLanguage(argLanguage: String, indexLanguage: Result<Int, ExitCodes>) -> Result<String, ExitCodes> {

        switch indexLanguage {
        case .success(let index):
            languages.remove(at: index)
            do {
                try updatingDataClass.settingData(languages: &languages)
            } catch {
                outputClass.printError(error: ExitCodes.WriteError)
                return .failure(.WriteError)
            }
            outputClass.printDeleteLanguage(value: languagesKeys[index])
            return .success(argLanguage)
        case .failure(let error):
            outputClass.printError(error: error)
            return .failure(error)
        }
    }

    func deleteWithAllArg(argLanguage: String, argKey: String, item: Result<(indexValue: Int, key: String, value: String), ExitCodes>) -> Result<String, ExitCodes> {
        switch item {
        case .success(let deletingWord):
            languages[deletingWord.indexValue].words.removeValue(forKey: deletingWord.key)
            do {
                try updatingDataClass.settingData(languages: &languages)
            } catch {
                outputClass.printError(error: ExitCodes.WriteError)
                return .failure(.WriteError)
            }
            outputClass.printDeleteWord(key: languages[deletingWord.indexValue].key, value: deletingWord.value)
            return .success(deletingWord.value)
        case .failure(let error):
            outputClass.printError(error: error)
            return .failure(error)
        }
    }
}