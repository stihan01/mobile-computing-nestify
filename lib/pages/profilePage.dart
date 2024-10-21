import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Screen')),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: 50,  // Adjust size by changing the radius
                    backgroundImage: AssetImage('assets/img/cool-profile-pictures-63a5e8ee8cdcfab2f952bcd46a73e5c4-263720879.jpg'),
                  ),
              
                  // Column med textrader som är aligned till vänster
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("Emil Emilsson"),
                      Text("Have more text here?")
                    ]
                  ),
                ],
              ),
            ),
            
            // A Button for Home Screen
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go back to the Home screen'),
            ),
          ],
        )
      ),
    );
  }
}