import 'package:flutter/material.dart';
import 'package:nestify/providers/post_model.dart';
import 'utils/router.dart';
import 'package:provider/provider.dart';
import 'providers/model.dart';
import 'models/searchModel.dart';
// firebase imports
import 'package:firebase_core/firebase_core.dart';
import 'package:nestify/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Model()),
      ChangeNotifierProvider(create: (context) => AddPostModel()),
      ChangeNotifierProvider(create: (context) => SearchModel())
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
      theme: themeMode(ColorScheme.fromSeed(
          contrastLevel: 1,
          seedColor: Colors.red,
          brightness: Brightness.light)),
      darkTheme: themeMode(
        ColorScheme.fromSeed(
            seedColor: Colors.black, brightness: Brightness.dark),
      ),
    );
  }

  ThemeData themeMode(ColorScheme scheme) {
    return ThemeData(
        colorScheme: scheme,
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ));
  }
}
