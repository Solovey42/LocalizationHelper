import Foundation

protocol SearchingProtocol {
    func searchWithOutArg(keys: [String], languages: [Language]) -> [(key: String, languageKey: String, value: String)]
    func searchWithLanguage(languagesKeys: [String], language: String, languages: [Language]) ->  Int?
    func searchWithKey(keys: [String], key: String, languages: [Language]) -> [(indexValue: Int, key: String, value: String)]?
    func searchWitAllArg(languagesKeys: [String], language: String, languages: [Language], key: String) -> (indexValue: Int, key: String, value: String)?
    func checkLanguage(languagesKeys: [String], language: String) -> Bool
    func checkKey(keys: [String], key: String) -> Bool
}
