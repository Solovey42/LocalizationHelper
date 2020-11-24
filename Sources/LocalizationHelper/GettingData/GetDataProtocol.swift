import Foundation

protocol GetDataProtocol {
    func gettingData() -> Result<[Language],ExitCodes>
}
