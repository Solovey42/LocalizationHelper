import Vapor
import Fluent
import Foundation

final class LanguageModel: Model, Content {
    static let schema: String = "language"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "keyLanguage")
    var keyLanguage: String

    @Children(for: \.$language)
    var words: [Words]

    init(){}

    init(id: UUID? = nil, keyLanguage:String, words: Words){
        self.id = id
        self.keyLanguage = keyLanguage
        self.words.append(words)
    }
}
final class Words: Model {
    static var schema: String = "words"

    @ID(key: .id)
    var id: UUID?

    // Example of a parent relation.
    @Parent(key: "language_id")
    var language: LanguageModel

    @Field(key: "key")
    var key: String

    @Field(key: "value")
    var value: String

    init(){}

    init(id: UUID? = nil, key:String, value: String) {
        self.id = id
        self.key = key
        self.value = value
    }
}

