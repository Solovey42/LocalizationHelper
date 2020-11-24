@testable import LocalizationHelper
import XCTest

class ShowDataTest: XCTestCase {
    private var show: ShowData!
    private var getData: JsonGetterMock!
    private var setData: JsonSetterMock!
    private var getStrings: LanguagesKeysMock!
    private var output: OutputMock!
    private var search: SearchDataMock!

    override func setUp() {
        getData = JsonGetterMock()
        setData = JsonSetterMock()
        getStrings = LanguagesKeysMock()
        output = OutputMock()
        search = SearchDataMock()
        show = ShowData(gettingDataClass: getData, updatingDataClass: setData, getterStrings: getStrings, outputClass: output, searchingClass: search)
    }

    func testSuccess() throws {
        getData.gettingDataResult = .success([Language(key: "rus", words: ["hello": "Привет"])])
        guard case .success(let languages) = getData.gettingDataResult else {
            XCTFail()
            return
        }

        getStrings.getKeysResult = ["hello"]
        getStrings.getLanguagesKeysResult = ["rus"]
        search.searchWitAllArgResult = .success((0, "hello", "Привет"))

        let keyArgument = "hello"
        let languageArgument = "rus"
        let result = show.startShowing(key: keyArgument, language: languageArgument)

        guard case .Success = result else {
            XCTFail("The expected result has a case of success, the actual result has a case of failure")
            return
        }


        XCTAssertEqual(search.searchWitAllArgParameters.keys, getStrings.getKeysResult)
        XCTAssertEqual(search.searchWitAllArgParameters.languagesKeys, getStrings.getLanguagesKeysResult)
        XCTAssertEqual(search.searchWitAllArgParameters.languages[0].key, languages[0].key)
        XCTAssertEqual(search.searchWitAllArgParameters.languages[0].words.keys, languages[0].words.keys)
        XCTAssertEqual(search.searchWitAllArgParameters.languages[0].words.values.first, languages[0].words.values.first)
        XCTAssertEqual(search.searchWitAllArgParameters.key, keyArgument)
        XCTAssertEqual(search.searchWitAllArgParameters.language, languageArgument)

        XCTAssertEqual(getData.gettingDataCallsCount, 1)
        XCTAssertEqual(getStrings.getKeysCallsCount, 1)
        XCTAssertEqual(getStrings.getLanguagesKeysCallsCount, 1)
        XCTAssertEqual(search.searchWitAllArgCallsCount, 1)
    }

    func testUnknownLanguage() throws {
        getData.gettingDataResult = .success([Language(key: "rus", words: ["hello": "Привет"])])
        guard case .success(let languages) = getData.gettingDataResult else {
            XCTFail()
            return
        }

        getStrings.getKeysResult = ["hello"]
        getStrings.getLanguagesKeysResult = ["rus"]
        search.searchWitAllArgResult = .failure(ExitCodes.UnknownLanguage)

        let keyArgument = "hello"
        let languageArgument = "ddd"
        let result = show.startShowing(key: "hello", language: "ddd")

        guard case .UnknownLanguage = result else {
            XCTFail("The actual result has not a case of UnknownLanguage")
            return
        }
        XCTAssertEqual(search.searchWitAllArgParameters.keys, getStrings.getKeysResult)
        XCTAssertEqual(search.searchWitAllArgParameters.languagesKeys, getStrings.getLanguagesKeysResult)
        XCTAssertEqual(search.searchWitAllArgParameters.languages[0].key, languages[0].key)
        XCTAssertEqual(search.searchWitAllArgParameters.languages[0].words.keys, languages[0].words.keys)
        XCTAssertEqual(search.searchWitAllArgParameters.languages[0].words.values.first, languages[0].words.values.first)
        XCTAssertEqual(search.searchWitAllArgParameters.key, keyArgument)
        XCTAssertEqual(search.searchWitAllArgParameters.language, languageArgument)

        XCTAssertEqual(getData.gettingDataCallsCount, 1)
        XCTAssertEqual(getStrings.getKeysCallsCount, 1)
        XCTAssertEqual(getStrings.getLanguagesKeysCallsCount, 1)
        XCTAssertEqual(search.searchWitAllArgCallsCount, 1)
    }

