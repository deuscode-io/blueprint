import 'package:blueprint/core/DI/injector.dart';
import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:blueprint/core/i18n/translate.dart';
import 'package:blueprint/ui/widgets/buttons/suffix_icon_button.dart';
import 'package:blueprint/ui/widgets/texts/translated_text.dart';
import 'package:flutter/material.dart';

class PhoneNumberField extends StatelessWidget {
  static final Translate _translate = Injector.get();

  const PhoneNumberField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    this.onSubmitted,
    required this.errorText,
  });

  final String? errorText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        errorText: errorText == null ? null : _translate(errorText!),
        prefixIcon: const Icon(Icons.phone),
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
        label: const TranslatedText(LocaleKeys.text_field_labels_phone_number),
        counterText: '',
      ),
      onChanged: (text) => onChanged(text.trim()),
      onSubmitted: (text) => onSubmitted?.call(text.trim()),
    );
  }
}
