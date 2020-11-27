import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    [
        testCase(SearchDataTest.allTests),
        testCase(UpdateDataTest.allTests),
        testCase(ShowDataTest.allTests),
        testCase(DeleteDataTest.allTests),
        testCase(JsonSetterTest.allTests),
        testCase(ArgumentParserTest.allTests)
    ]
}
#endif
