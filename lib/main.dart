import 'package:flutter/material.dart';
import '/utils/router.dart';

void main() {
  runApp(const MainApp());
}

//Test line

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
