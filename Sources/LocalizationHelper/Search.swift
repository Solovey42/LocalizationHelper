import Foundation

class SearchData: SearchingProtocol {
    var outputClass: OutputProtocol

    init(outputClass: OutputProtocol) {

        self.outputClass = outputClass

    }

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
        guard languagesKeys.contains(language) else {
            outputClass.printNotFound()
            return nil
        }
        for i in 0...languages.count - 1 {
            if languages[i].key == language {
                return i
            }
        }
        return nil
    }

    func searchWithKey(keys: [String], key: String, languages: [Language]) -> [(indexValue: Int, key: String, value: String)]? {
        guard keys.contains(key) else {
            outputClass.printNotFound()
            return nil
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
        return array
    }

    func searchWitAllArg(languagesKeys: [String], language: String, languages: [Language], key: String) -> (indexValue: Int, key: String, value: String)? {
        guard !languagesKeys.contains(language) else {
            for i in 0...languages.count - 1 {
                for (wordKey, value) in languages[i].words
                    where wordKey == key && languages[i].key == language {
                    return (i, key, value)
                }
            }
            outputClass.printNotFound()
            return nil
        }
        outputClass.printNotFound()
        return nil
    }

}




