import 'package:flutter/services.dart';
import '/passage_flutter_flex_models/passage_error_code.dart';

String getErrorCode(dynamic error) {
  if (error is PlatformException) {
    return error.code;
  }
  return PasskeyErrorCode.unknown;
}

@override
String getErrorMessage(dynamic error) {
  if (error is PlatformException && error.message != null) {
    return error.message!;
  }
  return error.toString();
}
