import Foundation
import ArgumentParser

struct Arguments: ParsableCommand {
    static var configuration = CommandConfiguration(
            abstract: "A program for translate words.",
            subcommands: [Search.self, Update.self, Delete.self])
}
extension Arguments{
    struct Options: ParsableArguments {
        @Option(name: .shortAndLong, help: "The word to translate into.") var key: String = ""
        @Option(name: .shortAndLong, help: "Language into which we translate") var language: String = ""
    }

    struct Search: ParsableCommand{
        @OptionGroup var options: Arguments.Options
        static var configuration = CommandConfiguration(
                commandName: "search",
                abstract: "Start search")
        func run() throws {
            //let process = ProcessArgs.init(ArgArray: CommandLine.arguments) //using for read Commandline
            let process = ProcessArgs.init(stringKey: options.key, stringLanguage: options.language)
            try app(process: process)
        }

    }

    struct Update: ParsableCommand{
        @OptionGroup var options: Arguments.Options
        @Argument var word: String?
        static var configuration = CommandConfiguration(
                commandName: "update",
                abstract: "Update selected item.")
        func run() throws {
            print("Update")
        }
    }

    struct Delete: ParsableCommand {
        @OptionGroup var options: Arguments.Options
        static var configuration = CommandConfiguration(
                commandName: "delete",
                abstract: "Delete selected item.")
        func run() throws {
            print("Delete")
        }
    }

func getJson(path: String) throws -> [Language] {
    var languages = [] as [Language]
    if let json = FileManager.default.contents(atPath: path) {
        try languages = JSONDecoder().decode([Language].self, from: json)
    }
    return languages
}

Arguments.main()
