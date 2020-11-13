import Foundation

protocol ArgumentsParserProtocol {
    func parsing() -> Commands?
}

enum Commands {
    case search(command:String, key: String?, language: String?)
    case update(command:String, word: String, key: String, language: String)
    case delete(command:String, key: String?, language: String?)
}