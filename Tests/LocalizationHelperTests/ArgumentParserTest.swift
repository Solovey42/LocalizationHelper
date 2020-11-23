@testable import LocalizationHelper
import XCTest

class ArgumentParserTest: XCTestCase {
    private var parser: ArgumentParser!

    override func setUp() {
        parser = ArgumentParser()
    }

    func testParsingSearch() throws {
        let actualResult = parser.parsing(["search", "-l", "rus", "-k", "ddd"])
        let expectedKey = "ddd"
        let expectedLanguage = "rus"

        guard case .search(let actualKey, let actualLanguage) = actualResult else {
            XCTFail("Invalid command. Expected command 'search'")
            return
        }
        XCTAssertEqual(actualKey, expectedKey)
        XCTAssertEqual(actualLanguage, expectedLanguage)
    }
    
    func testParsingDelete() throws {
        let actualResult = parser.parsing(["delete", "-l", "rus", "-k", "ddd"])
        let expectedKey = "ddd"
        let expectedLanguage = "rus"

        guard case .delete(let actualKey, let actualLanguage) = actualResult else {
            XCTFail("Invalid command. Expected command 'search'")
            return
        }
        XCTAssertEqual(actualKey, expectedKey)
        XCTAssertEqual(actualLanguage, expectedLanguage)
    }
    
    func testParsingUpdate() throws {
        let actualResult = parser.parsing(["update", "123", "-l", "rus", "-k", "ddd"])
        let expectedWord = "123"
        let expectedKey = "ddd"
        let expectedLanguage = "rus"

        guard case .update(let actualWord, let actualKey, let actualLanguage) = actualResult else {
            XCTFail("Invalid command. Expected command 'search'")
            return
        }
        XCTAssertEqual(actualWord, expectedWord)
        XCTAssertEqual(actualKey, expectedKey)
        XCTAssertEqual(actualLanguage, expectedLanguage)
    }
    
    func testParsingSearchKey() throws {
        let actualResult = parser.parsing(["search", "-k", "ddd"])
        let expectedKey = "ddd"

        guard case .search(let actualKey, let actualLanguage) = actualResult else {
            XCTFail("Invalid command. Expected command 'search'")
            return
        }
        XCTAssertEqual(actualKey, expectedKey)
        XCTAssertEqual(actualLanguage, nil)
    }
    
    func testParsingDeleteLanguage() throws {
        let actualResult = parser.parsing(["delete", "-l", "rus"])
        let expectedLanguage = "rus"

        guard case .delete(let actualKey, let actualLanguage) = actualResult else {
            XCTFail("Invalid command. Expected command 'search'")
            return
        }
        XCTAssertEqual(actualKey, nil)
        XCTAssertEqual(actualLanguage, expectedLanguage)
    }

    static var allTests = [
        ("testParsingSearch", testParsingSearch),
        ("testParsingDelete",testParsingDelete),
        ("testParsingUpdate",testParsingUpdate),
        ("testParsingSearchKey",testParsingSearchKey),
        ("testParsingDeleteLanguage",testParsingDeleteLanguage)
    ]
}
