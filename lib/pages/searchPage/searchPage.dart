import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nestify/models/searchModel.dart';
import 'package:nestify/models/model.dart';
import 'package:provider/provider.dart';
import 'package:nestify/pages/searchPage/filterModalBottomsheet.dart';
import 'package:nestify/widgets/PreviewCard.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchpageState();
}

class _SearchpageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<SearchModel, Model>(
      builder: (context, searchModel, model, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Search Screen')),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _SearchBar(),
                  Expanded(child: _SearchResults()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _SearchBar() {
    return SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
      return SearchBar(
        elevation: WidgetStatePropertyAll(2),
        controller: controller,
        padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16.0)),
        onTap: () {
          controller.openView();
        },
        onChanged: (_) {
          controller.openView();
        },
        leading: const Icon(Icons.search),
        trailing: [IconButton(onPressed: show, icon: Icon(Icons.filter_alt))],
      );
    }, suggestionsBuilder: (BuildContext context, SearchController controller) {
      return List<ListTile>.generate(5, (int index) {
        final String item = 'item $index';
        return ListTile(
          title: Text(item),
          onTap: () {
            setState(() {
              controller.closeView(item);
            });
          },
        );
      });
    });
  }

  Widget _SearchResults() {
    return Consumer<Model>(
      builder: (context, model, child) {
        var posts = SearchModel().filterBlueprints();
        if (posts.isEmpty) {
          return Center(child: Text('No posts matches your search'));
        }
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: PreviewCard(post: posts[index]),
          ),
          itemCount: posts.length,
        );
      },
    );
  }

  void show() {
    filterModalBottomsheet(context);
  }
}
