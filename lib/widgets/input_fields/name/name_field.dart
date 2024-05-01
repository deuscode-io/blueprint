import 'package:blueprint/core/DI/injector.dart';
import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:blueprint/core/i18n/translate.dart';
import 'package:blueprint/widgets/buttons/suffix_icon_button.dart';
import 'package:blueprint/widgets/texts/translated_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NameField extends StatelessWidget {
  static final Translate _translate = Injector.get();

  const NameField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.errorText,
    required this.label,
    this.onSubmitted,
  });

  final String? errorText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final String label;
  final ValueChanged<String>? onSubmitted;

  factory NameField.firstName({
    Key? key,
    String? errorText,
    required TextEditingController controller,
    required FocusNode focusNode,
    required ValueChanged<String> onChanged,
    ValueChanged<String>? onSubmitted,
  }) {
    return NameField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      errorText: errorText,
      label: LocaleKeys.text_field_labels_first_name,
    );
  }

  factory NameField.lastName({
    Key? key,
    String? errorText,
    required TextEditingController controller,
    required FocusNode focusNode,
    required ValueChanged<String> onChanged,
    ValueChanged<String>? onSubmitted,
  }) {
    return NameField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      errorText: errorText,
      label: LocaleKeys.text_field_labels_last_name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      autocorrect: false,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      maxLength: 64,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]| ')),
        FilteringTextInputFormatter.deny('  '),
      ],
      decoration: InputDecoration(
        errorText: errorText == null ? null : _translate(errorText!),
        prefixIcon: const Icon(Icons.person_outlined),
        suffixIcon: controller.text.trim().isEmpty
            ? null
            : SuffixIconButton(
                onTap: () {
                  controller.clear();
                  if (!focusNode.hasFocus) {
                    focusNode.requestFocus();
                  }
                  onChanged.call('');
                },
                child: const Icon(Icons.clear),
              ),
        label: TranslatedText(label),
        counterText: '',
      ),
      onChanged: (text) => onChanged(text.trim()),
      onSubmitted: (text) => onSubmitted?.call(text.trim()),
    );
  }
}
