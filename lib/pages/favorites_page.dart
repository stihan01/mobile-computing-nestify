import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nestify/widgets/PreviewCard.dart';
import 'package:provider/provider.dart';
import '../providers/model.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
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
      var posts = model.favorites;
      if (posts.isEmpty) {
        return const Center(child: Text('You do not have any favorites yet'));
      }
      return ListView.builder(
        itemBuilder: (context, index) => PreviewCard(post: posts[index]),
        itemCount: posts.length,
      );
    });
  }
}
