@JS()
library passage;

import 'package:js/js.dart';
import 'package:passage_flex_flutter/passage_flutter_flex_models/authenticator_attachment.dart';

@JS('PassageFlex')
class PassageFlex {
  external factory PassageFlex(String appId);
  external PassagePasskey get passkey;
}


@JS()
class PassagePasskey {
  external String register(String transactionId, [PasskeyCreationOptions? options]);
  external String authenticate(IPasskeyAuthenticateOptions options);
  external bool canAuthenticateWithPasskey();
}

class IPasskeyAuthenticateOptions {
  final String? transactionId;
  final bool? isConditionalMediation;

  IPasskeyAuthenticateOptions({
    this.transactionId,
    this.isConditionalMediation,
  });

  Map<String, dynamic> toJson() {
    return {
      if (transactionId != null) 'transactionId': transactionId,
      if (isConditionalMediation != null) 'isConditionalMediation': isConditionalMediation,
    };
  }
}

