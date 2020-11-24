import Foundation
@testable import LocalizationHelper

class JsonSetterMock: SetDataProtocol {

    var settingDataParameters: [Language]!
    var settingDataCallsCount = 0
    var settingDataResult: Error?

    func settingData(languages: inout [Language]) throws {
        settingDataCallsCount += 1
        settingDataParameters = (languages)
        if (settingDataResult != nil) {
            throw settingDataResult!
        }
    }
}