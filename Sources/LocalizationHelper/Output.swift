//
// Created by solo on 16.11.2020.
//

import Foundation

class Output:OutputProtocol {
    func printWithAllArg(key: String, value: String) {
        print("\t\(key) = \(value)")
    }

    func printWord(word: String) {
        print(word)
    }

    func printUpdate(value:String){
        print("Word \(value) was updated")
    }

    func printDeleteLanguage(value: String){
        print("Language \(value) was deleted")
    }

    func printDeleteWord(key: String, value: String){
        print("Word \(value) was deleted from language \(key)")
    }

    func printNotFound(){
        print("Not Found")
    }

}
