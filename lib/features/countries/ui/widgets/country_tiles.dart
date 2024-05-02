import 'package:blueprint/features/countries/models/country.dart';
import 'package:blueprint/features/countries/ui/widgets/country_tile.dart';
import 'package:blueprint/widgets/buttons/app_ink_well.dart';
import 'package:flutter/material.dart';

class CountryTiles extends StatelessWidget {
  const CountryTiles({
    super.key,
    required this.scrollController,
    required this.countries,
    required this.currentCountry,
    required this.countryTileHeight,
  });

  final ScrollController scrollController;
  final List<Country> countries;
  final Country currentCountry;
  final double countryTileHeight;

  @override
  Widget build(BuildContext context) {
    if (countries.isEmpty) return const _CountryNotFound();

    return Scrollbar(
      controller: scrollController,
      child: ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        controller: scrollController,
        itemCount: countries.length,
        itemBuilder: (context, index) {
          final country = countries[index];
          final isSelected = currentCountry.isoCode == country.isoCode;

          return AppInkWell(
            key: ValueKey(country.isoCode),
            onTap: () => Navigator.of(context).pop(country),
            child: CountryTile(
              isSelected: isSelected,
              country: country,
              countryTileHeight: countryTileHeight,
            ),
          );
        },
      ),
    );
  }
}

class _CountryNotFound extends StatelessWidget {
  const _CountryNotFound();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 24, top: 16),
      child: Text('Not found'),
    );
  }
}
