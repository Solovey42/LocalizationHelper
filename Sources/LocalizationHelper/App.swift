//
// Created by solo on 20.11.2020.
//

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
        UpdateData(gettingDataClass: getData, updatingDataClass: setData, getterStrings: getterString, outputClass: output, searchingClass: search)
    }
    var delete: DeletingProtocol {
        DeleteData(gettingDataClass: getData, updatingDataClass: setData, getterStrings: getterString, outputClass: output, searchingClass: search)
    }
    var show: ShowingProtocol {
        ShowData(gettingDataClass: getData, updatingDataClass: setData, getterStrings: getterString, outputClass: output, searchingClass: search)
    }
    var getterString: GetStringKeysProtocol {
        LanguagesKeys()
    }
    var output: OutputProtocol {
        Output()
    }
}

public func app() -> Int {
    let container = Container()
    let parser = container.argumentParser
    let arguments = container.argumentParser.parsing()

    let show = container.show
    let deleter = container.delete
    let updater = container.update

    switch (arguments) {
    case .search(let key, let language):
        return show.startShowing(key: key ?? nil, language: language ?? nil)
    case .update(let word, let key, let language):
        return updater.startUpdating(key: key, language: language, word: word)
    case .delete(let key, let language):
        return deleter.startDeleting(key: key ?? nil, language: language ?? nil)
    default: parser.help()
        return ExitCodes.HelpCode.rawValue
    }
}
