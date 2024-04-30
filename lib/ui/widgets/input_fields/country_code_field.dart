import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:blueprint/ui/widgets/texts/translated_text.dart';
import 'package:flutter/material.dart';

class CountryCodeField extends StatelessWidget {
  const CountryCodeField({
    super.key,
    required this.currentCountry,
    required this.controller,
    required this.onChanged,
    required this.errorText,
  });

  final String? currentCountry;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Stack(
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              errorText: errorText,
              prefixIcon: const Icon(Icons.language),
              label: const TranslatedText(LocaleKeys.text_field_labels_country_code),
            ),
            onChanged: (text) => onChanged(text.trim()),
          ),
          GestureDetector(
            onTap: () async {
              final result = await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useRootNavigator: true,
                builder: (context) {
                  return const SizedBox(height: 128, width: double.infinity);
                },
              );
              if (context.mounted) {
                print('context.mounted');
              } else {
                print('!context.mounted');
              }
            },
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
