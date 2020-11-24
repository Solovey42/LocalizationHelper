import Foundation

protocol ArgumentsParserProtocol {
    func parsing() -> Commands?
    func help()
}

enum Commands {
    case search(key: String?, language: String?)
    case update(word: String, key: String, language: String)
    case delete(key: String?, language: String?)
}