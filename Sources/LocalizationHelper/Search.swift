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

    func searchWithLanguage(languagesKeys: [String], language: String, languages: [Language]) -> Result<Int, ExitCodes> {
        guard languagesKeys.contains(language) else {
            return .failure(.UnknownLanguage)
        }
        for i in 0...languages.count - 1 {
            if languages[i].key == language {
                return Result.success(i)
            }
        }
        return .failure(.UnknownLanguage)
    }

    func searchWithKey(keys: [String], key: String, languages: [Language]) -> Result<[(indexValue: Int, key: String, value: String)], ExitCodes> {
        guard keys.contains(key) else {
            return .failure(.UnknownKey)
        }
        var array: [(Int, String, String)] = []
        for i in 0...languages.count - 1 {
            if languages[i].words.keys.contains(key) {
                for (wordKey, value) in languages[i].words
                    where wordKey == key {
                    array.append((i, key, value))
                }
            }
        }
        return .success(array)
    }

    func searchWitAllArg(keys: [String], languagesKeys: [String], language: String, languages: [Language], key: String) -> Result<(indexValue: Int, key: String, value: String), ExitCodes> {
        guard languagesKeys.contains(language) else {
            return .failure(.UnknownLanguage)
        }
        guard keys.contains(key) else {
            return .failure(.UnknownKey)
        }
        for i in 0...languages.count - 1 {
            for (wordKey, value) in languages[i].words
                where wordKey == key && languages[i].key == language {
                return .success((i, key, value))
            }
        }
        return .failure(.UnknownWord)
    }
}




