import Foundation
@testable import LocalizationHelper

class JsonGetterMock: GetDataProtocol {

    var gettingDataParameters: ()!
    var gettingDataCallsCount = 0
    var gettingDataResult: Result<[Language], ExitCodes>!

    func gettingData() -> Result<[Language], ExitCodes> {
        gettingDataCallsCount += 1
        gettingDataParameters = ()
        return gettingDataResult
    }
}