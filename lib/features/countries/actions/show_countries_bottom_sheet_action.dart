import 'package:blueprint/features/countries/models/country.dart';
import 'package:blueprint/features/countries/ui/countries_bottom_sheet.dart';
import 'package:blueprint/widgets/bottom_sheets/actions/show_draggable_bottom_sheet_action.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class ShowCountriesBottomSheetAction {
  const ShowCountriesBottomSheetAction({required this.showDraggableBottomSheet});

  final ShowDraggableBottomSheetAction showDraggableBottomSheet;

  Future<dynamic> call({
    required BuildContext context,
    required List<Country> countries,
    required Country selectedCountry,
  }) async {
    return showDraggableBottomSheet(
      context: context,
      onBuiltScrollController: (scrollController) {
        return CountriesBottomSheet(
          scrollController: scrollController,
          countries: countries,
          selectedCountry: selectedCountry,
        );
      },
    );
  }
}
