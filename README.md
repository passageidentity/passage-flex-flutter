![image](https://github.com/user-attachments/assets/00475bf6-b475-4050-a50f-9b39354afe09)

## About

[Passage by 1Password](https://1password.com/product/passage) unlocks the passwordless future with a simpler, more secure passkey authentication experience. Passage handles the complexities of the [WebAuthn API](https://blog.1password.com/what-is-webauthn/), and allows you to implement passkeys with ease.

Use [Passkey Flex](https://docs.passage.id/flex) to add passkeys to an existing authentication experience.

Use [Passkey Complete](https://docs.passage.id/complete) as a standalone passwordless auth solution.

Use [Passkey Ready](https://docs.passage.id/passkey-ready) to determine if your users are ready for passkeys.

### In passage-flex-flutter

Use passage-flex-flutter to implement Passkey Flex in your web, andriod and ios application to add native passkey authentication in your own authentication flows.

| Product                                                                                                                                  | Compatible                                                                                                            |
| ---------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| ![Passkey Flex](https://storage.googleapis.com/passage-docs/github-md-assets/passage-passkey-flex-icon.png) Passkey **Flex**             | ✅                                                                                                                    |
| ![Passkey Complete](https://storage.googleapis.com/passage-docs/github-md-assets/passage-passkey-complete-icon.png) Passkey **Complete** | ✖️ For Passkey Complete, check out [passage-flutter](https://github.com/passageidentity/passage-flutter)                  |

## Getting Started

### Check Prerequisites

<p>
 You'll need a free Passage account and a Passkey Flex app set up in <a href="https://console.passage.id/">Passage Console</a> to get started. <br />
 <sub><a href="https://docs.passage.id/home#passage-console">Learn more about Passage Console →</a></sub>
</p>

### Install

```sh
flutter pub add passage_flex_flutter
```

### Import

```dart
import 'package:passage_flutter/passage_flutter.dart';

final passageFlex = PassageFlexFlutter('YOUR_PASSAGE_APP_ID');

```

### Initialize

```dart
await passageFlex.passkey.register('name@email.com');
```

## Support & Feedback

We are here to help! Find additional docs, the best ways to get in touch with our team, and more within our [support resources](https://github.com/passageidentity/.github/blob/main/SUPPORT.md).

<br />

---

<p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://storage.googleapis.com/passage-docs/github-md-assets/passage-by-1password-dark.png">
      <source media="(prefers-color-scheme: light)" srcset="https://storage.googleapis.com/passage-docs/github-md-assets/passage-by-1password-light.png">
      <img alt="Passage by 1Password Logo" src="https://storage.googleapis.com/passage-docs/github-md-assets/passage-by-1password-light.png">
    </picture>
</p>

<p align="center">
    <sub>Passage is a product by <a href="https://1password.com/product/passage">1Password</a>, the global leader in access management solutions with nearly 150k business customers.</sub><br />
    <sub>This project is licensed under the MIT license. See the <a href="LICENSE">LICENSE</a> file for more info.</sub>
</p>
