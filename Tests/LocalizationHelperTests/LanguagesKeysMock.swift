import Foundation
@testable import LocalizationHelper

class LanguagesKeysMock: GetStringKeysProtocol {

    var getKeysParameters: [Language]!
    var getKeysCallsCount = 0
    var getKeysResult: [String]!

    func getKeys(languages: [Language]) -> [String] {
        getKeysCallsCount += 1
        getKeysParameters = languages
        return getKeysResult
    }

    var getLanguagesKeysParameters: [Language]!
    var getLanguagesKeysCallsCount = 0
    var getLanguagesKeysResult: [String]!

    func getLanguagesKeys(languages: [Language]) -> [String] {
        getLanguagesKeysCallsCount += 1
        getLanguagesKeysParameters = languages
        return getLanguagesKeysResult
    }
}