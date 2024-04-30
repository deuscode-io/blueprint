import 'package:blueprint/utils/appearance/library_appearance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ThreeDotsIndicator extends StatelessWidget {
  const ThreeDotsIndicator({
    super.key,
    this.size = 24,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.dark
        ? AppColorsDark.threeDotIndicatorColor
        : AppColorsLight.threeDotIndicatorColor;

    return SpinKitThreeBounce(
      size: size,
      color: color,
    );
  }
}
