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

let setterData = container.setData

let getterStrings = container.getterString

let searcher = container.search
let deleter = container.delete
let updater = container.update


switch (arguments) {
case .search(let command, let key, let language):
    try searcher.run(command: command, key: key ?? "", language: language ?? "", word: "", gettingDataClass: getterData, updatingDataClass: setterData, getterStrings: getterStrings, deleterClass: deleter, updaterClass: updater)
case .update(let command, let word, let key, let language):
    try searcher.run(command: command, key: key, language: language, word: word, gettingDataClass: getterData, updatingDataClass: setterData, getterStrings: getterStrings, deleterClass: deleter, updaterClass: updater)
case .delete(let command, let key, let language):
    try searcher.run(command: command, key: key ?? "", language: language ?? "", word: "", gettingDataClass: getterData, updatingDataClass: setterData, getterStrings: getterStrings, deleterClass: deleter, updaterClass: updater)
default: break
}

