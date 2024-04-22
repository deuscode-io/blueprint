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
      color: Theme.of(context).primaryColor,
    );
  }
}
