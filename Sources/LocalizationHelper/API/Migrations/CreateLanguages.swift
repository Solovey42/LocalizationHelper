import Foundation
import Fluent

struct CreateLanguage: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("language")
                .id()
                .field("keyLanguage", .string, .required)
                .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("language")
                .delete()
    }
}

struct CreateWords: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("words")
                .id()
                .field("key", .string, .required)
                .field("value", .string, .required)
                .field("language_id", .uuid, .required, .references("language", "id"))
                .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("words")
                .delete()
    }


}