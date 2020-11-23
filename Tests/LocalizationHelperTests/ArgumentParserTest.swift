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

    static var allTests = [
        ("testParsingSearch", testParsingSearch)
    ]
}