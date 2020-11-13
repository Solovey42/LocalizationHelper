import Foundation

class Container {
    var argumentParser: ArgumentsParserProtocol {
        ArgumentParser()
    }
    var getData: GetDataProtocol {
        JsonGetter()
    }
    var setData: SetDataProtocol {
        JsonSetter()
    }
    var search: SearchingProtocol {
        SearchData()
    }
    var update: UpdatingProtocol {
        UpdateData()
    }
    var delete: DeletingProtocol {
        DeleteData()
    }
    var getterString: GetStringKeysProtocol {
        LanguagesKeys()
    }
}

let container = Container()

let parser = container.argumentParser
let arguments = container.argumentParser.parsing()

let getterData = container.getData
var data = try getterData.gettingData()

let getterStrings = container.getterString

let searcher = container.search
let deleter = container.delete


switch (arguments) {
case .search(let key, let language):
    try container.search.run(languages: &data, key: key ?? "", language: language ?? "", getterStrings: getterStrings)
case .update(let word, let key, let language):
    let setterData = container.setData
    try container.update.run(languages: &data, word: word, key: key, language: language, updatingDataClass: setterData, getterStrings: getterStrings)
case .delete(let key, let language):
    let setterData = container.setData
    try container.delete.run(languages: &data, key: key ?? "", language: language ?? "", updatingDataClass: setterData, getterStrings: getterStrings)
default: break
}

