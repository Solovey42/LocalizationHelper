//
// Created by solo on 10/16/20.
//

import Foundation

func app(Arg: Array<String>, Languages: Array<Language>) {
    let languages = Languages
    let keys = getKeys(languages: languages)
    let languagesKeys = getLanguagesKeys(languages: languages)
    let process = ProcessArgs.init(ArgArray: Arg)

    if process.language == "" && process.key == "" {
        printWithOutArg(keys: keys)
    } else if process.language == "" && process.key != "" {
        printWithKey(process: process)
    } else if process.language != "" && process.key == "" {
        printWithLanguage(process: process, languagesKeys: languagesKeys)
    } else {
        printWitAllArg(process: process, languagesKeys: languagesKeys)
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

func getLanguagesKeys(languages: Array<Language>) -> Array<String> {
    var languagesKeys: Array<String> = []
    for i in 0...languages.count - 1 {
        if languagesKeys.contains(languages[i].key) == false {
            languagesKeys.append(languages[i].key)
        }
    }
    return languagesKeys
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

func printWithLanguage(process: ProcessArgs, languagesKeys: Array<String>) {
    guard languagesKeys.contains(process.language) else {
        print("Not Found")
        exit(0)
    }
    for i in 0...languages.count - 1 {
        if languages[i].key == process.language {
            for (key, value) in languages[i].Words {
                print("\(key) = \(value)")
            }
        }
    }
}

func printWithKey(process: ProcessArgs) {
    for i in 0...languages.count - 1 {
        if languages[i].Words.keys.contains(process.key) {
            print(process.key)
            break
        } else {
            print("Not Found")
            break
        }
    }
    for i in 0...languages.count - 1 {
        if languages[i].Words.keys.contains(process.key) {
            for (key, value) in languages[i].Words
                where key == process.key {
                print("\t\(languages[i].key): \(value)")
                break
            }
        }
    }
}

func printWitAllArg(process: ProcessArgs, languagesKeys: Array<String>) {
    guard languagesKeys.contains(process.language) else {
        print("Not Found")
        exit(0)
    }

    for i in 0...languages.count - 1 {
        for (key, value) in languages[i].Words
            where key == process.key && languages[i].key == process.language {
            print("\(value)")
            exit(0)
        }
    }
    print("Not found")
}


