import 'package:flutter/material.dart';
import 'package:nestify/models/blueprint_post.dart';
import 'package:nestify/models/search_model.dart';
import 'package:nestify/providers/model.dart';
import 'package:provider/provider.dart';
import 'package:nestify/pages/searchPage/filter_modal_bottomsheet.dart';
import 'package:nestify/widgets/PreviewCard.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchpageState();
}

class _SearchpageState extends State<SearchPage> {
  final SearchController controller = SearchController();
  final FocusScopeNode focusNode = FocusScopeNode();

  @override
  Widget build(BuildContext context) {
    List<BlueprintPost> posts =
        context.select((Model model) => model.blueprintList);
    return Consumer<SearchModel>(
      builder: (context, searchModel, child) {
        searchModel.blueprintList = posts;
        return Scaffold(
          appBar: AppBar(title: const Text('Search')),
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: _searchBar(),
                ),
                Expanded(child: _SearchResults()),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _searchBar() {
    var model = Provider.of<SearchModel>(context, listen: false);
    return SearchAnchor(
        searchController: controller,
        builder: (context, controller) {
          return SearchBar(
            elevation: const WidgetStatePropertyAll(2),
            focusNode: focusNode,
            controller: controller,
            onTap: () {
              controller.openView();
            },
            onChanged: (_) {
              controller.openView();
            },
            leading: const Icon(Icons.search),
            trailing: [
              IconButton(
                  onPressed: show,
                  icon: model.filterNumber() == 0
                      ? const Icon(Icons.filter_alt)
                      : Badge(
                          isLabelVisible: true,
                          label: Text(model.filterNumber().toString()),
                          offset: const Offset(8, 8),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          child: const Icon(Icons.filter_alt))),
            ],
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          var model = Provider.of<SearchModel>(context, listen: false);
          model.searchBlueprints(controller.text);
          List<BlueprintPost> suggestions = model.blueprintList;
          return suggestions.map((post) {
            return ListTile(
              title: Text(post.title ?? ''),
              onTap: () {
                searchAndClose(controller, post.title ?? '');
              },
            );
          }).toList();
        },
        viewTrailing: [
          IconButton(
            onPressed: () {
              searchAndClose(controller, controller.text);
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
              onPressed: () {
                controller.clear();
              },
              icon: const Icon(Icons.clear))
        ],
        viewOnSubmitted: (query) {
          searchAndClose(controller, query);
        });
  }

  void searchAndClose(SearchController controller, String text) {
    Provider.of<SearchModel>(context, listen: false).searchBlueprints(text);
    controller.closeView(text);
    FocusScope.of(context).unfocus();
  }

  void show() {
    filterModalBottomsheet(context);
  }
}

class _SearchResults extends StatefulWidget {
  @override
  State<_SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<_SearchResults> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchModel>(
      builder: (context, model, child) {
        var posts = model.searchList;
        if (posts.isEmpty) {
          return const Center(child: Text('No posts matches your search'));
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
}
