import Foundation

class Container {
    var argumentParser: ArgumentsParserProtocol {
        ArgumentParser()
    }
}

    struct Search: ParsableCommand{
        @OptionGroup
        var options: Arguments.Options
        static var configuration = CommandConfiguration(
                commandName: "search",
                abstract: "Start search")
        func run() throws {
            let path = Bundle.module.path(forResource: "languages", ofType: "json") ?? "languages.json"
            var lang = try getJson(path: path)
            let process = ProcessArgs(stringConfig: "search", stringKey: options.key, stringLanguage: options.language)
            try search(languages: &lang, process: process, path: path)
        }

    }

    struct Update: ParsableCommand{
        @OptionGroup
        var options: Arguments.Options
        @Argument
        var word: String
        static var configuration = CommandConfiguration(
                commandName: "update",
                abstract: "Update selected item.")
        func run() throws {
            let path = Bundle.module.path(forResource: "languages", ofType: "json") ?? "languages.json"
            var lang = try getJson(path: path)
            let process = ProcessArgs(stringConfig: "update", stringWord: word,stringKey: options.key, stringLanguage: options.language)
            try update(languages: &lang, process: process, path: path)
            }
        }
    }

    struct Delete: ParsableCommand {
        @OptionGroup
        var options: Arguments.Options
        static var configuration = CommandConfiguration(
                commandName: "delete",
                abstract: "Delete selected item.")
        func run() throws {
            let path = Bundle.module.path(forResource: "languages", ofType: "json") ?? "languages.json"
            var lang = try getJson(path: path)
            let process = ProcessArgs(stringConfig: "delete",stringKey: options.key, stringLanguage: options.language)
            try delete(languages: &lang, process: process, path: path)
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
