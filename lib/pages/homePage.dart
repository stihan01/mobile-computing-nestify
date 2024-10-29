import 'package:flutter/material.dart';
import 'package:nestify/widgets/PreviewCard.dart';
import 'package:provider/provider.dart';
import '../providers/model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Home Screen')),
        body: Center(
          child: _ItemList(),
        ));
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
      var posts = model.blueprintList;
      if (posts.isEmpty) {
        return const Center(child: Text('No posts available'));
      }
      return ListView.builder(
        itemBuilder: (context, index) => PreviewCard(post: posts[index]),
        itemCount: posts.length,
      );
    });
  }
}
