import Foundation

protocol SearchingProtocol {
    func searchWithOutArg(keys: [String], languages: [Language]) -> [(key: String, languageKey: String, value: String)]
    func searchWithLanguage(languagesKeys: [String], language: String, languages: [Language]) -> Result<Int, ExitCodes>
    func searchWithKey(keys: [String], key: String, languages: [Language]) -> Result<[(indexValue: Int, key: String, value: String)], ExitCodes>
    func searchWitAllArg(keys: [String], languagesKeys: [String], language: String, languages: [Language], key: String) -> Result<(indexValue: Int, key: String, value: String), ExitCodes>
    func checkLanguage(languagesKeys: [String], language: String) -> Bool
    func checkKey(keys: [String], key: String) -> Bool
}
