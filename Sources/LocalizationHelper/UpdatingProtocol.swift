import Foundation

public protocol UpdatingProtocol {
    func startUpdating(key: String, language: String, word: String, data: [Language]?) -> Result<String, ExitCodes>
}
