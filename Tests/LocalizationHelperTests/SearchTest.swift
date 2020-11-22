@testable import LocalizationHelper
import XCTest

class SearchDataTest: XCTestCase {
    private var search: SearchData!

    override func setUp() {
        search = SearchData()
    }

    func searchWithOutArgTest() throws {
        let result = search.searchWithOutArg(keys: ["hello", "day"], languages: [Language(key: "rus", words: ["hello": "Привет", ]), Language(key: "pt", words: ["day": "Dia"])])
        let expectedResult = [(key: "hello", languageKey: "rus", value: "Привет"), (key: "day", languageKey: "pt", value: "Dia")]

        XCTAssertEqual(result[0].key, expectedResult[0].key)
        XCTAssertEqual(result[0].languageKey, expectedResult[0].languageKey)
        XCTAssertEqual(result[0].value, expectedResult[0].value)
    }

    func searchWithLanguage() throws {
        let result = search.searchWithLanguage(languagesKeys: ["rus", "eng"], language: "rus", languages: [Language(key: "rus", words: ["hello": "Привет", ]), Language(key: "pt", words: ["day": "Dia"])])
        let expectedResult = 0

        guard case Result.success(let value) = result else {
            XCTFail("The expected result has a case of success, the actual result has a case of failure")
            return
        }
        XCTAssertEqual(value, expectedResult)
    }

    func searchWithLanguageFail() throws {
        let result = search.searchWithLanguage(languagesKeys: ["rus", "eng"], language: "Pt", languages: [Language(key: "rus", words: ["hello": "Привет", ]), Language(key: "pt", words: ["day": "Dia"])])
        let expectedResult = ExitCodes.UnknownLanguage

        guard case Result.failure(let value) = result else {
            XCTFail("The expected result has a case of failure, the actual result has a case of success")
            return
        }
        XCTAssertEqual(value, expectedResult)
    }

    func searchWithKey() throws {
        let result = search.searchWithKey(keys: ["hello", "day"], key: "day", languages: [Language(key: "rus", words: ["hello": "Привет", ]), Language(key: "pt", words: ["day": "Dia"])])
        let expectedResult = [(indexValue: 1, key: "hello", value: "Привет")]

        guard case Result.success(let value) = result else {
            XCTFail("The expected result has a case of success, the actual result has a case of failure")
            return
        }
        XCTAssertEqual(value[0].indexValue, expectedResult[0].indexValue)
        XCTAssertEqual(value[0].key, value[0].key)
        XCTAssertEqual(value[0].value, value[0].value)
    }

    func searchWithKeyFail() throws {
        let result = search.searchWithKey(keys: ["hello", "day"], key: "ddd", languages: [Language(key: "rus", words: ["hello": "Привет", ]), Language(key: "pt", words: ["day": "Dia"])])
        let expectedResult = ExitCodes.UnknownKey

        guard case Result.failure(let value) = result else {
            XCTFail("The expected result has a case of failure, the actual result has a case of success")
            return
        }
        XCTAssertEqual(value, expectedResult)
    }

    func searchWitAllArg() throws {
        let result = search.searchWitAllArg(keys: ["hello", "day"], languagesKeys: ["rus", "pt"], language: "pt", languages: [Language(key: "rus", words: ["hello": "Привет", ]), Language(key: "pt", words: ["day": "Dia"])], key: "day")
        let expectedResult = (indexValue: 1, key: "hello", value: "Привет")
        guard case Result.success(let value) = result else {
            XCTFail("The expected result has a case of success, the actual result has a case of failure")
            return
        }
        XCTAssertEqual(value.indexValue, expectedResult.indexValue)
        XCTAssertEqual(value.key, value.key)
        XCTAssertEqual(value.value, value.value)
    }

    func searchWitAllArgFailKey() throws {
        let result = search.searchWitAllArg(keys: ["hello", "day"], languagesKeys: ["rus", "pt"], language: "pt", languages: [Language(key: "rus", words: ["hello": "Привет", ]), Language(key: "pt", words: ["day": "Dia"])], key: "ddd")
        let expectedResult = ExitCodes.UnknownKey
        guard case Result.failure(let value) = result else {
            XCTFail("The expected result has a case of failure, the actual result has a case of success")
            return
        }
        XCTAssertEqual(value, expectedResult)
    }

    func searchWitAllArgFailLanguage() throws {
        let result = search.searchWitAllArg(keys: ["hello", "day"], languagesKeys: ["rus", "pt"], language: "ddd", languages: [Language(key: "rus", words: ["hello": "Привет", ]), Language(key: "pt", words: ["day": "Dia"])], key: "day")
        let expectedResult = ExitCodes.UnknownLanguage
        guard case Result.failure(let value) = result else {
            XCTFail("The expected result has a case of failure, the actual result has a case of success")
            return
        }
        XCTAssertEqual(value, expectedResult)
    }

    func searchWitAllArgFailWord() throws {
        let result = search.searchWitAllArg(keys: ["hello", "day"], languagesKeys: ["rus", "pt"], language: "pt", languages: [Language(key: "rus", words: ["hello": "Привет", ]), Language(key: "pt", words: ["day": "Dia"])], key: "hello")
        let expectedResult = ExitCodes.UnknownWord
        guard case Result.failure(let value) = result else {
            XCTFail("The expected result has a case of failure, the actual result has a case of success")
            return
        }
        XCTAssertEqual(value, expectedResult)
    }

    static var allTests = [
        ("searchWithOutArgTest", searchWithOutArgTest),
        ("searchWithLanguage", searchWithLanguage),
        ("searchWithLanguageFail", searchWithLanguageFail),
        ("searchWithKey", searchWithKey),
        ("searchWithKeyFail", searchWithKeyFail),
        ("searchWitAllArg", searchWitAllArg),
        ("searchWitAllArgFailKey", searchWitAllArgFailKey),
        ("searchWitAllArgFailLanguage", searchWitAllArgFailLanguage),
        ("searchWitAllArgFailWord", searchWitAllArgFailWord)
    ]
}