import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../Passage_Flutter_Flex_Models/passage_error.dart';
import '../passage_flutter_flex_models/passkey_creation_options.dart';
import 'passage_flutter_platform_interface.dart';

class MethodChannelPassageFlutter extends PassageFlutterPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('passage_flutter');
  static PassageFlutterPlatform _instance = MethodChannelPassageFlutter();

  @override
  Future<void> initialize(String appId) async {
    await methodChannel.invokeMethod('initialize', {'appId': appId});
  }


  @override
  Future<Null> register(
      String identifier, PasskeyCreationOptions? options) async {
    try {
      final jsonString = await methodChannel.invokeMethod<String>(
          'registerWithPasskey',
          {'identifier': identifier, 'options': options?.toJson()});
      return null;
    } catch (e) {
      throw PassageError.fromObject(object: e);
    }
  }

  @override
  Future<Null> authenticate(String? identifier) async {
    try {
      final jsonString = await methodChannel
          .invokeMethod<String>('loginWithPasskey', {'identifier': identifier});
      return null;
    } catch (e) {
      throw PassageError.fromObject(object: e);
    }
  }

}
