import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SearchDataTest.allTests),
        testCase(UpdateDataTest.allTests),
        testCase(ShowDataTest.allTests),
    ]
}
#endif
