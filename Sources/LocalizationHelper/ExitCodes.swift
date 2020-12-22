//
// Created by solo on 19.11.2020.
//

import Foundation

public enum ExitCodes: Error{

    public var encodable:String{
        switch self{
        case .Success:
            return "Success"
        case .HelpCode:
            return "HelpCode"
        case .UnknownLanguage:
            return "UnknownLanguage"
        case .UnknownKey:
            return "UnknownKey"
        case .UnknownWord:
            return "UnknownWord"
        case .WriteError:
            return "WriteError"
        case .ReadError:
            return "ReadError"
        case .ShowError:
            return  "Wrong arguments for showing"
        case .DeleteError:
            return "Wrong arguments for deleting"
        case .UpdateError:
            return "Wrong arguments for updating"
        }
    }

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