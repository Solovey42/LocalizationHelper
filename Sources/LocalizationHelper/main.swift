import ArgumentParser

struct CharacterCount: ParsableCommand {

    @Option(name: .short,  help: "The number to multiply the count against.") var key: String = ""
    @Option(name: .short, help: "The number to multiply the count against.") var language: String = ""

    func run() throws {
        let languages = [Russian(), English(), Portuguese()] as [Language]
        let process = ProcessArgs.init(ArgArray: CommandLine.arguments)
        app(process: process, languages: languages)
    }
}

CharacterCount.main()


