import 'package:passage_flex_flutter/passage_flex_passkey.dart';

import 'passage_flutter_flex_platform/passage_flutter_platform_interface.dart'; 

class PassageFlexFlutter {
  late final PassageFlexPasskey passkey;

  PassageFlexFlutter(String appId){
    PassageFlutterPlatform.instance.initialize(appId);
    passkey = PassageFlexPasskey();
  }
}
