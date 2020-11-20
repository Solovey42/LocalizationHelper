//
// Created by solo on 19.11.2020.
//

import Foundation

enum ExitCodes: Int32 {
    case Success = 0
    case HelpCode = 1
    case UnknownLanguage = 2
    case UnknownKey = 3
    case UnknownWord = 4
    case WriteError = 5
    case ReadError = 6
    case ShowError = 7
    case DeleteError = 8
    case UpdateError = 9
}