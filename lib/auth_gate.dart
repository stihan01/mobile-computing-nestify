import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase_ui;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // SignInScreen is provided by FlutterFire UI
          return firebase_ui.SignInScreen(
            providers: [
              firebase_ui.EmailAuthProvider(),
            ],
            // Any widget inside the headerbuilder callback will be displayed at the top of screen
            headerBuilder: (context, constraints, shrinkOffset) {
              return const Padding(
                padding: EdgeInsets.all(20),
                // TODO Add a picture if we want a "logo". Uncomment and replace path
                /* child: AspectRatio(
                  aspectRatio: 1,
                  //    child: Image.asset('assets/flutterfire_300x.png'),
                ), */
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == firebase_ui.AuthAction.signIn
                    ? const Text('Welcome to Nestify, please sign in!')
                    : const Text('Welcome to Nestify, please sign up!'),
              );
            },
            /*  footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }, */
          );
        }
        return Scaffold(
            body: Center(
                child: IconButton(
                    onPressed: () => context.go('/'),
                    icon: const Icon(Icons.home))));
      },
    );
  }
}
