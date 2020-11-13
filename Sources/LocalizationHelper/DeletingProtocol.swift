import Foundation

protocol DeletingProtocol {

    //func run(languages: inout [Language], key: String, language: String,keys:[String],languagesKeys:[String]) throws
    func deleteWithKey(indexValue: Int, key: String, languages: inout [Language])
    func deleteWithLanguage(indexValue: Int, languages: inout [Language])
    func deleteWithAllArg(indexValue: Int, key: String, languages: inout [Language])
}