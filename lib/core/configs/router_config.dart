import 'package:blueprint/ui/pages/components/components_page.dart';
import 'package:blueprint/ui/pages/notes/detail_page.dart';
import 'package:blueprint/ui/pages/notes/favorites_page.dart';
import 'package:blueprint/ui/pages/notes/notes_page.dart';
import 'package:blueprint/ui/pages/profile/profile_page.dart';
import 'package:blueprint/ui/pages/root_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final routerConfig = GoRouter(
  initialLocation: '/components',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return Container(
          color: Colors.teal,
        );
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => RootPage(
        navigationShell: navigationShell,
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/notes',
              builder: (context, state) => const NotesPage(),
              routes: [
                GoRoute(
                  path: 'detail',
                  builder: (context, state) => const DetailPage(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) => const FavoritesPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/components',
              builder: (context, state) => const ComponentsPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
