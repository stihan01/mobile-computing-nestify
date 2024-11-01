import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nestify/screens/favorites_screen.dart';
import 'package:nestify/screens/mybuilds_screen.dart';
import 'package:nestify/screens/profile_screen.dart';
import 'package:nestify/providers/edit_post_model.dart';
import 'package:provider/provider.dart';
import 'package:nestify/utils/reusable_getters.dart';

class ProfileScreenKeys {
  static final GlobalKey<NavigatorState> profileKey =
      GlobalKey<NavigatorState>(debugLabel: 'profile screen');

  static final GlobalKey<NavigatorState> editKey =
      GlobalKey<NavigatorState>(debugLabel: 'profile edit screen');

  static final GlobalKey<NavigatorState> detailsKey =
      GlobalKey<NavigatorState>(debugLabel: 'profile details screen');
}

StatefulShellBranch profileBranch() {
  return StatefulShellBranch(
    navigatorKey: ProfileScreenKeys.profileKey,
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
                  final map = state.extra
                      as Map<String, dynamic>; // Extracting the post from extra
                  return getDetailsScreen(
                      map: map,
                      context: context,
                      key: ProfileScreenKeys.detailsKey);
                },
                routes: [
                  GoRoute(
                    path: '/edit',
                    builder: (context, state) {
                      final map = state.extra as Map<String,
                          dynamic>; // Extracting the post from extra
                      return getEditScreen(
                          map: map,
                          context: context,
                          model: Provider.of<ProfileEditPostModel>(context,
                              listen: false),
                          key: ProfileScreenKeys.editKey);
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
                  final map = state.extra
                      as Map<String, dynamic>; // Extracting the post from extra
                  return getEditScreen(
                      map: map,
                      context: context,
                      model: Provider.of<ProfileEditPostModel>(context,
                          listen: false),
                      key: ProfileScreenKeys.editKey);
                },
              ),
              // child route
              GoRoute(
                path: '/details',
                builder: (context, state) {
                  final map = state.extra
                      as Map<String, dynamic>; // Extracting the post from extra
                  return getDetailsScreen(
                      map: map,
                      context: context,
                      key: ProfileScreenKeys.detailsKey);
                },
                routes: [
                  GoRoute(
                    path: '/edit',
                    builder: (context, state) {
                      final map = state.extra as Map<String,
                          dynamic>; // Extracting the post from extra
                      return getEditScreen(
                          map: map,
                          context: context,
                          model: Provider.of<ProfileEditPostModel>(context,
                              listen: false),
                          key: ProfileScreenKeys.editKey);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
