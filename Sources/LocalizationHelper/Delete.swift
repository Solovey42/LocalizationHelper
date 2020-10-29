//
// Created by solo on 29.10.2020.
//

import Foundation

func delete(languages: inout [Language], process: ProcessArgs, path: String) throws {

    let keys = getKeys(languages: languages)
    let languagesKeys = getLanguagesKeys(languages: languages)
    if process.language == "" && process.key != "" {
        deleteWithKey(process: process, keys: keys, languages: &languages)
    } else if process.language != "" && process.key == "" {
        deleteWithLanguage(process: process, languagesKeys: languagesKeys, languages: &languages)
    } else if process.language != "" && process.key != "" {
        deleteWithAllArg(process: process, languagesKeys: languagesKeys, languages: &languages)
    }
    let json = try JSONEncoder().encode(languages.self)
    try json.write(to: URL(fileURLWithPath: path))
}

func deleteWithKey(process: ProcessArgs, keys: Array<String>, languages: inout Array<Language>) {
    guard keys.contains(process.key) else {
        print("Not Found")
        exit(0)
    }
    for i in 0...languages.count - 1 {
        if languages[i].words.keys.contains(process.key) {
            for (key, _) in languages[i].words
                where key == process.key {
                languages[i].words.removeValue(forKey: key)
                print("Word \(key) was deleted")
                break
            }
        }
    }
}

func deleteWithLanguage(process: ProcessArgs, languagesKeys: Array<String>, languages: inout Array<Language>) {
    guard languagesKeys.contains(process.language) else {
        print("Not Found")
        exit(0)
    }
    for i in 0...languages.count - 1 {
        if languages[i].key == process.language {
            languages.remove(at: i)
            print("Language \(languages[i].key) was deleted")
            break
        }
    }
}

func deleteWithAllArg(process: ProcessArgs, languagesKeys: Array<String>, languages: inout Array<Language>) {
    guard languagesKeys.contains(process.language) else {
        print("Not Found")
        exit(0)
    }
    for i in 0...languages.count - 1 {
        for (key, value) in languages[i].words
            where key == process.key && languages[i].key == process.language {
            languages[i].words.removeValue(forKey: key)
            print("Word \(value) was deleted from languages \(languages[i].key)")
            break
        }
    }
}