import Foundation
@testable import LocalizationHelper

class SearchDataMock: SearchingProtocol {

    var searchWithOutArgParameters: (keys: [String], languages: [Language])!
    var searchWithOutArgCallsCount = 0
    var searchWithOutArgResult: [(String, String, String)]!

    func searchWithOutArg(keys: [String], languages: [Language]) -> [(key: String, languageKey: String, value: String)] {
        searchWithOutArgCallsCount += 1
        searchWithOutArgParameters = (keys, languages)
        return searchWithOutArgResult
    }

    var searchWithLanguageParameters: (languagesKeys: [String], language: String, languages: [Language])!
    var searchWithLanguageCallsCount = 0
    var searchWithLanguageResult: Result<Int, ExitCodes>!

    func searchWithLanguage(languagesKeys: [String], language: String, languages: [Language]) -> Result<Int, ExitCodes> {
        searchWithLanguageCallsCount += 1
        searchWithLanguageParameters = (languagesKeys, language, languages)
        return searchWithLanguageResult
    }

    var searchWithKeyParameters: (keys: [String], key: String, languages: [Language])!
    var searchWithKeyCallsCount = 0
    var searchWithKeyResult: Result<[(indexValue: Int, key: String, value: String)], ExitCodes>!

    func searchWithKey(keys: [String], key: String, languages: [Language]) -> Result<[(indexValue: Int, key: String, value: String)], ExitCodes> {
        searchWithKeyCallsCount += 1
        searchWithKeyParameters = (keys, key, languages)
        return searchWithKeyResult
    }

    var searchWitAllArgParameters: (keys: [String], languagesKeys: [String], language: String, languages: [Language], key: String)!
    var searchWitAllArgCallsCount = 0
    var searchWitAllArgResult: Result<(indexValue: Int, key: String, value: String), ExitCodes>!

    func searchWitAllArg(keys: [String], languagesKeys: [String], language: String, languages: [Language], key: String) -> Result<(indexValue: Int, key: String, value: String), ExitCodes> {
        searchWitAllArgCallsCount += 1
        searchWitAllArgParameters = (keys, languagesKeys, language, languages, key)
        return searchWitAllArgResult
    }
}