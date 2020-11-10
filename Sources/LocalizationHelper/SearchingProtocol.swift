import Foundation

protocol SearchingProtocol {
    func search(languages: inout [Language],key: String, language: String) throws
}
