import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../Passage_Flutter_Flex_Models/passage_error.dart';
import '../passage_flutter_flex_models/authenticator_attachment.dart';
import 'passage_flutter_platform_interface.dart';

class MethodChannelPassageFlutter extends PassageFlutterPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('passage_flutter');

  @override
  Future<void> initialize(String appId) async {
    await methodChannel.invokeMethod('initialize', {'appId': appId});
  }

  @override
Future<String> register(
    String identifier, AuthenticatorAttachment? attachment) async {
  try {
    final nonce = await methodChannel.invokeMethod<String>(
        'register',
        {
          'transactionId': identifier,
          'authenticatorAttachment': attachment?.value
        });
    return nonce!;
  } catch (e) {
    throw PassageError.fromObject(object: e);
  }
}

  @override
  Future<String> authenticate(String? transactionId) async {
    try {
      final nonce = await methodChannel
          .invokeMethod<String>('authenticate', {'transactionId': transactionId});
      return nonce!;
    } catch (e) {
      throw PassageError.fromObject(object: e);
    }
  }

}
