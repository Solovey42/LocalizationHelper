import Foundation

protocol UpdatingProtocol {
    func update(indexValue: Int, word: String, key: String, languages: inout [Language])
}
