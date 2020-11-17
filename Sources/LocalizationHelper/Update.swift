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

    func startUpdating(key: String, language: String, word: String) throws {
        self.languages = try gettingDataClass.gettingData()
        self.keys = getterStrings.getKeys(languages: languages)
        self.languagesKeys = getterStrings.getLanguagesKeys(languages: languages)

        let item = searchClass.searchWitAllArg(languagesKeys: languagesKeys, language: language, languages: languages, key: key)

        if let updatingWord = item {
            languages[updatingWord.indexValue].words.updateValue(word, forKey: updatingWord.key)
            outputClass.printUpdate(value: updatingWord.value)
        }
        try updatingDataClass.settingData(languages: &languages)
    }
}
