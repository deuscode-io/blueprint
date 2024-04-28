import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:blueprint/ui/widgets/buttons/suffix_icon_button.dart';
import 'package:blueprint/ui/widgets/texts/translated_text.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onSuffixTapped,
    required this.onChanged,
    required this.onSubmitted,
    required this.errorText,
  });

  final String? errorText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSuffixTapped;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      maxLength: 128,
      decoration: InputDecoration(
        errorText: errorText,
        prefixIcon: const Icon(Icons.email_outlined),
        suffixIcon: controller.text.trim().isEmpty
            ? null
            : SuffixIconButton(
                onTap: onSuffixTapped,
                child: const Icon(Icons.clear),
              ),
        label: const TranslatedText(LocaleKeys.text_field_labels_email),
        counterText: '',
      ),
      onChanged: (text) => onChanged(text.trim()),
      onSubmitted: (text) => onSubmitted(text.trim()),
    );
  }
}
