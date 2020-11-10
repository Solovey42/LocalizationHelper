import Foundation

protocol DeletingProtocol {
    func delete(languages: inout [Language], key: String, language: String, updatingDataClass: SetDataProtocol) throws
}
