import 'package:blueprint/ui/widgets/buttons/suffix_icon_button.dart';
import 'package:blueprint/ui/widgets/texts/translated_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NameField extends StatelessWidget {
  const NameField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onSuffixTapped,
    required this.onChanged,
    required this.onSubmitted,
    required this.errorText,
    required this.label,
  });

  final String? errorText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSuffixTapped;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      autocorrect: false,
      maxLength: 64,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]| ')),
        FilteringTextInputFormatter.deny('  '),
      ],
      decoration: InputDecoration(
        errorText: errorText,
        prefixIcon: const Icon(Icons.person_outlined),
        suffixIcon: controller.text.trim().isEmpty
            ? null
            : SuffixIconButton(
                onTap: onSuffixTapped,
                child: const Icon(Icons.clear),
              ),
        label: TranslatedText(label),
        counterText: '',
      ),
      onChanged: (text) => onChanged(text.trim()),
      onSubmitted: (text) => onSubmitted(text.trim()),
    );
  }
}
