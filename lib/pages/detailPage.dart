import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details Screen')),
      body: Column(
        children: [
          const TabBar(tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ]),
              const TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
          Row(
            children: [
              ElevatedButton(onPressed: () => context.go('/'), child: Text('Go back to the Home screen')),
            ],
          ),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('Go back to the Home screen'),
          ),
          
        ],
      ),
    );
  }
}