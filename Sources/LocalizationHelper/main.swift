import Foundation

class Container {
    var argumentParser: ArgumentsParserProtocol {
        ArgumentParser()
    }
    var getData: GetDataProtocol {
        JsonGetter()
    }
    var setData: SetDataProtocol{
        JsonSetter()
    }
}

let container = Container()

let parser = container.argumentParser
let arguments = container.argumentParser.parsing()

let getterData = container.getData
var data = try getterData.gettingData()

let setterData = container.setData

if case .search(let key, let language) = arguments {
    try search(languages: &data, key: key ?? "", language: language ?? "") // не передавать весь класс , а передать отдельные аргументы и создать из функций классы с интерфейсами
}
if case .update(let word, let key, let language) = arguments {
    try update(languages: &data,word: word, key: key ?? "", language: language ?? "", updatingDataClass: setterData )
}
if case .delete(let key?, let language?) = arguments {
    //let process = ProcessArgs(stringConfig: "delete", stringKey: key, stringLanguage: language)
    //try delete(languages: &data, process: process, path: path)
}





