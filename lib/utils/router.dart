import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;

import 'package:nestify/utils/branches/add_branch.dart';
import 'package:nestify/utils/branches/home_branch.dart';
import 'package:nestify/utils/branches/profile_branch.dart';
import 'package:nestify/utils/branches/search_branch.dart';

import '../auth_gate.dart';

// the one and only GoRouter instance
final goRouter = GoRouter(
  initialLocation: '/login',
  navigatorKey: GlobalKey<NavigatorState>(), // Root navigator key
  routes: [
    // Stateful nested navigation based on:
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // the UI shell
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        homeBranch(),
        searchBranch(),
        addBranch(),
        profileBranch(),
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
