import Foundation

public protocol DeletingProtocol {
    func startDeleting(key: String?, language: String?) -> Result<String, ExitCodes>
}