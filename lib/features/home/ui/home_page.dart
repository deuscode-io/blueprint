import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('DeusCode blueprint'),
      ),
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        destinations: _buildBottomNavBarItems,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        selectedIndex: navigationShell.currentIndex,
      ),
    );
  }

  List<NavigationDestination> get _buildBottomNavBarItems => [
        const NavigationDestination(
          selectedIcon: Icon(Icons.note),
          icon: Icon(Icons.note_outlined),
          label: 'Notes',
        ),
        const NavigationDestination(
          selectedIcon: Icon(Icons.favorite),
          icon: Icon(Icons.favorite_outline),
          label: 'Favorites',
        ),
        const NavigationDestination(
          selectedIcon: Icon(Icons.person),
          icon: Icon(Icons.person_outlined),
          label: 'Profile',
        ),
        const NavigationDestination(
          selectedIcon: Icon(Icons.settings_input_component),
          icon: Icon(Icons.settings_input_component_outlined),
          label: 'Components',
        ),
      ];
}
