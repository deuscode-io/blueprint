import 'package:blueprint/core/DI/injector.dart';
import 'package:blueprint/core/features/logs/logger.dart';
import 'package:blueprint/widgets/buttons/app_elevated_button.dart';
import 'package:blueprint/widgets/collections/component_group.dart';
import 'package:blueprint/widgets/texts/component_label.dart';
import 'package:flutter/material.dart';

class ComponentsPage extends StatefulWidget {
  const ComponentsPage({super.key});

  @override
  State<ComponentsPage> createState() => _ComponentsPageState();
}

final buttonStateList = <(String, ButtonState)>[
  ('Enabled', ButtonState.enabled),
  ('Disabled', ButtonState.disabled),
  ('Enabled', ButtonState.busy),
];

class _ComponentsPageState extends State<ComponentsPage> {
  final Logger logger = Injector.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            slivers: <Widget>[
              const ComponentLabel(label: 'Elevated button'),
              ComponentGroup(
                group: buttonStateList.map(
                  (e) => AppElevatedButton(
                    onPressed: () => logger.log('onPressed'),
                    label: e.$1,
                    buttonState: e.$2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
