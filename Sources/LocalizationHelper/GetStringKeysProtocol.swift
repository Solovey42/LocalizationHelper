//
// Created by solo on 10.11.2020.
//

import Foundation

protocol GetStringKeysProtocol {
    func getKeys(languages: [Language]) -> [String]
    func getLanguagesKeys(languages: [Language]) -> [String]
}
