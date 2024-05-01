import 'package:blueprint/widgets/bottom_sheets/drag_handler.dart';
import 'package:flutter/material.dart';

const double _toolbarHeight = 100;

class SearchField extends StatelessWidget implements PreferredSizeWidget {
  final ValueChanged<String> onChanged;

  const SearchField({
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
          TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Search ...',
            ),
            onChanged: (search) => onChanged(search.trim()),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_toolbarHeight);
}
