import Foundation
@testable import LocalizationHelper

class OutputMock: OutputProtocol {

    var printWithAllArgParameters: (String, String)!
    var printWithAllArgCallsCount = 0

    func printWithAllArg(key: String, value: String) {
        printWithAllArgCallsCount += 1
        printWithAllArgParameters = (key, value)
    }

    var printWordParameters: String!
    var printWordCallsCount = 0

    func printWord(word: String) {
        printWordCallsCount += 1
        printWordParameters = (word)
    }

    var printUpdateParameters: String!
    var printUpdateCallsCount = 0

    func printUpdate(value: String) {
        printUpdateCallsCount += 1
    }

    var printDeleteLanguageParameters: String!
    var printDeleteLanguageCallsCount = 0

    func printDeleteLanguage(value: String) {
        printUpdateCallsCount += 1
        printUpdateParameters = (value)
    }

    var printDeleteWordParameters: (String,String)!
    var printDeleteWordCallsCount = 0

    func printDeleteWord(key: String, value: String) {
        printDeleteWordCallsCount += 1
        printDeleteWordParameters = (key,value)
    }

    var printErrorParameters: ExitCodes!
    var printErrorCallsCount = 0

    func printError(error: ExitCodes) {
        printErrorCallsCount += 1
        printErrorParameters = error
    }
}
