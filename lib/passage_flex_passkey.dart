import 'package:passage_flex_flutter/passage_flutter_flex_models/authenticator_attachment.dart';
import 'passage_flutter_flex_platform/passage_flutter_platform_interface.dart';

/// The base class for utilizing native passkey APIs and Passage Flex APIs together.
class PassageFlexPasskey {

  /// Checks if the user's device supports passkeys.


  /// Registers a new passkey.
  ///
  /// Prompts the user associated with the provided Passage `transactionId` to create and register a new
  /// passkey for use with your app.
  ///
  /// - Parameters:
  ///   - transactionId: The Passage transaction id provided by your app's server.
  ///   - authenticatorAttachment: (Optional) The type of authentication that will be used in this
  ///   WebAuthN flow request. Defaults to `.platform`. Use `.cross-platform` for physical security
  ///   key registration.
  ///
  /// - Returns: A single-use "nonce" from Passage server to be exchanged for an authentication token on
  /// your app's server.
  ///
  /// - Throws: `PassageFlexPasskeyError` when passkey authorization fails.
  Future<String> register(String transactionId, [PasskeyCreationOptions? options]) async {
    return PassageFlutterPlatform.instance.register(transactionId, options);
  }

  /// Authenticates with a passkey.
  ///
  /// Prompts the user to select a passkey for authentication for your app. If a Passage `transactionId` is provided,
  /// this method will attempt to show only passkeys associated with that user account.
  ///
  /// - Parameters:
  ///   - transactionId: (Optional) The Passage transaction id provided by your app's server.
  ///
  /// - Returns: A single-use "nonce" from Passage server to be exchanged for an authentication token on
  /// your app's server.
  ///
  /// - Throws: `PassageFlexPasskeyError` when passkey authorization fails.
  Future<String> authenticate([String? transactionId]) async {
    return PassageFlutterPlatform.instance.authenticate(transactionId);
  }

}
