import Foundation
import ArgumentParser
struct Arguments: ParsableCommand {

    @Option(name: .short, help: "The word to translate into.") var key: String = ""
    @Option(name: .short, help: "Language into which we translate") var language: String = ""

    func run() throws {
        let path = Bundle.module.path(forResource: "languages", ofType: "json") ?? "languages.json"
        var languages = [] as [Language]
        let decoder = JSONDecoder()

        print(path)

        if let json = FileManager.default.contents(atPath: path) {
            let curLanguage = (try? decoder.decode(Language.self, from: json))!
            languages.append(curLanguage)
        } else {
            languages = []
        }

        print(languages)

        //let languages = [Russian(), English(), Portuguese()] as [Language]
        //let process = ProcessArgs.init(ArgArray: CommandLine.arguments) # using for read Commandline
        let process = ProcessArgs.init(stringKey: key, stringLanguage: language)
        app(process: process, languages: languages)
    }
}

Arguments.main()