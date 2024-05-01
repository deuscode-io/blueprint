import 'package:flag/flag.dart';
import 'package:flutter/material.dart';

class CountryFlag extends StatelessWidget {
  const CountryFlag({super.key, required this.isoCode});

  final String isoCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).iconTheme.color,
      ),
      padding: const EdgeInsets.all(2),
      child: Flag.fromString(
        isoCode,
        fit: BoxFit.fill,
        flagSize: FlagSize.size_1x1,
        borderRadius: 26,
      ),
    );
  }
}
