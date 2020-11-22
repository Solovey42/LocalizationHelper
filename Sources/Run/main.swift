import Foundation
import LocalizationHelper

let exitCode: Int32
switch app() {
case .Success:
    exitCode = 0
case .HelpCode:
    exitCode = 1
case .UnknownLanguage:
    exitCode = 2
case .UnknownKey:
    exitCode = 3
case .UnknownWord:
    exitCode = 4
case .WriteError:
    exitCode = 5
case .ReadError:
    exitCode = 6
case .ShowError:
    exitCode = 7
case .DeleteError:
    exitCode = 8
case .UpdateError:
    exitCode = 9
}
exit(exitCode)

