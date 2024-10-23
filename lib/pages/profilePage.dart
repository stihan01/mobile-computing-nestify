import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.arrow_back),
          ),
        title: const Text('Profile Screen')
      ),
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
            // ElevatedButton(
            //   onPressed: () => context.go('/'),
            //   child: const Text('Go back to the Home screen'),
            // ),

            Container(
              margin: const EdgeInsets.only(
                top: 7,
              ),
              child: SizedBox(
                height: 500,
                child: ListView(
                  children: [
                    buildListTile("Favourites", "List of your favourite builds", Icons.favorite),
                    buildListTile("My Builds", "List of your own blueprints", Icons.bungalow_outlined),
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

  // Function to create a ListTile
  Widget buildListTile(String title, String subtitle, IconData leadingIcon) {
    return Container(
      margin: const EdgeInsets.only(
        top: 0,
        right: 20,
        bottom: 10,
        left: 20,
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
            print('$title tapped');
          },
        ),
      ),
    );
  }
}