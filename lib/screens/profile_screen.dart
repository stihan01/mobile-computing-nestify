import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase_ui;
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Profile Picture
                const CircleAvatar(
                  radius: 50, // Adjust size by changing the radius
                  backgroundImage: AssetImage(
                      'assets/images/profilepic.jpg'), // Set image path
                ),

                // Column med textrader som är aligned till vänster
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0), // Set left padding
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Birdie Robinson",
                            style: Theme.of(context).textTheme.titleLarge),
                        Text("Member since 2021-09-01",
                            style: Theme.of(context).textTheme.bodyMedium),
                        TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.edit),
                            label: const Text("Edit Profile")),
                      ]),
                ),
              ],
            ),
          ),

          // A Button for Home Screen
          // ElevatedButton(
          //   onPressed: () => context.go('/'),
          //   child: const Text('Go back to the Home screen'),
          // ),

          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                top: 7,
              ),
              child: ListView(
                children: [
                  buildListTile("Favourites", "List of your favourite builds",
                      Icons.favorite, context, '/profile/favorites'),
                  buildListTile("My Builds", "List of your own blueprints",
                      Icons.bungalow_outlined, context, '/profile/mybuilds'),
                  const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0), // Set horizontal and vertical padding
                      child: firebase_ui.SignOutButton()),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  // Function to create a ListTile
  Widget buildListTile(String title, String subtitle, IconData leadingIcon,
      BuildContext context, String route) {
    return Container(
      margin: const EdgeInsets.only(
        top: 0,
        right: 16,
        bottom: 10,
        left: 16,
      ),
      child: Card(
        elevation: 1, // Shadow effect
        shape: RoundedRectangleBorder(
          // side: BorderSide(color: Colors.blueAccent, width: 2), // Outline
          borderRadius: BorderRadius.circular(8), // Rounded corners (optional)
        ),

        child: ListTile(
          leading: Icon(leadingIcon),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            // Handle tap here, e.g., navigate or perform some action
            context.go(route);
          },
        ),
      ),
    );
  }
}
