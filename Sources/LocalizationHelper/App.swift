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

public func app() -> ExitCodes {
    let container = Container()
    let parser = container.argumentParser
    let arguments = container.argumentParser.parsing(nil)

    let show = container.show
    let deleter = container.delete
    let updater = container.update

    switch (arguments) {
    case .search(let key, let language):
        let result = show.startShowing(key: key, language: language)
        switch result {
        case .success:
            return .Success
        case .failure(let error):
            return error
        }
    case .update(let word, let key, let language):
        let result = updater.startUpdating(key: key, language: language, word: word)
        switch result {
        case .success:
            return .Success
        case .failure(let error):
            return error
        }
    case .delete(let key, let language):
        let result = deleter.startDeleting(key: key, language: language)
        switch result {
        case .success:
            return .Success
        case .failure(let error):
            return error
        }
    default: parser.help()
        return ExitCodes.HelpCode
    }
}
