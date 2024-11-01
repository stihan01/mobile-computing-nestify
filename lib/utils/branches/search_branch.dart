import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nestify/providers/edit_post_model.dart';
import 'package:nestify/screens/search_screen/search_screen.dart';
import 'package:nestify/utils/reusable_getters.dart';
import 'package:provider/provider.dart';

class SearchScreenKeys {
  static final GlobalKey<NavigatorState> searchKey =
      GlobalKey<NavigatorState>(debugLabel: 'search screen');

  static final GlobalKey<NavigatorState> editKey =
      GlobalKey<NavigatorState>(debugLabel: 'search edit screen');

  static final GlobalKey<NavigatorState> detailsKey =
      GlobalKey<NavigatorState>(debugLabel: 'search details screen');
}

StatefulShellBranch searchBranch() {
  return StatefulShellBranch(
    navigatorKey: SearchScreenKeys.searchKey,
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
                final map = state.extra
                    as Map<String, dynamic>; // Extracting the post from extra
                return getEditScreen(
                    map: map,
                    context: context,
                    model: Provider.of<SearchEditPostModel>(context,
                        listen: false),
                    key: SearchScreenKeys.editKey);
              }),
          // child route
          GoRoute(
            path: '/details',
            builder: (context, state) {
              final map = state.extra
                  as Map<String, dynamic>; // Extracting the post from extra
              return getDetailsScreen(
                  map: map, context: context, key: SearchScreenKeys.detailsKey);
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
                      model: Provider.of<SearchEditPostModel>(context,
                          listen: false),
                      key: SearchScreenKeys.editKey);
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
