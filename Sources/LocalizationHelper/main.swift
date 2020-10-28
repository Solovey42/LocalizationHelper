import Foundation
import ArgumentParser

struct Arguments: ParsableCommand {

    @Flag(help: "Start search") var search: Bool = false
    @Flag(help: "Update selected item") var update: Bool = false
    @Flag(help: "Delete selected item") var delete: Bool = false
    @Option(name: .shortAndLong, help: "The word to translate into.") var key: String = ""
    @Option(name: .shortAndLong, help: "Language into which we translate") var language: String = ""

    func run() throws {

        let path = Bundle.module.path(forResource: "languages", ofType: "json") ?? "languages.json"
        var languages = [] as [Language]
        if let json = FileManager.default.contents(atPath: path) {
            try languages = JSONDecoder().decode([Language].self, from: json)
        }
        //let process = ProcessArgs.init(ArgArray: CommandLine.arguments) //using for read Commandline
        let process = ProcessArgs.init(stringKey: key, stringLanguage: language)
        if search == true{
            app(process: process, languages: languages)
        }
        if update == true{

        }
        if delete == true{

        }
        else{
            print(" -h, --help Show help information.")
        }

    }
}

Arguments.main()