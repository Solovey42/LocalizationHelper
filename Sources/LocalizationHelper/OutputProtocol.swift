//
// Created by solo on 16.11.2020.
//

import Foundation

protocol OutputProtocol {
    func printWithAllArg(key: String, value: String)
    func printWord(word: String)
    func printUpdate(value: String)
    func printDeleteLanguage(value: String)
    func printDeleteWord(key: String, value: String)
    func printError(error: ExitCodes)
}
