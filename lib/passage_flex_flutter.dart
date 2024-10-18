import 'package:passage_flex_flutter/passage_flex_passkey.dart'; 

class PassageFlex {
  final PassageFlexPasskey passkey;
  final String appId;

  PassageFlex(this.appId) : passkey = PassageFlexPasskey(appId) {
    // will be added after adding PassageFlexPaltform class
  }
}
