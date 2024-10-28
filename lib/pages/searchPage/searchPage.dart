import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nestify/models/searchModel.dart';
import 'package:provider/provider.dart';
import 'package:nestify/pages/searchPage/filterModalBottomsheet.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchpageState();
}

class _SearchpageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchModel>(
      builder: (context, searchModel, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Search Screen')),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Column(
                children: [
                  _SearchBar(),
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

  void show() {
    filterModalBottomsheet(context);
  }
}
