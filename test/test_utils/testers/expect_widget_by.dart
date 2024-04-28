import 'package:blueprint/core/i18n/translate.dart';
import 'package:blueprint/ui/widgets/texts/translated_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class ExpectWidgetBy {
  static text(String text, {int matchCount = 1}) {
    _expectWidgetByFinder(find.text(text), matchCount: matchCount);
  }

  static textContaining(String text, {int matchCount = 1}) {
    _expectWidgetByFinder(find.textContaining(text), matchCount: matchCount);
  }

  static translatedText(
    String localeKey, {
    Map<String, String>? namedArguments,
    int matchCount = 1,
  }) {
    _expectWidgetByFinder(
      find.byWidgetPredicate(
        (widget) =>
            widget is TranslatedText &&
            widget.text == localeKey &&
            (namedArguments == null || mapEquals(widget.namedArguments, namedArguments)),
      ),
      matchCount: matchCount,
    );
  }

  static translatedTooltip(
    String text, {
    int matchCount = 1,
  }) {
    const translate = Translate();
    _expectWidgetByFinder(
      find.byTooltip(translate(text)),
      matchCount: matchCount,
    );
  }

  static type(Type type, {int matchCount = 1}) {
    _expectWidgetByFinder(find.byType(type), matchCount: matchCount);
  }

  static key(Key key, {int matchCount = 1}) {
    _expectWidgetByFinder(find.byKey(key), matchCount: matchCount);
  }

  static valueKey(String keyValue) {
    key(ValueKey(keyValue));
  }

  static predicate(
    bool Function(Widget widget) predicate, {
    int matchCount = 1,
  }) {
    _expectWidgetByFinder(
      find.byWidgetPredicate(predicate),
      matchCount: matchCount,
    );
  }

  static child(Widget child, {int matchCount = 1}) {
    _expectWidgetByFinder(find.byWidget(child), matchCount: matchCount);
  }

  static descendant({
    required Finder of,
    required Finder matching,
    int matchCount = 1,
  }) {
    _expectWidgetByFinder(
      find.descendant(
        of: of,
        matching: matching,
      ),
      matchCount: matchCount,
    );
  }
}

void _expectWidgetByFinder(Finder finder, {required int matchCount}) {
  expect(finder, findsNWidgets(matchCount));
}
