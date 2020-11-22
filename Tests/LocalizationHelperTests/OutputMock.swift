//
// Created by solo on 22.11.2020.
//

import Foundation
@testable import LocalizationHelper

class OutputMock: OutputProtocol {

    var printWithAllArgParameters: (String, String)!
    var printWithAllArgResult: ()
    var printWithAllArgCallsCount = 0

    func printWithAllArg(key: String, value: String) {
        printWithAllArgCallsCount += 1
        printWithAllArgParameters = (key, value)
        return printWithAllArgResult
    }

    var printWordParameters: String!
    var printWordResult: ()
    var printWordCallsCount = 0

    func printWord(word: String) {
        printWordCallsCount += 1
        printWordParameters = (word)
        return printWordResult
    }

    var printUpdateParameters: String!
    var printUpdateResult: ()
    var printUpdateCallsCount = 0

    func printUpdate(value: String) {
        printUpdateCallsCount += 1
        printUpdateParameters = (value)
        return printUpdateResult
    }

    var printDeleteLanguageParameters: String!
    var printDeleteLanguageResult: ()
    var printDeleteLanguageCallsCount = 0

    func printDeleteLanguage(value: String) {
        printUpdateCallsCount += 1
        printUpdateParameters = (value)
        return printUpdateResult
    }

    var printDeleteWordParameters: (String,String)!
    var printDeleteWordResult: ()
    var printDeleteWordCallsCount = 0

    func printDeleteWord(key: String, value: String) {
        printDeleteWordCallsCount += 1
        printDeleteWordParameters = (key,value)
        return printDeleteWordResult
    }

    var printNotFoundWordParameters: ()
    var printNotFoundWordResult: ()
    var printNotFoundWordCallsCount = 0

    func printNotFoundWord() {
        printNotFoundWordCallsCount += 1
        printNotFoundWordParameters = ()
        return printNotFoundWordResult
    }

    var printNotFoundKeyParameters: ()
    var printNotFoundKeyResult: ()
    var printNotFoundKeyCallsCount = 0

    func printNotFoundKey() {
        printNotFoundKeyCallsCount += 1
        printNotFoundKeyParameters = ()
        return printNotFoundKeyResult
    }

    var printNotFoundLanguageParameters: ()
    var printNotFoundLanguageResult: ()
    var printNotFoundLanguageCallsCount = 0

    func printNotFoundLanguage() {
        printNotFoundLanguageCallsCount += 1
        printNotFoundLanguageParameters = ()
        return printNotFoundLanguageParameters
    }

    var printErrorWriteParameters: ()
    var printErrorWriteResult: ()
    var printErrorWriteCallsCount = 0

    func printErrorWrite() {
        printErrorWriteCallsCount += 1
        printErrorWriteParameters = ()
        return printErrorWriteResult
    }

    var printErrorReadParameters: ()
    var printErrorReadResult: ()
    var printErrorReadCallsCount = 0

    func printErrorRead() {
        printErrorReadCallsCount += 1
        printErrorReadParameters = ()
        return printErrorReadResult
    }

}
