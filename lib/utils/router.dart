import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../pages/homePage.dart';
import '../pages/detailPage.dart';
import '../pages/profilePage.dart';
import '../pages/searchPage.dart';
import '../screens/add_blue_print_screen.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'homepage');
final _shellNavigatorSearchKey = GlobalKey<NavigatorState>(debugLabel: 'searchpage');
final _shellNavigatorAddKey = GlobalKey<NavigatorState>(debugLabel: 'Addpage');
final _shellNavigatorProfileKey = GlobalKey<NavigatorState>(debugLabel: 'profilepage');


// the one and only GoRouter instance
final goRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    // Stateful nested navigation based on:
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // the UI shell
        return ScaffoldWithNestedNavigation(
            navigationShell: navigationShell);
      },
      branches: [
        // first branch Home
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomePage(),
              ),
              routes: [
                // child route
                GoRoute(
                  path: 'details',
                  builder: (context, state) =>
                      const DetailPage(),
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
                child: SearchPage(),
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
                child: ProfilePage(),
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
      ],
    ),
  ],
);


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
          icon: Icon(Icons.location_on),
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