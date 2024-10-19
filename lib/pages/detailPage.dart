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
            onPressed: () {
              () => context.go('/'); // Go back to home
            },
          ),
        ),

        body: ListView( // Wrap everything in ListView for overall scrollability
          padding: const EdgeInsets.all(16.0),

          children: [
            // Image
            Container(
              width: double.infinity, // Make the container take full width
              height: 300, // Set a specific height for the image
              color: Colors.blue,
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