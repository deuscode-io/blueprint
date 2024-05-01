import 'package:blueprint/features/countries/models/country.dart';
import 'package:blueprint/features/countries/ui/widgets/country_flag.dart';
import 'package:blueprint/widgets/collections/selectable_tile_items_group.dart';
import 'package:flutter/material.dart';

class CountryTile extends StatelessWidget {
  const CountryTile({
    super.key,
    required this.country,
    required this.isSelected,
    required this.countryTileHeight,
  });

  final Country country;
  final bool isSelected;
  final double countryTileHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: countryTileHeight,
      child: SelectableTileItemsGroup(
        isSelected: isSelected,
        children: [
          CountryFlag(isoCode: country.isoCode),
          const SizedBox(width: 12),
          _FixedWidthNumberCode(country.phoneCode),
          Expanded(
            child: Text(
              country.name,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _FixedWidthNumberCode extends StatelessWidget {
  const _FixedWidthNumberCode(this.phoneCode);

  final String phoneCode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Text(phoneCode),
            const Opacity(
              opacity: 0,
              child: Text('+9999'),
            ),
          ],
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}
