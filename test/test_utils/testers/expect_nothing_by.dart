import 'package:blueprint/ui/widgets/texts/translated_text.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class ExpectNothingBy {
  static text(String text) {
    _expectNothingByFinder(find.text(text));
  }

  static textContaining(String text) {
    _expectNothingByFinder(find.textContaining(text));
  }

  static translatedText(String localeKey) {
    _expectNothingByFinder(
      find.byWidgetPredicate(
        (widget) => widget is TranslatedText && widget.text == localeKey,
      ),
    );
  }

  static tooltip(String text) {
    expect(find.byTooltip(text), findsNothing);
  }

  static type(Type type) {
    _expectNothingByFinder(find.byType(type));
  }

  static key(Key key) {
    _expectNothingByFinder(find.byKey(key));
  }

  static predicate(bool Function(Widget widget) predicate) {
    _expectNothingByFinder(find.byWidgetPredicate(predicate));
  }

  static exactWidget(Widget child) {
    _expectNothingByFinder(find.byWidget(child));
  }
}

void _expectNothingByFinder(Finder finder) {
  expect(finder, findsNothing);
}
