import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nestify/widgets/PreviewCard.dart';
import 'package:provider/provider.dart';
import '../models/model.dart';

class MybuildsPage extends StatelessWidget {
  const MybuildsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Builds"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back icon
          onPressed: () => context.pop(), // Go back
        ),
      ),
      body: _ItemList(),
    );
  }
}

class _ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<_ItemList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Model>(builder: (context, model, child) {
      var posts = model.usersPosts;
      if (posts.isEmpty) {
        return const Center(child: Text('You have not posted any builds yet'));
      }
      return ListView.builder(
        itemBuilder: (context, index) => PreviewCard(post: posts[index]),
        itemCount: posts.length,
      );
    });
  }
}
