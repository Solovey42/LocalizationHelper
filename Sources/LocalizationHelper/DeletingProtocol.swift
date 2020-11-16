import Foundation

protocol DeletingProtocol {
    func startDeleting( key: String, language: String, word: String) throws
    func deleteWithKey(items: [(indexValue: Int, key: String, value: String)])
    func deleteWithLanguage(indexLanguage: Int?)
    func deleteWithAllArg(item: (indexValue: Int, word: String, key: String, value: String)?)
}