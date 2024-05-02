import 'package:blueprint/core/DI/injector.dart';
import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:blueprint/features/countries/actions/show_countries_bottom_sheet_action.dart';
import 'package:blueprint/features/countries/models/country.dart';
import 'package:blueprint/features/countries/ui/widgets/country_flag.dart';
import 'package:blueprint/widgets/buttons/app_ink_well.dart';
import 'package:blueprint/widgets/texts/translated_text.dart';
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

  final Country country;
  final List<Country> countries;
  final TextEditingController controller;
  final ValueChanged<Country> onChanged;
  final String? errorText;

  static final ShowCountriesBottomSheetAction _showCountriesBottomSheet =
      Injector.get();

  @override
  Widget build(BuildContext context) {
    controller.text = country.phoneCode;

    return IntrinsicHeight(
      child: Stack(
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              errorText: errorText,
              prefixIcon: CountryFlag(isoCode: country.isoCode),
              label: const TranslatedText(
                LocaleKeys.text_field_labels_country_code,
              ),
            ),
          ),
          AppInkWell(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            onTap: () async {
              final newCountry = await _showCountriesBottomSheet(
                context: context,
                countries: countries,
                selectedCountry: country,
              );

              if (newCountry != null &&
                  context.mounted &&
                  newCountry != country) {
                onChanged.call(newCountry);
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
