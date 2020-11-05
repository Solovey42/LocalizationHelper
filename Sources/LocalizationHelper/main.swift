import Foundation

class Container {
    var argumentParser: ArgumentsParserProtocol {
        ArgumentParser()
    }
}

let container = Container()
let parser = container.argumentParser
let arguments = container.argumentParser.parsing()

let path = Bundle.module.path(forResource: "languages", ofType: "json") ?? "languages.json"
var lang = try getJson(path: path)

switch arguments{
case .search(let key?, let language?):
    let process = ProcessArgs(stringConfig: "search", stringKey: key, stringLanguage: language)
    try search(languages: &lang, process: process, path: path)
case .update(let word, let key, let language):
    let process = ProcessArgs(stringConfig: "update", stringWord: word,stringKey: key, stringLanguage: language)
    try update(languages: &lang, process: process, path: path)
case .delete(let key?, let language?):
    let process = ProcessArgs(stringConfig: "delete",stringKey: key, stringLanguage: language)
    try delete(languages: &lang, process: process, path: path)
default:
    exit(0)
}

func getJson(path: String) throws -> [Language] {
    var languages = [] as [Language]
    if let json = FileManager.default.contents(atPath: path) {
        try languages = JSONDecoder().decode([Language].self, from: json)
    }
    return languages
}




