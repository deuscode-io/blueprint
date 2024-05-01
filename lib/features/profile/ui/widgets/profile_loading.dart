import 'package:blueprint/widgets/indicators/three_dots_indicator.dart';
import 'package:flutter/material.dart';

class ProfileLoading extends StatelessWidget {
  const ProfileLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      flex: 1000,
      child: Center(child: ThreeDotsIndicator()),
    );
  }
}
