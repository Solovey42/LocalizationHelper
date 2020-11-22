import Foundation

class SearchData: SearchingProtocol {

    func searchWithOutArg(keys: [String], languages: [Language]) -> [(key: String, languageKey: String, value: String)] {
        var array: [(String, String, String)] = []
        for item in keys {
            for n in 0...languages.count - 1 {
                for (key, value) in languages[n].words
                    where item == key {
                    array.append((key, languages[n].key, value))
                }
            }
        }
        return array
    }

    func searchWithLanguage(languagesKeys: [String], language: String, languages: [Language]) -> Int? {
        for i in 0...languages.count - 1 {
            if languages[i].key == language {
                return i
            }
        }
        return nil
    }

    func searchWithKey(keys: [String], key: String, languages: [Language]) -> [(indexValue: Int, key: String, value: String)]? {
        var array: [(Int, String, String)] = []
        for i in 0...languages.count - 1 {
            if languages[i].words.keys.contains(key) {
                for (wordKey, value) in languages[i].words
                    where wordKey == key {
                    array.append((i, key, value))
                }
            }
        }
        return array
    }

    func searchWitAllArg(languagesKeys: [String], language: String, languages: [Language], key: String) -> (indexValue: Int, key: String, value: String)? {
        for i in 0...languages.count - 1 {
            for (wordKey, value) in languages[i].words
                where wordKey == key && languages[i].key == language {
                return (i, key, value)
            }
        }
        return nil
    }

    func checkLanguage(languagesKeys: [String], language: String) -> Bool {
        guard languagesKeys.contains(language) else {
            return false
        }
        return true
    }

    func checkKey(keys: [String], key: String) -> Bool {
        guard keys.contains(key) else {
            return false
        }
        return true
    }
}




