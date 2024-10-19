import 'package:flutter/material.dart';

class CommentSection extends StatelessWidget {
  final TextEditingController commentController;

  const CommentSection({super.key, required this.commentController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Comment Section Title
        Text(
          'Comments',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Spacing
        const SizedBox(height: 10),

        // Comment Input Box
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: commentController, // Assign the TextEditingController
              decoration: const InputDecoration(
                hintText: 'Write your comment here...',
                border: InputBorder.none, // Remove border
              ),
              maxLines: 3, // Allow for multiline input
            ),
          ),
        ),

        const SizedBox(height: 10), // Add spacing

        // Comment Button
        ElevatedButton(
          onPressed: () {
            // Currently does nothing when pressed
            // You can later implement functionality here
          },
          child: const Text('Comment'),
        ),

        // Spacing
        const SizedBox(height: 20),

        // Comments List
        ListView(
          shrinkWrap: true, // Make the ListView shrink to fit
          physics: const NeverScrollableScrollPhysics(), // Prevent inner scrolling
          children: const [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'John: "I love how simple the instructions were! The birdhouse turned out great, and the birds seem to love it."',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'Emily: "I added a small perch in front of the birdhouse entrance, and it made a huge difference. Highly recommend this extra step!"',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'Michael: "Great project! I struggled a bit with the roof fitting perfectly, but a little sanding helped."',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'Sarah: "My kids enjoyed painting the birdhouse after building it. It’s been a fun family project!"',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
