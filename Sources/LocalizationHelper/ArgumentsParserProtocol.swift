//
// Created by solo on 05.11.2020.
//

import Foundation

protocol ArgumentsParserProtocol {
    func parsing() -> Commands?
}

enum Commands {
    case search(key: String?, language: String?)
    case update(word: String, key: String, language: String)
    case delete(key: String?, language: String?)
}