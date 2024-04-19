import 'package:blueprint/core/DI/injector.dart';
import 'package:blueprint/core/logs/logger.dart';
import 'package:blueprint/ui/widgets/buttons/app_elevated_button.dart';
import 'package:blueprint/ui/widgets/collections/component_group.dart';
import 'package:blueprint/ui/widgets/texts/component_label.dart';
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

// @override
// Widget build(BuildContext context) {
//   return CustomScrollView(
//     slivers: [
//       SliverToBoxAdapter(
//         child: Scrollbar(
//           child: ListView(
//             scrollDirection: Axis.horizontal,
//             children: [
//               ElevatedButton(onPressed: () {}, child: const Text('ElevatedButton')),
//             ],
//
//           ),
//         ),
//       ),
//     ],
//     // child: Column(
//     //   children: [
//     //     const Text('Buttons:'),
//     //     ListView(
//     //       shrinkWrap: false,
//     //       scrollDirection: Axis.horizontal,
//     //       children: [
//     //         ElevatedButton(onPressed: () {}, child: const Text('ElevatedButton')),
//     //       ],
//     //     ),
//     //     FilledButton(onPressed: () {}, child: const Text('FilledButton')),
//     //     FilledButton.tonal(onPressed: () {}, child: const Text('FilledButtonTonal')),
//     //     OutlinedButton(onPressed: () {}, child: const Text('OutlinedButton')),
//     //     TextButton(onPressed: () {}, child: const Text('TextButton')),
//     //     const SizedBox(height: 24),
//     //     const Text('TextFields:'),
//     //   ],
//     // ).childrenPadding(
//     //   const EdgeInsets.only(top: 12),
//     // ),
//   );
// }
}
