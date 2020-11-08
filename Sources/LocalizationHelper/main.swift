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

if case .search(let key, let language) = arguments {
    let searchingClass = SearchData()
    try searchingClass.search(languages: &data, key: key ?? "", language: language ?? "") // не передавать весь класс , а передать отдельные аргументы и создать из функций классы с интерфейсами
}
if case .update(let word, let key, let language) = arguments {
    let setterData = container.setData
    let updatingClass = UpdateData()
    try updatingClass.update(languages: &data,word: word, key: key, language: language, updatingDataClass: setterData )
}
if case .delete(let key, let language) = arguments {
    let setterData = container.setData
    let deletingClass = DeleteData()
    try deletingClass.delete(languages: &data, key: key ?? "", language: language ?? "", updatingDataClass: setterData)
}



