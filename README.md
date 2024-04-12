# blueprint

A new Flutter project.

---

### Mobile app for a new trading platform.

- [Features](#features)
- [Installation](#installation)
- [About external packages](#about-external-packages)
- [I18n](#i18n)
    - [How to generate locale keys:](#how-to-generate-locale-keys)

---

## Features
1. Firebase Core setup
2. Firebase Crashlytics setup
3. Firebase Analytics setup
4. Firebase Remote config setup
5. Manual DI setup
6. Automatic DI setup
7. IOS tracking authorization dialogue and request permission to collect data
8. Lightweight and blazing fast key-value database (write & read an auth token)
9. Explicitly reads environment variables into a dart file from a .env file for more security and faster start up times
10. Freezed setup (code generation for immutable classes)
11. BLoC (a predictable state management)
12. Authentication cubit to handle auth state
13. WebSocket integration (only one connection is possible, handle reconnection). Ready to listen to incoming events
14. RESTFul integration (dio + auth token interceptor + headers interceptor)
15. Lock device orientation
16. Localization setup (support English, French, Spanish)
17. Unit tests + utils for testing
18. Device info + package info providers
19. Custom gitignore file
20. Firebase installation id
21. Generate uuid v4
22. InfoPlist catalog to translate texts for permission requests
23. A declarative router for Flutter based on Navigation 2 supporting deep linking, data-driven routes (go_router)
24. Tuned dart analyzer rules

---

## Installation

1. clone the repo
2. `flutter pub get`
3. Make a copy `example.env` and rename it to `.env`
4. Fill in `.env` with secret keys
5. `dart run build_runner build --delete-conflicting-outputs`
6. Run the app as any other flutter app.

---

## About external packages

Please use the following guidelines:

1. It is best to keep amount of libraries/packages to a minimum.

2. If you have to use a package choose the one that has as little dependencies as possible.

3. Carefully choose packages that support all required platforms.

---

## I18n

There is easy_localization package for i18n. Though please keep in mind that i18n must be
abstracted. Please use TranslatedText widget instead of using easy_localization directly.

### How to generate locale keys:

```shell
dart run easy_localization:generate -O lib/core/i18n -f keys -o locale_keys.g.dart --source-dir assets/translations --source-file en.json
```

[Docs](https://pub.dev/packages/easy_localization#-localization-keys)

---
