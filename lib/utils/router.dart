import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:nestify/screens/mybuilds_screen.dart';
import 'package:nestify/screens/edit_blue_print_screen.dart';
import '../screens/home_screen.dart';
import '../screens/detail_screen/detail_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen/search_screen.dart';
import '../screens/add_blue_print_screen.dart';
import '../auth_gate.dart';
import 'package:nestify/screens/favorites_screen.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey =
    GlobalKey<NavigatorState>(debugLabel: 'homepage');
final _shellNavigatorDetailKey =
    GlobalKey<NavigatorState>(debugLabel: 'detailpage');
final _shellNavigatorSearchKey =
    GlobalKey<NavigatorState>(debugLabel: 'searchpage');
final _shellNavigatorAddKey = GlobalKey<NavigatorState>(debugLabel: 'Addpage');
final _shellNavigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'profilepage');
final _shellNavigatorEditKey =
    GlobalKey<NavigatorState>(debugLabel: 'editpage');

// the one and only GoRouter instance
final goRouter = GoRouter(
  initialLocation: '/login',
  navigatorKey: _rootNavigatorKey,
  routes: [
    // Stateful nested navigation based on:
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // the UI shell
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        // first branch Home
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomeScreen(),
              ),
              routes: [
                GoRoute(
                  path: '/edit',
                  builder: (context, state) {
                    final map = state.extra as Map<String,
                        dynamic>; // Extracting the post from extra
                    return EditBlueprintScreen(
                        post: map['post'],
                        onEdit: map['onEdit'],
                        key: _shellNavigatorEditKey);
                  },
                ),
                // child route
                GoRoute(
                  path: '/details',
                  builder: (context, state) {
                    final map = state.extra as Map<String,
                        dynamic>; // Extracting the post from extra
                    return DetailScreen(
                        post: map['post'],
                        onEdit: map['onEdit'],
                        key: _shellNavigatorDetailKey);
                  },
                  routes: [
                    GoRoute(
                      path: '/edit',
                      builder: (context, state) {
                        final map = state.extra as Map<String,
                            dynamic>; // Extracting the post from extra
                        return EditBlueprintScreen(
                            post: map['post'],
                            onEdit: map['onEdit'],
                            key: _shellNavigatorEditKey);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        // second branch Search
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSearchKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/search',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SearchScreen(),
              ),
              routes: [
                GoRoute(
                    path: '/edit',
                    builder: (context, state) {
                      final map = state.extra as Map<String,
                          dynamic>; // Extracting the post from extra
                      return EditBlueprintScreen(
                          post: map['post'],
                          onEdit: map['onEdit'],
                          key: _shellNavigatorEditKey);
                    }),
                // child route
                GoRoute(
                  path: '/details',
                  builder: (context, state) {
                    final map = state.extra as Map<String,
                        dynamic>; // Extracting the post from extra
                    return DetailScreen(
                        post: map['post'],
                        onEdit: map['onEdit'],
                        key: _shellNavigatorDetailKey);
                  },
                  routes: [
                    GoRoute(
                      path: '/edit',
                      builder: (context, state) {
                        final map = state.extra as Map<String,
                            dynamic>; // Extracting the post from extra
                        return EditBlueprintScreen(
                            post: map['post'],
                            onEdit: map['onEdit'],
                            key: _shellNavigatorEditKey);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAddKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/add',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: AddBlueprintScreen(),
              ),
              // routes: [
              //   // child route
              //   GoRoute(
              //     path: 'details',
              //     builder: (context, state) =>
              //         const DetailsScreen(label: 'B'),
              //   ),
              // ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProfileKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/profile',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ProfileScreen(),
              ),
              routes: [
                // child route
                GoRoute(
                  path: 'favorites',
                  builder: (context, state) => const FavoritesScreen(),
                  routes: [
                    // child route
                    GoRoute(
                      path: '/details',
                      builder: (context, state) {
                        final map = state.extra as Map<String,
                            dynamic>; // Extracting the post from extra
                        return DetailScreen(
                            post: map['post'],
                            onEdit: map['onEdit'],
                            key: _shellNavigatorDetailKey);
                      },
                      routes: [
                        GoRoute(
                          path: '/edit',
                          builder: (context, state) {
                            final map = state.extra as Map<String,
                                dynamic>; // Extracting the post from extra
                            return EditBlueprintScreen(
                                post: map['post'],
                                onEdit: map['onEdit'],
                                key: _shellNavigatorEditKey);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                GoRoute(
                  path: 'mybuilds',
                  builder: (context, state) => const MybuildsScreen(),
                  routes: [
                    GoRoute(
                      path: '/edit',
                      builder: (context, state) {
                        final map = state.extra as Map<String,
                            dynamic>; // Extracting the post from extra
                        return EditBlueprintScreen(
                            post: map['post'],
                            onEdit: map['onEdit'],
                            key: _shellNavigatorEditKey);
                      },
                    ),
                    // child route
                    GoRoute(
                      path: '/details',
                      builder: (context, state) {
                        final map = state.extra as Map<String,
                            dynamic>; // Extracting the post from extra
                        return DetailScreen(
                            post: map['post'],
                            onEdit: map['onEdit'],
                            key: _shellNavigatorDetailKey);
                      },
                      routes: [
                        GoRoute(
                          path: '/edit',
                          builder: (context, state) {
                            final map = state.extra as Map<String,
                                dynamic>; // Extracting the post from extra
                            return EditBlueprintScreen(
                                post: map['post'],
                                onEdit: map['onEdit'],
                                key: _shellNavigatorEditKey);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: AuthGate(),
      ),
    ),
  ],
  redirect: (context, state) {
    // Check if the user is authenticated
    final FirebaseAuth auth = FirebaseAuth.instance;

    final loggedIn = auth.currentUser != null;
    final loggingIn = state.uri.toString() == '/login';
    if (!loggedIn) return loggingIn ? null : '/login';

    // if the user is logged in but still on the login page, send them to
    // the home page
    if (loggingIn) return '/home';

    // no need to redirect at all
    return null;
  },
  refreshListenable:
      GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),
);

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    stream.listen((_) => notifyListeners());
  }
}

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle),
            label: "Add",
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle),
            label: "Profile",
          ),
        ],
        onDestinationSelected: _goBranch,
      ),
    );
  }
}
