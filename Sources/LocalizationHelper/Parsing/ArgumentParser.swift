import Foundation
import ArgumentParser

class ArgumentParser: ArgumentsParserProtocol {
    func parsing() -> Commands? {
        do {
            let command = try Arguments.parseAsRoot()

            switch command {
            case let command as Arguments.Search:
                return .search(key: command.options.key, language: command.options.language)
            case let command as Arguments.Update:
                return .update(word: command.word, key: command.key, language: command.language)
            case let command as Arguments.Delete:
                return .delete(key: command.options.key, language: command.options.language)
            default:
                print(Arguments.helpMessage())
                return nil
            }
        } catch {
            print(Arguments.helpMessage())
            return nil
        }
    }
}

struct Arguments: ParsableCommand {
    static var configuration = CommandConfiguration(
            abstract: "A program for translate words.",
            subcommands: [Search.self, Update.self, Delete.self])
}

extension Arguments {
    struct Options: ParsableArguments {
        @Option(name: .shortAndLong, help: "The word to translate into.") var key: String?
        @Option(name: .shortAndLong, help: "Language into which we translate") var language: String?
    }

    struct Search: ParsableCommand {
        @OptionGroup
        var options: Arguments.Options
        static var configuration = CommandConfiguration(
                commandName: "search",
                abstract: "Start search")
    }

    struct Update: ParsableCommand {
        @Option(name: .shortAndLong, help: "The word to translate into.") var key: String = ""
        @Option(name: .shortAndLong, help: "Language into which we translate") var language: String = ""
        @Argument
        var word: String
        static var configuration = CommandConfiguration(
                commandName: "update",
                abstract: "Update selected item.")
    }

    struct Delete: ParsableCommand {
        @OptionGroup
        var options: Arguments.Options
        static var configuration = CommandConfiguration(
                commandName: "delete",
                abstract: "Delete selected item.")
    }
}