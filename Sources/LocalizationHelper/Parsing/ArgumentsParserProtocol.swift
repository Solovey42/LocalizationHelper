import Foundation

protocol ArgumentsParserProtocol {
    func parsing(_ arguments: [String]?) -> Commands?
    func help()
}

enum Commands {
    case search(key: String?, language: String?)
    case update(word: String, key: String, language: String)
    case delete(key: String?, language: String?)
}