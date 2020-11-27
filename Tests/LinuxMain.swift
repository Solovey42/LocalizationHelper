import XCTest

#if !canImport(ObjectiveC)
import LocalizationHelperTests

var tests = [XCTestCaseEntry]()
tests += LocalizationHelperTests.allTests()
XCTMain(tests)
#endif