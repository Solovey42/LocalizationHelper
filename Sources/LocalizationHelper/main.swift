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
    var search: SearchingProtocol{
        SearchData()
    }
    var update: UpdatingProtocol{
        UpdateData()
    }
    var delete: DeletingProtocol{
        DeleteData()
    }
}

let container = Container()

let parser = container.argumentParser
let arguments = container.argumentParser.parsing()

let getterData = container.getData
var data = try getterData.gettingData()

if case .search(let key, let language) = arguments {
    try container.search.run(languages: &data, key: key ?? "", language: language ?? "")
}
if case .update(let word, let key, let language) = arguments {
    let setterData = container.setData
    try container.update.run(languages: &data,word: word, key: key, language: language, updatingDataClass: setterData )
}
if case .delete(let key, let language) = arguments {
    let setterData = container.setData
    try container.delete.run(languages: &data, key: key ?? "", language: language ?? "", updatingDataClass: setterData)
}



