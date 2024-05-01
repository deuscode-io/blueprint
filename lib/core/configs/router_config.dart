import 'package:blueprint/features/authentication/ui/initial_page.dart';
import 'package:blueprint/features/components/ui/components_page.dart';
import 'package:blueprint/features/details/ui/detail_page.dart';
import 'package:blueprint/features/favorites/ui/favorites_page.dart';
import 'package:blueprint/features/home/ui/home_page.dart';
import 'package:blueprint/features/notes/ui/notes_page.dart';
import 'package:blueprint/features/profile/ui/profile_page.dart';
import 'package:go_router/go_router.dart';

final routerConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const InitialPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => HomePage(
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
