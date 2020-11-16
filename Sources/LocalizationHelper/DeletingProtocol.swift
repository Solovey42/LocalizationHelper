import Foundation

protocol DeletingProtocol {
    var gettingDataClass: GetDataProtocol { get set }
    var updatingDataClass: SetDataProtocol { get set }
    var getterStrings: GetStringKeysProtocol { get set }
    var updaterClass: UpdatingProtocol { get set }
    var outputClass: OutputProtocol { get set }
    var searchCLass: SearchingProtocol { get set }
    //func run(languages: inout [Language], key: String, language: String,keys:[String],languagesKeys:[String]) throws
    func startDeleting( key: String, language: String, word: String) throws
    func deleteWithKey(items: [(indexValue: Int, key: String, value: String)])
    func deleteWithLanguage(indexLanguage: Int?)
    func deleteWithAllArg(item: (indexValue: Int, word: String, key: String, value: String)?)
}