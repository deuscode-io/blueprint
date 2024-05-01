import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:blueprint/widgets/buttons/suffix_icon_button.dart';
import 'package:blueprint/widgets/input_fields/email/email_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utils/add_goldentest.dart';
import '../../../test_utils/extensions/pump_ext.dart';
import '../../../test_utils/extensions/test_actions_ext.dart';
import '../../../test_utils/testers/expect_widget_by.dart';

const _name = 'Kasparov';
const _error = 'Some error';

final _controller = TextEditingController();
String _value = '';

void main() {
  setUp(() {
    _controller.clear();
    _value = '';
  });

  tearDownAll(() {
    _controller.dispose();
  });

  group(
    'GIVEN $EmailField to test callbacks',
    () {
      testWidgets(
        'WHEN entered a text',
        (tester) async {
          await tester.appPumpWidget(onChanged: (text) => _value = text);

          await tester.enterTextByType(type: TextField, text: _name);

          expect(_value, _name);
        },
      );

      testWidgets(
        'WHEN tapped on suffix button',
        (tester) async {
          _controller.text = _name;
          await tester.appPumpWidget(onChanged: (_) => _value = _name);

          await tester.tapByType(type: SuffixIconButton);

          expect(_value, _name);
        },
      );

      testWidgets(
        'WHEN tapped on submit button',
        (tester) async {
          await tester.appPumpWidget(onSubmitted: (_) => _value = _name);

          await tester.enterTextByType(type: TextField, text: '');
          await tester.testTextInput.receiveAction(TextInputAction.done);

          expect(_value, _name);
        },
      );
    },
  );

  group(
    'GIVEN $EmailField to test appearance',
    () {
      testWidgets(
        'WHEN pumped '
        'THEN the label gets displayed',
        (tester) async {
          await tester.appPumpWidget();

          ExpectWidgetBy.translatedText(LocaleKeys.text_field_labels_email);
        },
      );

      testWidgets(
        'WHEN there is an error text'
        'THEN the error text gets displayed',
        (tester) async {
          await tester.appPumpWidget(errorText: _error);

          ExpectWidgetBy.text(_error);
        },
      );

      addGoldenTest(
        fileName: '$EmailField',
        widget: Column(
          children: [
            _buildEmailField(null),
            const SizedBox(height: 16),
            _buildEmailField(LocaleKeys.app_email_validator_empty_email),
          ],
        ),
      );
    },
  );
}

EmailField _buildEmailField(String? errorText) {
  return EmailField(
    controller: _controller,
    focusNode: FocusNode(),
    onChanged: (_) {},
    onSubmitted: (_) {},
    errorText: errorText,
  );
}

extension on WidgetTester {
  Future<void> appPumpWidget({
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    String? errorText,
  }) async {
    return pumpScaffold(
      child: EmailField(
        controller: _controller,
        focusNode: FocusNode(),
        onChanged: onChanged ?? (_) {},
        onSubmitted: onSubmitted ?? (_) {},
        errorText: errorText,
      ),
    );
  }
}
