import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Center(child: Text('Hello World!')));
  }
}

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({super.key});

  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentTabIndex = index;
        });
      },

      // indicatorColor: Colors.amber,
      selectedIndex: currentTabIndex,

      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.location_on),
          label: "Home",
        ),
        NavigationDestination(
          icon: Icon(Icons.search),
          label: "Search",
        ),
        NavigationDestination(
          icon: Icon(Icons.add_circle),
          label: "Add",
        ),
        NavigationDestination(
          icon: Icon(Icons.account_circle),
          label: "Profile",
        ),
      ],
    );
  }
}
