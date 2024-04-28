import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:blueprint/ui/widgets/buttons/suffix_icon_button.dart';
import 'package:blueprint/ui/widgets/input_fields/name_field.dart';
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
    'GIVEN $NameField to test callbacks',
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
          await tester.appPumpWidget(onSuffixTapped: () => _value = _name);

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
    'GIVEN $NameField to appearance',
    () {
      testWidgets(
        'WHEN pumped '
        'THEN the label gets displayed',
        (tester) async {
          await tester.appPumpWidget();

          ExpectWidgetBy.translatedText(LocaleKeys.text_field_labels_first_name);
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
        fileName: '$NameField',
        widget: Column(
          children: [
            _buildNameField(null),
            const SizedBox(height: 16),
            _buildNameField(LocaleKeys.first_name_validator_empty_first_name),
          ],
        ),
      );
    },
  );
}

NameField _buildNameField(String? errorText) {
  return NameField(
    controller: _controller,
    focusNode: FocusNode(),
    onSuffixTapped: () {},
    onChanged: (_) {},
    onSubmitted: (_) {},
    errorText: errorText,
    label: LocaleKeys.text_field_labels_first_name,
  );
}

extension on WidgetTester {
  Future<void> appPumpWidget({
    VoidCallback? onSuffixTapped,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    String? errorText,
    String label = LocaleKeys.text_field_labels_first_name,
  }) async {
    return pumpScaffold(
      child: NameField(
        controller: _controller,
        focusNode: FocusNode(),
        onSuffixTapped: onSuffixTapped ?? () {},
        onChanged: onChanged ?? (_) {},
        onSubmitted: onSubmitted ?? (_) {},
        errorText: errorText,
        label: label,
      ),
    );
  }
}
