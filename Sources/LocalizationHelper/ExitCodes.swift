//
// Created by solo on 19.11.2020.
//

import Foundation

public enum ExitCodes: Error {
    case Success
    case HelpCode
    case UnknownLanguage
    case UnknownKey
    case UnknownWord
    case WriteError
    case ReadError
    case ShowError
    case DeleteError
    case UpdateError
}