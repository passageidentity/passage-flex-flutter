import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import '../passage_flutter_flex_models/authenticator_attachment.dart';
import 'passage_flutter_method_channel.dart';

abstract class PassageFlutterPlatform extends PlatformInterface {
  PassageFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static PassageFlutterPlatform _instance = MethodChannelPassageFlutter();
  static PassageFlutterPlatform get instance => _instance;

  static set instance(PassageFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> initialize(String appId) async {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  Future<String> register(
      String transactionId, PasskeyCreationOptions? options) {
    throw UnimplementedError('register() has not been implemented.');
  }

  Future<String> authenticate(String? transactionId) {
    throw UnimplementedError('authenticate() as not been implemented.');
  }

}
