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
            language = ArgArray[ArgArray.firstIndex(of: "-l")! + 1]
        }
        if (ArgArray.contains("-k")) {
            key = ArgArray[ArgArray.firstIndex(of: "-k")! + 1]
        }
    }
}