    func testUnknownKey() throws {
        getData.gettingDataResult = .success([Language(key: "rus", words: ["hello": "Привет"])])
        guard case .success(let languages) = getData.gettingDataResult else {
            XCTFail()
            return
        }

        getStrings.getKeysResult = ["ddd"]
        getStrings.getLanguagesKeysResult = ["rus"]
        search.searchWitAllArgResult = .failure(ExitCodes.UnknownKey)

        let keyArgument = "ddd"
        let languageArgument = "rus"
        let result = show.startShowing(key: "ddd", language: "rus")


        guard case .UnknownKey = result else {
            XCTFail("The actual result has not a case of UnknownKey")
            return
        }
        XCTAssertEqual(search.searchWitAllArgParameters.keys, getStrings.getKeysResult)
        XCTAssertEqual(search.searchWitAllArgParameters.languagesKeys, getStrings.getLanguagesKeysResult)
        XCTAssertEqual(search.searchWitAllArgParameters.languages[0].key, languages[0].key)
        XCTAssertEqual(search.searchWitAllArgParameters.languages[0].words.keys, languages[0].words.keys)
        XCTAssertEqual(search.searchWitAllArgParameters.languages[0].words.values.first, languages[0].words.values.first)
        XCTAssertEqual(search.searchWitAllArgParameters.key, keyArgument)
        XCTAssertEqual(search.searchWitAllArgParameters.language, languageArgument)

        XCTAssertEqual(getData.gettingDataCallsCount, 1)
        XCTAssertEqual(getStrings.getKeysCallsCount, 1)
        XCTAssertEqual(getStrings.getLanguagesKeysCallsCount, 1)
        XCTAssertEqual(search.searchWitAllArgCallsCount, 1)
    }

    func testUnknownWord() throws {
        getData.gettingDataResult = .success([Language(key: "rus", words: ["hello": "Привет"]), Language(key: "eng", words: ["day": "Day"])])
        guard case .success(let languages) = getData.gettingDataResult else {
            XCTFail()
            return
        }

        getStrings.getKeysResult = ["day", "hello"]
        getStrings.getLanguagesKeysResult = ["rus", "eng"]
        search.searchWitAllArgResult = .failure(ExitCodes.UnknownWord)

        let keyArgument = "day"
        let languageArgument = "rus"
        let result = show.startShowing(key: "day", language: "rus")


        guard case .UnknownWord = result else {
            XCTFail("The actual result has not a case of UnknownKey")
            return
        }
        XCTAssertEqual(search.searchWitAllArgParameters.keys, getStrings.getKeysResult)
        XCTAssertEqual(search.searchWitAllArgParameters.languagesKeys, getStrings.getLanguagesKeysResult)
        XCTAssertEqual(search.searchWitAllArgParameters.languages[0].key, languages[0].key)
        XCTAssertEqual(search.searchWitAllArgParameters.languages[0].words.keys, languages[0].words.keys)
        XCTAssertEqual(search.searchWitAllArgParameters.languages[0].words.values.first, languages[0].words.values.first)
        XCTAssertEqual(search.searchWitAllArgParameters.key, keyArgument)
        XCTAssertEqual(search.searchWitAllArgParameters.language, languageArgument)

        XCTAssertEqual(getData.gettingDataCallsCount, 1)
        XCTAssertEqual(getStrings.getKeysCallsCount, 1)
        XCTAssertEqual(getStrings.getLanguagesKeysCallsCount, 1)
        XCTAssertEqual(search.searchWitAllArgCallsCount, 1)
    }

    func testReadError() throws {
        getData.gettingDataResult = .failure(ExitCodes.ReadError)
        let result = show.startShowing(key: "hello", language: "eng")

        guard case .ReadError = result else {
            XCTFail("The actual result has not a case of ReadError")
            return
        }
        XCTAssertEqual(getData.gettingDataCallsCount, 1)
        XCTAssertEqual(getStrings.getKeysCallsCount, 0)
        XCTAssertEqual(getStrings.getLanguagesKeysCallsCount, 0)
        XCTAssertEqual(search.searchWitAllArgCallsCount, 0)
    }

    static var allTests = [
        ("testSuccess", testSuccess),
        ("testUnknownLanguage", testUnknownLanguage),
        ("testUnknownKey", testUnknownKey),
        ("testUnknownWord", testUnknownWord),
        ("testReadError", testReadError)
    ]
}