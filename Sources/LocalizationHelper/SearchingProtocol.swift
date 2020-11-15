import Foundation

protocol SearchingProtocol {
    func search(command: String, key: String, language: String, word: String) throws
}
