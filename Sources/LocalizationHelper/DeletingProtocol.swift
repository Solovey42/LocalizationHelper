import Foundation

public protocol DeletingProtocol {
    func startDeleting(key: String?, language: String?, data: [Language]?) -> Result<String, ExitCodes>
}