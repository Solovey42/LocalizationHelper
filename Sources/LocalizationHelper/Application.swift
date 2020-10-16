//
// Created by solo on 10/16/20.
//

import Foundation

func app(Arg: Array<String>, Languages: Array<Language>) {
    let process = ProcessArgs.init(ArgArray: Arg)
    let languages = Languages

    for i in 0...Languages.count - 1 {
        if languages[i].key == process.language {
            for (key,value) in languages[i].Words {
                print("\(key) = \(value)")
            }
            break
        }
    }

}