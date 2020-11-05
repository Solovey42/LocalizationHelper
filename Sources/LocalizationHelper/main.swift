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

if case .search(let key?, let language?) = arguments {
    let process = ProcessArgs(stringConfig: "search", stringKey: key, stringLanguage: language)
    try search(languages: &data, process: process) // не передавать весь класс , а передать отдельные аргументы и создать из функций классы с интерфейсами
}

/*switch arguments{
case .search(let key?, let language?):
    let process = ProcessArgs(stringConfig: "search", stringKey: key, stringLanguage: language)
    try search(languages: &data, process: process) // не передавать весь класс , а передать отдельные аргументы и создать из функций классы с интерфейсами
case .update(let word, let key, let language):
    let process = ProcessArgs(stringConfig: "update", stringWord: word,stringKey: key, stringLanguage: language)
    try update(languages: &data, process: process, path: path)
case .delete(let key?, let language?):
    let process = ProcessArgs(stringConfig: "delete",stringKey: key, stringLanguage: language)
    try delete(languages: &data, process: process, path: path)
default:
    exit(0)
}*/





