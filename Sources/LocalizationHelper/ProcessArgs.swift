//
// Created by solo on 10/16/20.
//

import Foundation

public class ProcessArgs {
    var arg: Array<String> = []
    var config: String? = ""
    var word: String? = ""
    var language = ""
    var key = ""

    init(ArgArray: Array<String>) {
        arg = ArgArray
        if let index = ArgArray.firstIndex(of: "-l") {
            language = ArgArray[index + 1]
        }
        if let index = ArgArray.firstIndex(of: "-k") {
            key = ArgArray[index + 1]
        }
    }

    init(stringConfig: String?, stringWord: String? = "", stringKey: String, stringLanguage: String) {
        config = stringConfig
        word = stringWord
        language = stringLanguage
        key = stringKey
    }
}


