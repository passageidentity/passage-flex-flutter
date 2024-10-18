import 'dart:io'; 
import 'package:passage_flex_flutter/Passage_Flutter_Flex_Models/passage_error_code.dart';
import 'Passage_Flutter_Flex_Models/passage_error.dart';
import 'passage_flutter_flex_platform/passage_flutter_platform_interface.dart'; // Adjust based on where errors are defined

/// The base class for utilizing native passkey APIs and Passage Flex APIs together.
class PassageFlexPasskey {
  final String appId;

  PassageFlexPasskey(this.appId);

  /// Checks if the user's device supports passkeys.
  bool isSupported() {
    if (Platform.isIOS) {
      final iosVersion = double.tryParse(Platform.operatingSystemVersion.split(' ')[0]) ?? 0.0;
      return iosVersion >= 16.0;
    } else if (Platform.isAndroid) {
      final androidVersion = int.tryParse(Platform.operatingSystemVersion.split(' ')[0]) ?? 0;
      return androidVersion >= 28;
    } else {
      return false; // Unsupported platform
    }
  }

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
  Future<String?> register(String transactionId) async {
    _checkForPasskeySupport();
    return PassageFlutterPlatform.instance.register(transactionId, null);
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
  Future<String?> authenticate([String? transactionId]) async {
    _checkForPasskeySupport();
    return PassageFlutterPlatform.instance.authenticate(transactionId);
  }

  void _checkForPasskeySupport() {
    if (!isSupported()) {
      throw PassageError(message: "Passkeys are not supported on this device.", code: PasskeyErrorCode.passkeysNotSupported);
    }
  }
}
