import Foundation

class UpdateData: UpdatingProtocol {
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

    func startUpdating(key: String, language: String, word: String) -> ExitCodes {
        if let languages = gettingDataClass.gettingData() {
            self.languages = languages
        } else {
            outputClass.printErrorRead()
            return ExitCodes.ReadError
        }

        self.keys = getterStrings.getKeys(languages: languages)
        self.languagesKeys = getterStrings.getLanguagesKeys(languages: languages)

        guard self.searchClass.checkLanguage(languagesKeys: languagesKeys, language: language) else {
            outputClass.printNotFoundLanguage()
            return ExitCodes.UnknownLanguage
        }
        guard searchClass.checkKey(keys: keys, key: key) else {
            outputClass.printNotFoundKey()
            return ExitCodes.UnknownKey
        }

        let item = searchClass.searchWitAllArg(languagesKeys: languagesKeys, language: language, languages: languages, key: key)
        if let updatingWord = item {
            languages[updatingWord.indexValue].words.updateValue(word, forKey: updatingWord.key)
            guard updatingDataClass.settingData(languages: &languages) != nil else {
                outputClass.printErrorWrite()
                return ExitCodes.WriteError
            }
            outputClass.printUpdate(value: updatingWord.value)
            return ExitCodes.Success
        } else if item == nil {
            outputClass.printNotFoundWord()
            return ExitCodes.UnknownWord
        } else {
            return ExitCodes.UpdateError
        }
    }
}
