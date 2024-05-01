import 'package:blueprint/utils/appearance/library_appearance.dart';
import 'package:blueprint/utils/extensions/context_ext.dart';
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
    return SpinKitThreeBounce(
      size: size,
      color: context.getThemeColor(
        light: AppColorsLight.threeDotIndicator,
        dark: AppColorsDark.threeDotIndicator,
      ),
    );
  }
}
