//
// Created by solo on 16.11.2020.
//

import Foundation

class Output: OutputProtocol {
    func printWithAllArg(key: String, value: String) {
        print("\t\(key) = \(value)")
    }

    func printWord(word: String) {
        print(word)
    }

    func printUpdate(value: String) {
        print("Word \(value) was updated")
    }

    func printDeleteLanguage(value: String) {
        print("Language \(value) was deleted")
    }

    func printDeleteWord(key: String, value: String) {
        print("Word \(value) was deleted from language \(key)")
    }

    func printNotFoundWord() {
        print("Not Found word")
    }

    func printNotFoundKey() {
        print("Not Found key")
    }

    func printNotFoundLanguage() {
        print("Not Found language")
    }

    func printErrorWrite() {
        print("Write error")
    }

    func printErrorRead() {
        print("Read error")
    }

}
