import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nestify/screens/upsert_screens/add_blue_print_screen.dart';

class AddScreenKeys {
  static final GlobalKey<NavigatorState> addKey =
      GlobalKey<NavigatorState>(debugLabel: 'add screen');
}

StatefulShellBranch addBranch() {
  return StatefulShellBranch(
    navigatorKey: AddScreenKeys.addKey,
    routes: [
      // top route inside branch
      GoRoute(
        path: '/add',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: AddBlueprintScreen(),
        ),
      ),
    ],
  );
}
