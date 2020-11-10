import Foundation

protocol UpdatingProtocol {
    func run(languages: inout [Language], word: String, key: String, language: String, updatingDataClass: SetDataProtocol) throws
}
