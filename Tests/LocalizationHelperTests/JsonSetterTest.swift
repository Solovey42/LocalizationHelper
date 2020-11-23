@testable import LocalizationHelper
import XCTest

class JsonSetterTest: XCTestCase {
    private var setData: JsonSetter!
    private var getData: JsonGetter!

    override func setUp() {
        setData = JsonSetter()
        getData = JsonGetter()
    }

    func testSettingData() throws {
        var languages = [Language(key: "rus", words: ["hello": "Привет"])]
        let updatingValue = "Ку"
        languages[0].words.updateValue(updatingValue, forKey: "hello")
        try setData.settingData(languages: &languages)
        let result = getData.gettingData()
        guard case Result.success(let languageUpdated) = result else {
            XCTFail("No data received")
            return
        }
        XCTAssertEqual(languageUpdated[0].words.first?.value, updatingValue)
        XCTAssertEqual(languageUpdated[0].key,languages[0].key)
        XCTAssertEqual(languageUpdated[0].words.first?.key, languages[0].words.first?.key )
    }

    static var allTests = [
        ("testSettingData", testSettingData),
    ]
}