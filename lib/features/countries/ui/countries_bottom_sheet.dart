import 'package:blueprint/features/countries/models/country.dart';
import 'package:blueprint/features/countries/ui/widgets/country_tiles.dart';
import 'package:blueprint/widgets/input_fields/search_field.dart';
import 'package:flutter/material.dart';

class CountriesBottomSheet extends StatefulWidget {
  const CountriesBottomSheet({
    super.key,
    required this.scrollController,
    required this.countries,
    required this.selectedCountry,
  });

  final ScrollController scrollController;
  final List<Country> countries;
  final Country selectedCountry;

  @override
  State<CountriesBottomSheet> createState() => _CountriesBottomSheetState();
}

class _CountriesBottomSheetState extends State<CountriesBottomSheet> {
  final _countries = <Country>[];
  final _countryTileHeight = 56.0;

  @override
  void initState() {
    super.initState();
    _countries.addAll(widget.countries);
    _animateScrollPositionToSelectedCountry();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        appBar: SearchField(
          onChanged: _updateCountriesListOnNewSearch,
        ),
        body: CountryTiles(
          scrollController: widget.scrollController,
          countries: _countries,
          currentCountry: widget.selectedCountry,
          countryTileHeight: _countryTileHeight,
        ),
      ),
    );
  }

  void _updateCountriesListOnNewSearch(String input) {
    setState(() {
      _countries.clear();
      _countries.addAll(widget.countries);
      if (input.isEmpty) {
        _animateScrollPositionToSelectedCountry(isInitial: false);
      } else {
        _countries.retainWhere((country) {
          return _isCountryMatchedSearch(country, input);
        });
        _dropScrollPosition();
      }
    });
  }

  void _animateScrollPositionToSelectedCountry({bool isInitial = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final selectedCountryPhoneIndex =
          widget.countries.indexOf(widget.selectedCountry);

      if (selectedCountryPhoneIndex != -1) {
        widget.scrollController.animateTo(
          selectedCountryPhoneIndex * _countryTileHeight,
          duration: isInitial
              ? const Duration(milliseconds: 750)
              : const Duration(milliseconds: 250),
          curve: Curves.ease,
        );
      }
    });
  }

  void _dropScrollPosition() {
    if (widget.scrollController.hasClients) widget.scrollController.jumpTo(0.0);
  }

  bool _isCountryMatchedSearch(Country country, String search) {
    final lowerCaseSearch = search.toLowerCase();
    final goal = '${country.name}${country.phoneCode}'.toLowerCase();

    return goal.contains(lowerCaseSearch);
  }
}
