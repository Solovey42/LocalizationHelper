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
    func printNotFoundWord()
    func printNotFoundKey()
    func printNotFoundLanguage()
    func printErrorWrite()
    func printErrorRead()
}
