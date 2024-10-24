enum AuthenticatorAttachment {
  platform,
  crossPlatform,
  any,
}

extension AuthenticatorAttachmentExtension on AuthenticatorAttachment {
  String get value {
    switch (this) {
      case AuthenticatorAttachment.platform:
        return 'platform';
      case AuthenticatorAttachment.crossPlatform:
        return 'cross-platform';
      case AuthenticatorAttachment.any:
        return 'any';
      default:
        return 'platform';
    }
  }
}