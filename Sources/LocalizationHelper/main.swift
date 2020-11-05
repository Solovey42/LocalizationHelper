import Foundation

class Container {
    var argumentParser: ArgumentsParserProtocol {
        ArgumentParser()
    }
    var getData: GetDataProtocol {
        JsonGetter()
    }
}

let container = Container()

let parser = container.argumentParser
let arguments = container.argumentParser.parsing()

let getterData = container.getData
var data = try getterData.gettingData()

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
}*/





