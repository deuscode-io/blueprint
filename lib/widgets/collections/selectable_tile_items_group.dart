import 'package:blueprint/utils/appearance/library_appearance.dart';
import 'package:blueprint/utils/extensions/context_ext.dart';
import 'package:flutter/material.dart';

class SelectableTileItemsGroup extends StatelessWidget {
  final List<Widget> children;
  final bool isSelected;

  const SelectableTileItemsGroup({
    super.key,
    required this.children,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: isSelected
          ? context.getThemeColor(
              light: AppColorsLight.selectedTile,
              dark: AppColorsDark.selectedTile,
            )
          : Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...children,
            if (isSelected)
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Icon(Icons.check),
              ),
          ],
        ),
      ),
    );
  }
}
