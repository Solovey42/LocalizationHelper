import Foundation

public class ProcessArgs {
    var arg: [String] = []
    var config: String = ""
    var word: String = ""
    var language = ""
    var key = ""

    init(ArgArray: [String]) {
        arg = ArgArray
        if let index = ArgArray.firstIndex(of: "-l") {
            language = ArgArray[index + 1]
        }
        if let index = ArgArray.firstIndex(of: "-k") {
            key = ArgArray[index + 1]
        }
    }

    init(stringConfig: String, stringWord: String = "", stringKey: String, stringLanguage: String) {
        config = stringConfig
        word = stringWord
        language = stringLanguage
        key = stringKey
    }
}


