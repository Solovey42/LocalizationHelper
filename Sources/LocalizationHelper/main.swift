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
        SearchData(gettingDataClass: getData, updatingDataClass: setData, getterStrings: getterString, deleterClass: delete, updaterClass: update, outputClass: output)
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
    var output: OutputProtocol {
        Output()
    }
}

let container = Container()

let parser = container.argumentParser
let arguments = container.argumentParser.parsing()

let getterData = container.getData

let setterData = container.setData

let getterStrings = container.getterString

let output = container.output

let searcher = container.search
let deleter = container.delete
let updater = container.update


switch (arguments) {
case .search(let command, let key, let language):
    try searcher.search(command: command, key: key ?? "", language: language ?? "", word: "")
case .update(let command, let word, let key, let language):
    try searcher.search(command: command, key: key, language: language, word: word)
case .delete(let command, let key, let language):
    try searcher.search(command: command, key: key ?? "", language: language ?? "", word: "")
default: break
}

