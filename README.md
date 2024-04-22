# blueprint

Template project to start development

![intro](https://github.com/deuscode-io/blueprint/assets/165549052/faf0fae2-b878-4874-94bb-ba1f28be3f3e)


---

### Mobile app for a new trading platform.

- [Features](#features)
- [Installation](#installation)
- [About external packages](#about-external-packages)
- [I18n](#i18n)
    - [How to generate locale keys:](#how-to-generate-locale-keys)
- [Splash screen](#splash-screen)
    - [How to generate splash screen:](#how-to-generate-splash-screen)
- [Launcher icons](#launcher-icons)
    - [How to generate launcher icons:](#how-to-generate-launcher-icons)

---

## Features
1. The splash screen 
2. The launcher icons
3. Dark and Light modes
4. Dependency injection (Manual + Auto)
5. IOS tracking authorization dialogue and request permission to collect data
6. Firebase apps (Core, Crashlytics, Analytics, Remote config, Installation ID)
7. Lock device orientation
8. Localization (English, French, Spanish languages support)
9. InfoPlist catalog to translate texts for permission requests
10. WebSocket integration (only one connection is possible, handle reconnection). Ready to listen to incoming events
11. RESTFul integration (dio + auth token interceptor + headers interceptor)
12. Custom .gitignore file
13. Unit tests + utils for testing
14. Generate uuid v4
15. Device info + package info providers 
16. Lightweight and blazing fast key-value database (write & read an auth token)
17. Explicitly reads environment variables into a dart file from a .env file for more security and faster start up times 
18. Freezed setup (code generation for immutable classes)
19. BLoC (a predictable state management)
20. Authentication cubit to handle auth state 
21. Tuned dart analyzer rules

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

## Splash screen

Use flutter_native_splash.yaml to replace the splash screen

### How to generate splash screen:

```shell
dart run flutter_native_splash:create --path=flutter_native_splash.yaml
```

[Docs](https://pub.dev/packages/flutter_native_splash)

---

## Launcher icons

Use flutter_launcher_icons.yaml to replace the launcher icons

### How to generate launcher icons:

```shell
dart run flutter_launcher_icons -f flutter_launcher_icons.yaml
```

[Docs](https://pub.dev/packages/flutter_launcher_icons)

---