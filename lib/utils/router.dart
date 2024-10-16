import 'package:go_router/go_router.dart';
import '../pages/homePage.dart';
import '../pages/detailPage.dart';
import '../pages/profilePage.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) => const DetailPage()
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const Profilepage()
    ),
  ],
);