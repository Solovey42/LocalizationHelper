//
// Created by solo on 29.10.2020.
//

import Foundation

func update(languages: inout [Language], process: ProcessArgs, path: String) throws {
    let languagesKeys = getLanguagesKeys(languages: languages)
    guard languagesKeys.contains(process.language) else {
        print("Not Found")
        exit(0)
    }
    for i in 0...languages.count - 1 {
        for (key, value) in languages[i].words
            where key == process.key && languages[i].key == process.language {
            languages[i].words.updateValue(process.word, forKey: key)
            let json = try JSONEncoder().encode(languages.self)
            try json.write(to: URL(fileURLWithPath: path))
            print("Word \(value) was updated")
            exit(0)
        }
    }
    print("Not found")
}