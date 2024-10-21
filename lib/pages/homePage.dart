import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nestify/widgets/PreviewCard.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
            onPressed: () => context.go('/details'),
            child: const Text('Go to the Details screen'),
          ),
          PreviewCard(
            image: 'assets/images/buzzhotel.jpg',
            title: "Hanna's Buzz Hotel",
            description: "A bug hotel specifically made for bees",
          ),
        ],
      )),
    );
  }
}
