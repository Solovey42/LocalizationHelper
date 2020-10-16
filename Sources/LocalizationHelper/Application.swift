//
// Created by solo on 10/16/20.
//

import Foundation

func app(Arg: Array<String>, Languages: Array<Language>) {
    let process = ProcessArgs.init(ArgArray: Arg)
    let languages = Languages
    let keys = getKeys(languages: languages)
    printWithOutArg(keys: keys)
    for i in 0...Languages.count - 1 {
        if languages[i].key == process.language {
            ///printWithLanguage(process: process)
            if process.language != "" && process.key == "" {
                for (key, value) in languages[i].Words {
                   // print("\(key) = \(value)")
                }
            } else {
                for (key, value) in languages[i].Words
                    where key == process.key {
                    print("\(value)")
                    break
                }

            }

            break
        }
        if languages[i].Words.keys.contains(process.key) {
            for (key, value) in languages[i].Words
                where key == process.key {
                print("\t\(languages[i].key): \(value)")
                print()
                break
            }

        } else {
            ///printWithOutArg(keys: keys)
        }

    }

}

func printWithLanguage(process:ProcessArgs) {
    for i in 0...languages.count - 1 {
            if process.language != "" && process.key == "" {
                for (key, value) in languages[i].Words {
                    print("\(key) = \(value)")
                }
            }
    }
}

func getKeys(languages: Array<Language>) -> Array<String> {
    var keys: Array<String> = []
    for i in 0...languages.count - 1 {
        for (key, _) in languages[i].Words {
            if keys.contains(key) == false {
                keys.append(key)
            }
        }
    }
    return keys
}

func printWithOutArg(keys: Array<String>) {
    for item in keys {
        print(item)
        for n in 0...languages.count - 1 {
            for (key, value) in languages[n].Words
                where item == key {
                print("\t\(languages[n].key) = \(value)")
            }
        }
    }
}
