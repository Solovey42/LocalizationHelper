import Foundation

protocol DeletingProtocol {
    func run(languages: inout [Language], key: String, language: String, updatingDataClass: SetDataProtocol, getterStrings: GetStringKeysProtocol) throws
}
