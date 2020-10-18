//
// Created by solo on 10/16/20.
//

import Foundation

public class ProcessArgs {
    var arg: Array<String> = []
    var language = ""
    var key = ""

    init(ArgArray: Array<String>) {
        arg = ArgArray
        if (ArgArray.contains("-l")) {
            if let index = ArgArray.firstIndex(of: "-l") {
                language = ArgArray[index + 1]
            }

        } else {
            language = ""
        }
        if (ArgArray.contains("-k")) {
            if let index = ArgArray.firstIndex(of: "-k") {
                key = ArgArray[index + 1]
            }
        }
    }
}
