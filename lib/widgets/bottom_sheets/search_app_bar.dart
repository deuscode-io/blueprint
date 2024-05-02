import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:blueprint/widgets/bottom_sheets/drag_handler.dart';
import 'package:blueprint/widgets/input_fields/search/search_field.dart';
import 'package:flutter/material.dart';

const double _toolbarHeight = 100;

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ValueChanged<String> onChanged;

  const SearchAppBar({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: _toolbarHeight,
      automaticallyImplyLeading: false,
      title: Column(
        children: [
          const DragHandler(),
          const SizedBox(height: 16),
          SearchField(
            label: LocaleKeys.search_labels_country_phone,
            prefixIcon: const Icon(Icons.language),
            onChanged: onChanged,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_toolbarHeight);
}
