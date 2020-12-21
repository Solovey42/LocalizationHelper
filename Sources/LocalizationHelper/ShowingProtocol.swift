//
// Created by solo on 16.11.2020.
//

import Foundation

public protocol ShowingProtocol {
    func startShowing(key: String?, language: String?, data: [Language]?) -> Result<[(languageKey: String, key: String, value: String)], ExitCodes>

}
