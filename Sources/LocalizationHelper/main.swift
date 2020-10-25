import Foundation
import ArgumentParser
struct Arguments: ParsableCommand {

    @Option(name: .short, help: "The word to translate into.") var key: String = ""
    @Option(name: .short, help: "Language into which we translate") var language: String = ""

    func run() throws {
        let path = Bundle.main.path( forResource: "languages", ofType: "json") ?? "123"
        let url = Bundle.main.path(forResource: "languages", ofType: "json")
        var languages = [] as [LanguagE]
        let decoder = JSONDecoder()

        if let json = FileManager.default.contents(atPath: path) {
            let Curlanguage = (try? decoder.decode(LanguagE.self, from: json))!
            languages.append(Curlanguage)
        } else {
            languages = []
        }

        print(path)
        print(url as Any)
        print(languages)

        //let languages = [Russian(), English(), Portuguese()] as [Language]
        //let process = ProcessArgs.init(ArgArray: CommandLine.arguments) # using for read Commandline
        let process = ProcessArgs.init(stringKey: key, stringLanguage: language)
        app(process: process, languages: languages)
    }
}

Arguments.main()