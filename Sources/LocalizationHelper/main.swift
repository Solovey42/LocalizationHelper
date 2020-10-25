import Foundation
import ArgumentParser

struct Arguments: ParsableCommand {

    @Option(name: .short, help: "The word to translate into.") var key: String = ""
    @Option(name: .short, help: "Language into which we translate") var language: String = ""

    func run() throws {
        let path = Bundle.module.path(forResource: "languages", ofType: "json") ?? "languages.json"
        var languages = [] as [Language]
        if let json = FileManager.default.contents(atPath: path) {
            try languages = JSONDecoder().decode([Language].self, from: json)
        }
        //let process = ProcessArgs.init(ArgArray: CommandLine.arguments) //using for read Commandline
        let process = ProcessArgs.init(stringKey: key, stringLanguage: language)
        app(process: process, languages: languages)
    }
}

Arguments.main()