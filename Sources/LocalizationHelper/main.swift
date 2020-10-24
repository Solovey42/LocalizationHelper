import ArgumentParser

struct CharacterCount: ParsableCommand {

    @Option(name: .short, help: "The word to translate into.") var key: String = ""
    @Option(name: .short, help: "Language into which we translate") var language: String = ""

    func run() throws {
        let languages = [Russian(), English(), Portuguese()] as [Language]
        //let process = ProcessArgs.init(ArgArray: CommandLine.arguments) # using for read Commandline
        let process = ProcessArgs.init(stringKey: key, stringLanguage: language)
        app(process: process, languages: languages)
    }
}

CharacterCount.main()

