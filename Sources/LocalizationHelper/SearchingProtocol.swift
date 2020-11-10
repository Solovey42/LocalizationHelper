import Foundation

protocol SearchingProtocol {
    func run(languages: inout [Language],key: String, language: String, getterStrings: GetStringKeysProtocol) throws
}
