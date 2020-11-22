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

    func startUpdating(key: String, language: String, word: String) -> Int {
        if let languages = gettingDataClass.gettingData() {
            self.languages = languages
        } else {
            outputClass.printErrorRead()
            return ExitCodes.ReadError.rawValue
        }

        self.keys = getterStrings.getKeys(languages: languages)
        self.languagesKeys = getterStrings.getLanguagesKeys(languages: languages)

        guard self.searchClass.checkLanguage(languagesKeys: languagesKeys, language: language) else {
            return ExitCodes.UnknownLanguage.rawValue
        }
        guard searchClass.checkKey(keys: keys, key: key) else {
            return ExitCodes.UnknownKey.rawValue
        }

        let item = searchClass.searchWitAllArg(languagesKeys: languagesKeys, language: language, languages: languages, key: key)
        if let updatingWord = item {
            languages[updatingWord.indexValue].words.updateValue(word, forKey: updatingWord.key)
            guard updatingDataClass.settingData(languages: &languages) != nil else {
                outputClass.printErrorWrite()
                return ExitCodes.WriteError.rawValue
            }
            outputClass.printUpdate(value: updatingWord.value)
            return ExitCodes.Success.rawValue
        } else if item == nil {
            outputClass.printNotFoundWord()
            return ExitCodes.UnknownWord.rawValue
        } else {
            return ExitCodes.UpdateError.rawValue
        }
    }
}
