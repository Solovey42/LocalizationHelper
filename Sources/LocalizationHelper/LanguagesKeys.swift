//
// Created by solo on 10.11.2020.
//

import Foundation

class LanguagesKeys {
    func getKeys(languages: [Language]) -> [String] {
        var keys: [String] = []
        for i in 0...languages.count - 1 {
            for (key, _) in languages[i].words {
                if keys.contains(key) == false {
                    keys.append(key)
                }
            }
        }
        return keys
    }

    func getLanguagesKeys(languages: [Language]) -> [String] {
        var languagesKeys: [String] = []
        for i in 0...languages.count - 1 {
            if languagesKeys.contains(languages[i].key) == false {
                languagesKeys.append(languages[i].key)
            }
        }
        return languagesKeys
    }
}
