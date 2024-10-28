import 'package:flutter/material.dart';
import 'package:nestify/auth_gate.dart';
import 'package:nestify/providers/post_model.dart';
import 'utils/router.dart';
import 'package:provider/provider.dart';
import 'providers/model.dart';
// firebase imports
import 'package:firebase_core/firebase_core.dart';
import 'package:nestify/firebase_options.dart';
import 'package:nestify/apis/firestore_db.dart';
import 'dart:developer';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Model()),
      ChangeNotifierProvider(create: (context) => PostModel())
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
      title: "Nestify",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red, brightness: Brightness.light),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
