import Foundation

class DeleteData: DeletingProtocol {
    func deleteWithKey(indexValue: Int, key: String, languages: inout [Language]) {
        languages[indexValue].words.removeValue(forKey: key)
    }
    func deleteWithLanguage(indexValue: Int, languages: inout [Language]) {
        languages.remove(at: indexValue)
    }
    func deleteWithAllArg(indexValue: Int, key: String, languages: inout [Language]) {
        languages[indexValue].words.removeValue(forKey: key)
    }
}