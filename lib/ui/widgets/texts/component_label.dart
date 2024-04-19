import 'package:flutter/material.dart';

class ComponentLabel extends StatelessWidget {
  const ComponentLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Text('$label:'),
    );
  }
}
