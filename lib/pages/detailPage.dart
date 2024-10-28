import 'package:flutter/material.dart';
import 'package:nestify/widgets/tabBox.dart';
import 'package:nestify/widgets/commentSection.dart';
import 'package:go_router/go_router.dart';
import 'package:nestify/models/blueprint_post.dart';



class DetailPage extends StatelessWidget {
  final BlueprintPost post;
  final String placeholderImage = 'assets/images/buzzhotel.jpg';
  const DetailPage({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController commentController = TextEditingController();
    return DefaultTabController(
      length: 2, // We have 2 tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text(post.title ?? 'Title'),
           leading: IconButton(
            icon: const Icon(Icons.arrow_back), // Back icon
            onPressed: () => context.pop(), // Go back to home
          ),
        ),

        body: ListView( // Wrap everything in ListView for overall scrollability
          padding: const EdgeInsets.all(16.0),

          children: [
            // Image
            Image.asset(
              placeholderImage, //TODO: change to actual image
              height: 400,
              width: 100,
              fit: BoxFit.cover, // Optional: to cover the box size proportionally
            ),

            // Spacing
            const SizedBox(height: 16),

            // Box with Tabs
            TabBox(post: post,),

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