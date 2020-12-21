import Foundation

class UpdateData: UpdatingProtocol {
    var languages: [Language] = []
    var gettingDataClass: GetDataProtocol?
    var updatingDataClass: SetDataProtocol?
    var getterStrings: GetStringKeysProtocol
    var keys: [String] = []
    var languagesKeys: [String] = []
    var outputClass: OutputProtocol
    var searchClass: SearchingProtocol

    init(gettingDataClass: GetDataProtocol? = nil, updatingDataClass: SetDataProtocol? = nil, getterStrings: GetStringKeysProtocol, outputClass: OutputProtocol, searchingClass: SearchingProtocol) {

        self.gettingDataClass = gettingDataClass
        self.updatingDataClass = updatingDataClass
        self.getterStrings = getterStrings
        self.outputClass = outputClass
        self.searchClass = searchingClass
    }

    func startUpdating(key: String, language: String, word: String, data: [Language]? = nil) -> Result<String, ExitCodes> {
        if gettingDataClass != nil {
            let data = gettingDataClass?.gettingData()
            switch data {
            case .success(let languages):
                self.languages = languages
            case .failure(let error):
                outputClass.printError(error: error)
                return .failure(error)
            case .none:
                return .failure(.ReadError)
            }
        } else if let data = data {
            self.languages = data
        }


        self.keys = getterStrings.getKeys(languages: languages)
        self.languagesKeys = getterStrings.getLanguagesKeys(languages: languages)
        let oldValue:String
        let item = searchClass.searchWitAllArg(keys: keys, languagesKeys: languagesKeys, language: language, languages: languages, key: key)
        switch item {
        case .success(let updatingWord):
            languages[updatingWord.indexValue].words.updateValue(word, forKey: updatingWord.key)
            do {
                try updatingDataClass?.settingData(languages: &languages)
                 oldValue = updatingWord.value
            } catch {
                outputClass.printError(error: ExitCodes.WriteError)
                return .failure(.WriteError)
            }
            outputClass.printUpdate(value: updatingWord.value)
            return .success(oldValue)
        case .failure(let error):
            outputClass.printError(error: error)
            return .failure(error)
        }
    }
}
