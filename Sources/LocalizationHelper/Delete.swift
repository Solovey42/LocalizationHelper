import Foundation

class DeleteData: DeletingProtocol {
    var languages: [Language] = []
    var key: String = ""
    var language: String = ""
    var word: String = ""
    var gettingDataClass: GetDataProtocol
    var updatingDataClass: SetDataProtocol
    var getterStrings: GetStringKeysProtocol
    var keys: [String] = []
    var languagesKeys: [String] = []
    var updaterClass: UpdatingProtocol
    var outputClass: OutputProtocol
    var searchCLass: SearchingProtocol

    init(gettingDataClass: GetDataProtocol, updatingDataClass: SetDataProtocol, getterStrings: GetStringKeysProtocol, updaterClass: UpdatingProtocol, outputClass: OutputProtocol, searchingClass: SearchingProtocol) {
        self.gettingDataClass = gettingDataClass
        self.updatingDataClass = updatingDataClass
        self.getterStrings = getterStrings
        self.updaterClass = updaterClass
        self.outputClass = outputClass
        self.searchCLass = searchingClass
    }

    func startDeleting(key: String, language: String, word: String) throws {
        self.languages = try gettingDataClass.gettingData()
        self.key = key
        self.language = language
        self.word = word
        self.keys = getterStrings.getKeys(languages: languages)
        self.languagesKeys = getterStrings.getLanguagesKeys(languages: languages)

        if language == "" && key != "" {
            let words = searchCLass.searchWithKey(keys: keys, key: key, languages: languages)
            deleteWithKey(items: words)
        } else if language != "" && key == "" {
            let indexLanguage = searchCLass.searchWithLanguage(languagesKeys: languagesKeys, language: language, languages: languages)
            deleteWithLanguage(indexLanguage: indexLanguage)
        } else {
            let word = searchCLass.searchWitAllArg(languagesKeys: languagesKeys, language: language, languages: languages, key: key, word: word)
            deleteWithAllArg(item: word)
        }
        try updatingDataClass.settingData(languages: &languages)
    }

    func deleteWithKey(items: [(indexValue: Int, key: String, value: String)]) {
        for item in items {
            languages[item.indexValue].words.removeValue(forKey: item.key)
        }
    }

    func deleteWithLanguage(indexLanguage: Int?) {
        if let index = indexLanguage {
            languages.remove(at: index)
        }
    }

    func deleteWithAllArg(item: (indexValue: Int, word: String, key: String, value: String)?) {
        if let index = item?.indexValue {
            languages[index].words.removeValue(forKey: item?.key ?? "")
        }
    }
}