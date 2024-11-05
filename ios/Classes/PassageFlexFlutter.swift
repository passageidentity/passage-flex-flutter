import Flutter
import PassageFlex
import AnyCodable

public class PassageFlexFlutter {
    private let passageFlex: PassageFlex

    init(appId: String) {
        passageFlex = PassageFlex(appId: appId)
    }

    func register(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard #available(iOS 16.0, *) else {
            let error = "UNSUPPORTED_OS_VERSION"
            result(error)
            return
        }
        guard let args = call.arguments as? [String: Any],
              let transactionId = args["transactionId"] as? String else {
            result(PassageFlutterError.invalidArgument.flutterError)
            return
        }
        let optionsMap = args["passkeyCreationOptions"] as? [String: String]
        let attachmentValue = optionsMap?["authenticatorAttachment"]
        let authenticatorAttachment: AuthenticatorAttachment
        switch attachmentValue {
        case "platform":
            authenticatorAttachment = .platform
        case "cross-platform":
            authenticatorAttachment = .crossPlatform
        case "any":
            authenticatorAttachment = .any
        default:
            authenticatorAttachment = .platform
        }

        let passkeyCreationOptions = PasskeyCreationOptions(authenticatorAttachment: authenticatorAttachment)

        Task {
            do {
                let nonce = try await passageFlex.passkey.register(with: transactionId, options: passkeyCreationOptions)
                result(nonce)
            } catch {
                print(error)
                result(mapErrorToFlutter(error))
            }
        }
    }

    func authenticate(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard #available(iOS 16.0, *) else {
            let error = "UNSUPPORTED_OS_VERSION"
            result(error)
            return
        }
        guard let args = call.arguments as? [String: Any],
              let transactionId = args["transactionId"] as? String else {
            result(PassageFlutterError.invalidArgument.flutterError)
            return
        }
        
       Task {
           do {
               let nonce = try await passageFlex.passkey.authenticate(with: transactionId)
               result(nonce)
           } catch {
               result(mapErrorToFlutter(error))
           }
       }
    }

    private func mapErrorToFlutter(_ error: Error) -> FlutterError {
        let passageError: PassageFlutterError
        switch error {
        case let passkeyError as PassagePasskeyAuthorizationError:
            switch passkeyError {
            case .userCanceled:
                passageError = .invalidRequest  
            case .failed:
                passageError = .passkeyError
            case .webauthnError:
                passageError = .webAuthFailed
            case .unknown:
                passageError = .passkeyError
            }
        default:
            passageError = .passkeyError
        }
        return passageError.flutterError
    }

}
