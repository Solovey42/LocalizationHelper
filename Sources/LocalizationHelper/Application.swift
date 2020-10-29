//
// Created by solo on 10/16/20.
//

import Foundation

func search(languages: inout [Language],process: ProcessArgs,path: String) throws {

    let keys = getKeys(languages: languages)
    let languagesKeys = getLanguagesKeys(languages: languages)

    if process.language == "" && process.key == "" {
        printWithOutArg(keys: keys, languages: languages)
    } else if process.language == "" && process.key != "" {
        printWithKey(process: process, keys: keys, languages: languages)
    } else if process.language != "" && process.key == "" {
        printWithLanguage(process: process, languagesKeys: languagesKeys, languages: languages)
    } else {
        printWitAllArg(process: process, languagesKeys: languagesKeys, languages: languages)
    }

}

func getKeys(languages: Array<Language>) -> Array<String> {
    var keys: Array<String> = []
    for i in 0...languages.count - 1 {
        for (key, _) in languages[i].words {
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

func printWithOutArg(keys: Array<String>, languages: Array<Language>) {
    for item in keys {
        print(item)
        for n in 0...languages.count - 1 {
            for (key, value) in languages[n].words
                where item == key {
                print("\t\(languages[n].key) = \(value)")
            }
        }
    }
}

func printWithLanguage(process: ProcessArgs, languagesKeys: Array<String>, languages: Array<Language>) {
    guard languagesKeys.contains(process.language) else {
        print("Not Found")
        exit(0)
    }
    for i in 0...languages.count - 1 {
        if languages[i].key == process.language {
            for (key, value) in languages[i].words {
                print("\(key) = \(value)")
            }
        }
    }
}

func printWithKey(process: ProcessArgs, keys: Array<String>, languages: Array<Language>) {
    guard keys.contains(process.key) else {
        print("Not Found")
        exit(0)
    }
    print(process.key)
    for i in 0...languages.count - 1 {
        if languages[i].words.keys.contains(process.key) {
            for (key, value) in languages[i].words
                where key == process.key {
                print("\t\(languages[i].key): \(value)")
                break
            }
        }
    }
}

func printWitAllArg(process: ProcessArgs, languagesKeys: Array<String>, languages: Array<Language>) {
    guard languagesKeys.contains(process.language) else {
        print("Not Found")
        exit(0)
    }

    for i in 0...languages.count - 1 {
        for (key, value) in languages[i].words
            where key == process.key && languages[i].key == process.language {
            print("\(value)")
            exit(0)
        }
    }
    print("Not found")
}




