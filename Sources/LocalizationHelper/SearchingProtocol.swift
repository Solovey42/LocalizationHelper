import Foundation

protocol SearchingProtocol {
    var command: String { get set }
    var languages: [Language] { get set }
    var key: String? { get set }
    var language: String? { get set }
    var word: String? { get set }
    var gettingDataClass: GetDataProtocol? { get set }
    var updatingDataClass: SetDataProtocol? { get set }
    var getterStrings: GetStringKeysProtocol? { get set }
    var deleterClass: DeletingProtocol? { get set }
    var updaterClass: UpdatingProtocol? { get set }
    var outputClass: OutputProtocol? { get set }

    func run(command: String,key: String, language: String, word:String, gettingDataClass: GetDataProtocol, updatingDataClass: SetDataProtocol, getterStrings: GetStringKeysProtocol, deleterClass:DeletingProtocol, updaterClass: UpdatingProtocol, outputClass: OutputProtocol) throws
}
