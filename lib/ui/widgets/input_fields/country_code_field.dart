import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:blueprint/models/profile/country.dart';
import 'package:blueprint/ui/widgets/texts/translated_text.dart';
import 'package:flutter/material.dart';

class CountryCodeField extends StatelessWidget {
  const CountryCodeField({
    super.key,
    required this.country,
    required this.countries,
    required this.controller,
    required this.onChanged,
    required this.errorText,
  });

  final Country? country;
  final List<Country> countries;
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
              await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useRootNavigator: true,
                builder: (context) {
                  return const SizedBox(height: 128, width: double.infinity);
                },
              );
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
