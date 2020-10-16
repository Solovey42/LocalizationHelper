//
// Created by solo on 10/16/20.
//

import Foundation

public class ProcessArgs{
    let arg:Array<String> = []
    var language = ""
    var key = ""
    init (Arg:Array<String>){
        if (Arg.contains("-l")){
            language = Arg[Arg.firstIndex(of: "-l") ?? +1]
        }
        if (Arg.contains("-k")){
            key = Arg[Arg.firstIndex(of: "-k") ?? +1]
        }
    }
}
