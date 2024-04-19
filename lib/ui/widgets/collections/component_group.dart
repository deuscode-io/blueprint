import 'package:flutter/material.dart';

class ComponentGroup extends StatelessWidget {
  const ComponentGroup({super.key, required this.group});

  final Iterable<Widget> group;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: group.toList(),
      ),
    );
  }
}
