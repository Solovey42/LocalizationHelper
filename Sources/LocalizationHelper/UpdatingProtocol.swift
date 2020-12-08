import Foundation

public protocol UpdatingProtocol {
    func startUpdating(key: String, language: String, word: String) -> Result<String, ExitCodes>
}
