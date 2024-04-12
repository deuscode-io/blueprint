# blueprint

A new Flutter project.

---

### Mobile app for a new trading platform.

- [Installation](#installation)
- [About external packages](#about-external-packages)
- [I18n](#i18n)
    - [How to generate locale keys:](#how-to-generate-locale-keys)

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
