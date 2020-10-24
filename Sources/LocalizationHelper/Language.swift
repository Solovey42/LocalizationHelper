//
// Created by solo on 10/16/20.
//

import Foundation

public protocol Language {
    var key: String { get }
    var words: [String: String] { get }
}