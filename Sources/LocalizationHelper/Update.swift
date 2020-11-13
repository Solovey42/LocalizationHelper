import Foundation

class UpdateData: UpdatingProtocol {
    func update(indexValue: Int, word: String, key: String, languages: inout [Language]) {
        languages[indexValue].words.updateValue(word, forKey: key)
    }
}
