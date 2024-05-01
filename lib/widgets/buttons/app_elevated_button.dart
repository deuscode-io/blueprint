import 'package:blueprint/core/DI/injector.dart';
import 'package:blueprint/core/features/logs/logger.dart';
import 'package:blueprint/core/i18n/translate.dart';
import 'package:blueprint/widgets/indicators/three_dots_indicator.dart';
import 'package:flutter/material.dart';

enum ButtonState { enabled, disabled, busy }

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.buttonState = ButtonState.enabled,
    this.shouldTakeAllWidth = false,
  });

  final VoidCallback onPressed;
  final String label;
  final ButtonState buttonState;
  final bool shouldTakeAllWidth;

  static final Logger _logger = Injector.get();
  static final Translate _translate = Injector.get();

  factory AppElevatedButton.allWidth({
    Key? key,
    required VoidCallback onPressed,
    required String label,
    ButtonState buttonState = ButtonState.enabled,
  }) {
    return AppElevatedButton(
      key: key,
      onPressed: onPressed,
      label: label,
      buttonState: buttonState,
      shouldTakeAllWidth: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: _onPressed(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: _labelOpacity,
            child: Text(_translate(label)),
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

    if (shouldTakeAllWidth) {
      return Row(children: [Expanded(child: button)]);
    }

    return button;
  }

  void Function()? _onPressed() {
    return switch (buttonState) {
      ButtonState.disabled => null,
      ButtonState.enabled => onPressed.call,
      _ => () => _logger.log('onPressed is ignored'),
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
