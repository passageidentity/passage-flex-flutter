import '../passage_flutter_flex_models/passkey_creation_options.dart';
import 'passage_flutter_method_channel.dart';

abstract class PassageFlutterPlatform {

  static final PassageFlutterPlatform _instance = MethodChannelPassageFlutter();

  static PassageFlutterPlatform get instance => _instance;

  Future<void> initialize(String appId) async {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  Future<Null> register(
      String identifier, PasskeyCreationOptions? options) {
    throw UnimplementedError('registerWithPasskey() has not been implemented.');
  }

  Future<Null> authenticate(String? identifier) {
    throw UnimplementedError('loginWithPasskey() as not been implemented.');
  }

}
