import 'package:flutter/material.dart';
import 'package:nestify/models/comment.dart';

// TODO Implement comments function
class CommentSection extends StatelessWidget {
  final TextEditingController commentController;

  const CommentSection({super.key, required this.commentController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommentTextField(commentController: commentController),
        // Spacing
        const SizedBox(height: 20),

        // Comments List
        ListView(
          shrinkWrap: true, // Make the ListView shrink to fit
          physics:
              const NeverScrollableScrollPhysics(), // Prevent inner scrolling
          children: [
            CommentText(
              comment: Comment(
                  userId: "userId",
                  username: "John",
                  postId: "postId",
                  comment:
                      "I love how simple the instructions were! The birdhouse turned out great, and the birds seem to love it."),
            ),
            const SizedBox(
              height: 8,
            ),
            CommentText(
              comment: Comment(
                  userId: "userId",
                  username: "Emily",
                  postId: "postId",
                  comment:
                      "I added a small perch in front of the birdhouse entrance, and it made a huge difference. Highly recommend this extra step!"),
            ),
            const SizedBox(
              height: 8,
            ),
            CommentText(
              comment: Comment(
                  userId: "userId",
                  username: "Michael",
                  postId: "postId",
                  comment:
                      "Great project! I struggled a bit with the roof fitting perfectly, but a little sanding helped."),
            ),
            const SizedBox(
              height: 8,
            ),
            CommentText(
              comment: Comment(
                  userId: "userId",
                  username: "Sarah",
                  postId: "postId",
                  comment:
                      "My kids enjoyed painting the birdhouse after building it. It’s been a fun family project!"),
            ),
          ],
        ),
      ],
    );
  }
}

class CommentTextField extends StatelessWidget {
  const CommentTextField({
    super.key,
    required this.commentController,
  });

  final TextEditingController commentController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Comments',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Spacing
        const SizedBox(height: 10),
        Container(
          //height: 0,
          width: double.infinity,
          decoration: BoxDecoration(
            //color: Colors.white,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Not implemented")),
                );
                // Currently does nothing when pressed
                // You can later implement functionality here
                commentController.clear();
              },
              child: const Text('Comment'),
            ),
          ],
        )
        // Comment Button
      ],
    );
  }
}

class CommentText extends StatelessWidget {
  const CommentText({
    super.key,
    required this.comment,
  });
  final Comment comment;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(
          text: "${comment.username}: ", // Username part
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        TextSpan(
          style: Theme.of(context).textTheme.bodyLarge!,
          text: '"${comment.comment}"', // Comment part
        ),
      ]),
    );
  }
}
