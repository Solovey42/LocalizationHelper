import Foundation

protocol SearchingProtocol {
    var outputClass: OutputProtocol { get set }
    //func search(command: String, key: String, language: String, word: String) throws
    func searchWithOutArg(keys: [String], languages: [Language]) -> (key: String, value: String)?
    func searchWithLanguage(languagesKeys: [String], language: String, languages: [Language]) ->  Int?
    func searchWithKey(keys: [String], key: String, languages: [Language]) -> [(indexValue: Int, key: String, value: String)]
    func searchWitAllArg(languagesKeys: [String], language: String, languages: [Language], key: String, word: String) -> (indexValue: Int, word: String, key: String, value: String)?
}
