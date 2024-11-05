import 'dart:js' as js;
import 'dart:js_util' as js_util;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:passage_flex_flutter/passage_flutter_flex_platform/passage_js.dart';
import 'passage_flutter_flex_models/authenticator_attachment.dart';
import 'passage_flutter_flex_models/passage_error.dart';
import 'passage_flutter_flex_models/passage_error_code.dart';
import 'passage_flutter_flex_platform/passage_flutter_platform_interface.dart';

class PassageFlutterWeb extends PassageFlutterPlatform {
  PassageFlutterWeb();

  late final passage = _getPassageApp();

  String? _passageAppId;

  PassageFlex _getPassageApp() {
    final appId = _passageAppId ?? js.context['passageAppId'];
    return PassageFlex(appId);
  }

  static void registerWith(Registrar registrar) {
    PassageFlutterPlatform.instance = PassageFlutterWeb();
  }

  @override
  Future<void> initialize(String appId) async {
    _passageAppId = appId;
  }

  @override
  Future<String> register(
      String transactionId, [PasskeyCreationOptions? options]) async {
    final passkeysSupported = await canAuthenticateWithPasskey();
    if (!passkeysSupported) {
      throw PassageError(code: PasskeyErrorCode.passkeysNotSupported);
    }
    try {
      final resultPromise = passage.passkey.register(transactionId);
      final string = await js_util.promiseToFuture(resultPromise);
      return string;
    } catch (e) {
      throw PassageError.fromObject(
          object: e, overrideCode: PasskeyErrorCode.passkeysNotSupported);
    }
  }

  @override
  Future<String> authenticate([String? transactionId, bool? isConditionalMediation]) async {
    final passkeysSupported = await canAuthenticateWithPasskey();
    if (!passkeysSupported) {
      throw PassageError(code: PasskeyErrorCode.passkeysNotSupported);
    }
    try {
      final resultPromise = passage.passkey.authenticate(IPasskeyAuthenticateOptions(
        transactionId: transactionId,
        isConditionalMediation: isConditionalMediation,
      ));
      final string = await js_util.promiseToFuture(resultPromise);
      return string;
    } catch (e) {
      throw PassageError.fromObject(
          object: e, overrideCode: PasskeyErrorCode.passkeysNotSupported);
    }
  }

  Future<bool> canAuthenticateWithPasskey() async {
    try {
      final resultPromise = passage.passkey.canAuthenticateWithPasskey();
      final jsObject = await js_util.promiseToFuture(resultPromise);
      return jsObject;
    } catch (e) {
      throw PassageError.fromObject(object: e);
    }
  }

}
