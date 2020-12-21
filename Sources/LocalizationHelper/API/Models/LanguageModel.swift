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
final class Words: Model, Content {
    static var schema: String = "words"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "key")
    var key: String

    @Field(key: "value")
    var value: String

    @Parent(key: "language_id")
    var language: LanguageModel

    init(){}

    init(id: UUID? = nil, key:String, value: String, languageID: UUID) {
        self.id = id
        self.key = key
        self.value = value
        self.$language.id = languageID
    }
/*    @Parent(key: "galaxy_id")
    var galaxy: Galaxy

    // Creates a new, empty Star.
    init() { }

    // Creates a new Star with all properties set.
    init(id: UUID? = nil, name: String, galaxyID: UUID) {
        self.id = id
        self.name = name
        self.$galaxy.id = galaxyID
    }*/
}
final class Lang: Model, Content {
    static var schema: String = "lang"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "key")
    var key: String

    @Field(key: "words")
    var words: [String:String]

    init() {
    }

    init(id: UUID? = nil, key: String, words: [String:String]) {
        self.id = id
        self.key = key
        self.words = words
    }
}

