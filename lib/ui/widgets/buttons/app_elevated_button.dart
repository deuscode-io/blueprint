import 'package:blueprint/core/DI/injector.dart';
import 'package:blueprint/core/logs/logger.dart';
import 'package:blueprint/ui/widgets/indicators/three_dots_indicator.dart';
import 'package:flutter/material.dart';

enum ButtonState { enabled, disabled, busy }

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.buttonState = ButtonState.enabled,
  });

  final VoidCallback onPressed;
  final String label;
  final ButtonState buttonState;

  static final Logger logger = Injector.get();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPressed(),
      child: Stack(
        children: [
          Opacity(
            opacity: _labelOpacity,
            child: Text(label),
          ),
          IntrinsicWidth(
            child: Opacity(
              opacity: _indicatorOpacity,
              child: const ThreeDotsIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  void Function()? _onPressed() {
    return switch (buttonState) {
      ButtonState.disabled => null,
      ButtonState.enabled => onPressed.call,
      _ => () => logger.log('onPressed is ignored'),
    };
  }

  double get _labelOpacity {
    return switch (buttonState) {
      ButtonState.enabled => 1,
      ButtonState.disabled => 0.75,
      _ => 0.0,
    };
  }

  double get _indicatorOpacity {
    return switch (buttonState) {
      ButtonState.busy => 1.0,
      _ => 0.0,
    };
  }
}
