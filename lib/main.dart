import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,);
        title: "Nestify",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.red, brightness: Brightness.light),
          useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
          ),
        ),
        home: const AddBlueprintScreen());
  }
}

