//
// Created by solo on 10/16/20.
//

import Foundation

public protocol LanguageProtocol {
    var key: String { get }
    var words: [String: String] { get }
}
public struct Language:LanguageProtocol,Codable {
    public var key: String
    public var words: [String: String]
}