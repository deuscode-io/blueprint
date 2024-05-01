import 'package:blueprint/utils/appearance/library_appearance.dart';
import 'package:blueprint/utils/extensions/context_ext.dart';
import 'package:flutter/material.dart';

const double _dragHandlerHeight = 4;
const double _dragHandlerWidth = 40;

class DragHandler extends StatelessWidget {
  const DragHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _dragHandlerHeight,
      width: _dragHandlerWidth,
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: context.getThemeColor(
          light: AppColorsLight.dragHandler,
          dark: AppColorsDark.dragHandler,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(24),
        ),
      ),
    );
  }
}
