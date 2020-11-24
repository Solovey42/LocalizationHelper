import Foundation

protocol DeletingProtocol {
    func startDeleting(key: String?, language: String?) -> ExitCodes
}