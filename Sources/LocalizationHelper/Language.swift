//
// Created by solo on 10/16/20.
//

import Foundation

public protocol Language {
    var key: String { get }
    var words: [String: String] { get }
}
public struct LanguagE:Language,Codable {
    public var key: String
    public var words: [String: String]
}