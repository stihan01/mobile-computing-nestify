import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nestify/providers/edit_post_model.dart';
import 'package:nestify/screens/home_screen.dart';
import 'package:nestify/utils/reusable_getters.dart';
import 'package:provider/provider.dart';

class HomeScreenKeys {
  static final GlobalKey<NavigatorState> homeKey =
      GlobalKey<NavigatorState>(debugLabel: 'home screen');

  static final GlobalKey<NavigatorState> editKey =
      GlobalKey<NavigatorState>(debugLabel: 'home edit screen');

  static final GlobalKey<NavigatorState> detailsKey =
      GlobalKey<NavigatorState>(debugLabel: 'home details screen');
}

StatefulShellBranch homeBranch() {
  return StatefulShellBranch(
    navigatorKey: HomeScreenKeys.homeKey,
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
              final map = state.extra
                  as Map<String, dynamic>; // Extracting the post from extra
              return getEditScreen(
                  map: map,
                  context: context,
                  model: Provider.of<HomeEditPostModel>(context, listen: false),
                  key: HomeScreenKeys.editKey);
            },
          ),
          // child route
          GoRoute(
            path: '/details',
            builder: (context, state) {
              final map = state.extra
                  as Map<String, dynamic>; // Extracting the post from extra
              return getDetailsScreen(
                  map: map, context: context, key: HomeScreenKeys.detailsKey);
            },
            routes: [
              GoRoute(
                path: '/edit',
                builder: (context, state) {
                  final map = state.extra
                      as Map<String, dynamic>; // Extracting the post from extra
                  return getEditScreen(
                      map: map,
                      context: context,
                      model: Provider.of<HomeEditPostModel>(context,
                          listen: false),
                      key: HomeScreenKeys.editKey);
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
