import Flutter
import Foundation

enum PassageFlutterError: String {
    case webAuthFailed = "WEB_AUTH_FAILED"
    case passkeyError = "PASSKEY_ERROR"
    case invalidRequest = "INVALID_REQUEST"
    case discoverableLoginFailed = "DISCOVERABLE_LOGIN_FAILED"
    case invalidArgument = "INVALID_ARGUMENT"

    var flutterError: FlutterError {
        switch self {
        case .webAuthFailed:
            return FlutterError(code: self.rawValue, message: "Web authentication failed.", details: nil)
        case .passkeyError:
            return FlutterError(code: self.rawValue, message: "An error occurred with the passkey.", details: nil)
        case .invalidRequest:
            return FlutterError(code: self.rawValue, message: "The request was invalid.", details: nil)
        case .discoverableLoginFailed:
            return FlutterError(code: self.rawValue, message: "Discoverable login failed.", details: nil)
        case .invalidArgument:
            return FlutterError(code: self.rawValue, message: "Invalid argument provided.", details: nil)
        }
    }
}
