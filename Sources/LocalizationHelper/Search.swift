import Foundation

class SearchData: SearchingProtocol {
/*    var command: String = ""
    var languages: [Language] = []
    var key: String = ""
    var language: String = ""
    var word: String = ""
    var gettingDataClass: GetDataProtocol
    var updatingDataClass: SetDataProtocol
    var getterStrings: GetStringKeysProtocol
    var keys: [String] = []
    var languagesKeys: [String] = []
    var deleterClass: DeletingProtocol
    var updaterClass: UpdatingProtocol*/
    var outputClass: OutputProtocol

    init(outputClass: OutputProtocol) {

        self.outputClass = outputClass

    }

    /*   var selectorClass: ActionSelectionClass



      func search(command: String, key: String, language: String, word: String) throws {
          self.command = command
          self.languages = try gettingDataClass.gettingData()
          self.key = key
          self.language = language
          self.word = word
          self.keys = getterStrings.getKeys(languages: languages)
          self.languagesKeys = getterStrings.getLanguagesKeys(languages: languages)

          if language == "" && key == "" {
              searchWithOutArg()
          } else if language == "" && key != "" {
              searchWithKey()
              if command == "delete" {
                  try updatingDataClass.settingData(languages: &languages)
              }
          } else if language != "" && key == "" {
              searchWithLanguage()
              if command == "delete" {
                  try updatingDataClass.settingData(languages: &languages)
              }
          } else {
              searchWitAllArg()
              if command == "delete" || command == "update" {
                  try updatingDataClass.settingData(languages: &languages)
              }
          }
      }*/

    func searchWithOutArg(keys: [String], languages: [Language]) -> (key: String, value: String)? {
        for item in keys {
            outputClass.printWord(word: item)
            for n in 0...languages.count - 1 {
                for (key, value) in languages[n].words
                    where item == key {
                    return (languages[n].key, value)
                    outputClass.printWithAllArg(key: languages[n].key, value: value)
                }
            }
        }
        return nil
    }

    func searchWithLanguage(languagesKeys: [String], language: String, languages: [Language]) -> Int?{
        guard languagesKeys.contains(language) else {
            outputClass.printNotFound()
            exit(0)
        }
        for i in 0...languages.count - 1 {
            if languages[i].key == language {
                return i
            }
/*            if command == "search" {
                for (key, value) in languages[i].words {

                    //array.append((i, key, value))
                    //   outputClass.printWithAllArg(key: key, value: value)
                }
                               } else if command == "delete" {
                                   deleterClass.deleteWithLanguage(indexValue: i, languages: &languages)
                                   outputClass.printDeleteLanguage(value: language)
                                   break

            }*/
        }
        return nil
    }

    func searchWithKey(keys: [String], key: String, languages: [Language]) -> [(indexValue: Int, key: String, value: String)] {
        guard keys.contains(key) else {
            outputClass.printNotFound()
            exit(0)
        }
        //outputClass.printWord(word: key)
        var array: [(Int, String, String)] = []
        for i in 0...languages.count - 1 {
            if languages[i].words.keys.contains(key) {
                for (wordKey, value) in languages[i].words
                    where wordKey == key {
                    array.append((i, key, value))
/*                    if command == "search" {
                        outputClass.printWithAllArg(key: languages[i].key, value: value)
                        break
                    } else if command == "delete" {
                        deleterClass.deleteWithKey(indexValue: i, key: key, languages: &languages)
                        outputClass.printDeleteWord(key: key, value: languages[i].key)
                        break
                    }*/
                }
            }
        }
        return array
    }

    func searchWitAllArg(languagesKeys: [String], language: String, languages: [Language], key: String, word: String) -> (indexValue: Int, word: String, key: String, value: String)? {
        guard !languagesKeys.contains(language) else {
            for i in 0...languages.count - 1 {
                for (wordKey, value) in languages[i].words
                    where wordKey == key && languages[i].key == language {
                    return (i, word, key, value)
/*                    if command == "search" {
                        outputClass.printWord(word: value)
                        break
                    } else if command == "delete" {
                        deleterClass.deleteWithAllArg(indexValue: i, key: key, languages: &languages)
                        outputClass.printDeleteWord(key: languages[i].key, value: value)
                        break
                    } else if command == "update" {
                        updaterClass.update(indexValue: i, word: word, key: key, languages: &languages)
                        outputClass.printUpdate(value: value)
                    }*/
                }
            }
            return nil
        }
        outputClass.printNotFound()
        return nil
    }

}




