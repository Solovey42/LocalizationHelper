//
// Created by solo on 10/16/20.
//

import Foundation

struct Russian: LanguageProtocol {
    let key = "rus"
    var words: [String: String] = ["hello": "Привет", "day": "День"]
}

struct English: LanguageProtocol {
    let key = "en"
    var words: [String: String] = ["hello": "Hello", "day": "Day", "terms": "Terms"]
}

struct Portuguese: LanguageProtocol {
    let key = "pt"
    var words: [String: String] = ["day": "Dia", "terms": "Termos"]
}