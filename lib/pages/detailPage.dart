import 'package:flutter/material.dart';
import 'package:nestify/widgets/tabBox.dart';
import 'package:nestify/widgets/commentSection.dart';
import 'package:go_router/go_router.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController commentController = TextEditingController();
    return DefaultTabController(
      length: 2, // We have 2 tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Hanna's bird of paradise hotel"),
           leading: IconButton(
            icon: const Icon(Icons.arrow_back), // Back icon
            onPressed: () => context.pop(), // Go back to home
          ),
        ),

        body: ListView( // Wrap everything in ListView for overall scrollability
          padding: const EdgeInsets.all(16.0),

          children: [
            // Image
            Image.network(
              'https://s42814.pcdn.co/wp-content/uploads/2020/04/House_One___Birdhouse___Drawing.png', // Replace with actual birdhouse image URL
              height: 400,
              width: 100,
              fit: BoxFit.cover, // Optional: to cover the box size proportionally
            ),
            
            // Spacing
            const SizedBox(height: 16),

            // Box with Tabs
            const TabBox(),
            
            // Spacing
            const SizedBox(height: 16),

            // Comment Section
            CommentSection(commentController: commentController,),

            // Spacing
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}