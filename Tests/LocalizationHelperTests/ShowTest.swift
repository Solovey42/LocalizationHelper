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
        getData.gettingDataResult = .success([Language(key: "", words: [:])])
        getStrings.getKeysResult = []
        getStrings.getLanguagesKeysResult = []
        search.searchWitAllArgResult = .success((0, "", ""))
        let result = show.startShowing(key: "", language: "")

        guard case .Success = result else {
            XCTFail("The expected result has a case of success, the actual result has a case of failure")
            return
        }
        XCTAssertEqual(getData.gettingDataCallsCount, 1)
        XCTAssertEqual(getStrings.getKeysCallsCount, 1)
        XCTAssertEqual(getStrings.getLanguagesKeysCallsCount, 1)
        XCTAssertEqual(search.searchWitAllArgCallsCount, 1)
    }

    func testUnknownLanguage() throws {
        getData.gettingDataResult = .success([Language(key: "", words: [:])])
        getStrings.getKeysResult = []
        getStrings.getLanguagesKeysResult = []
        search.searchWitAllArgResult = .failure(ExitCodes.UnknownLanguage)
        let result = show.startShowing(key: "", language: "")

        guard case .UnknownLanguage = result else {
            XCTFail("The actual result has not a case of UnknownLanguage")
            return
        }
        XCTAssertEqual(getData.gettingDataCallsCount, 1)
        XCTAssertEqual(getStrings.getKeysCallsCount, 1)
        XCTAssertEqual(getStrings.getLanguagesKeysCallsCount, 1)
        XCTAssertEqual(search.searchWitAllArgCallsCount, 1)
        XCTAssertEqual(setData.settingDataCallsCount, 0)
    }

    func testUnknownKey() throws {
        getData.gettingDataResult = .success([Language(key: "", words: [:])])
        getStrings.getKeysResult = []
        getStrings.getLanguagesKeysResult = []
        search.searchWitAllArgResult = .failure(ExitCodes.UnknownKey)
        let result = show.startShowing(key: "", language: "")

        guard case .UnknownKey = result else {
            XCTFail("The actual result has not a case of UnknownKey")
            return
        }
        XCTAssertEqual(getData.gettingDataCallsCount, 1)
        XCTAssertEqual(getStrings.getKeysCallsCount, 1)
        XCTAssertEqual(getStrings.getLanguagesKeysCallsCount, 1)
        XCTAssertEqual(search.searchWitAllArgCallsCount, 1)
        XCTAssertEqual(setData.settingDataCallsCount, 0)
    }

    func testUnknownWord() throws {
        getData.gettingDataResult = .success([Language(key: "", words: [:])])
        getStrings.getKeysResult = []
        getStrings.getLanguagesKeysResult = []
        search.searchWitAllArgResult = .failure(ExitCodes.UnknownWord)
        let result = show.startShowing(key: "", language: "")

        guard case .UnknownWord = result else {
            XCTFail("The actual result has not a case of UnknownWord")
            return
        }
        XCTAssertEqual(getData.gettingDataCallsCount, 1)
        XCTAssertEqual(getStrings.getKeysCallsCount, 1)
        XCTAssertEqual(getStrings.getLanguagesKeysCallsCount, 1)
        XCTAssertEqual(search.searchWitAllArgCallsCount, 1)
        XCTAssertEqual(setData.settingDataCallsCount, 0)
    }

    func testWriteError() throws {
        getData.gettingDataResult = .success([Language(key: "", words: [:])])
        getStrings.getKeysResult = []
        getStrings.getLanguagesKeysResult = []
        setData.settingDataResult = ExitCodes.WriteError
        search.searchWitAllArgResult = .failure(ExitCodes.WriteError)
        let result = show.startShowing(key: "", language: "")

        guard case .WriteError = result else {
            XCTFail("The actual result has not a case of WriteError")
            return
        }
        XCTAssertEqual(getData.gettingDataCallsCount, 1)
        XCTAssertEqual(getStrings.getKeysCallsCount, 1)
        XCTAssertEqual(getStrings.getLanguagesKeysCallsCount, 1)
        XCTAssertEqual(search.searchWitAllArgCallsCount, 1)
        XCTAssertEqual(setData.settingDataCallsCount, 0)
    }

    func testReadError() throws {
        getData.gettingDataResult = .failure(ExitCodes.ReadError)
        let result = show.startShowing(key: "", language: "")

        guard case .ReadError = result else {
            XCTFail("The actual result has not a case of ReadError")
            return
        }
        XCTAssertEqual(getData.gettingDataCallsCount, 1)
        XCTAssertEqual(getStrings.getKeysCallsCount, 0)
        XCTAssertEqual(getStrings.getLanguagesKeysCallsCount, 0)
        XCTAssertEqual(search.searchWitAllArgCallsCount, 0)
        XCTAssertEqual(setData.settingDataCallsCount, 0)
    }

    static var allTests = [
        ("testSuccess", testSuccess),
        ("testUnknownLanguage", testUnknownLanguage),
        ("testUnknownKey", testUnknownKey),
        ("testUnknownWord", testUnknownWord),
        ("testWriteError", testWriteError),
        ("testReadError", testReadError)
    ]
}