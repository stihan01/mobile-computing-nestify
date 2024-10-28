import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nestify/models/searchModel.dart';
import 'package:provider/provider.dart';

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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 450,
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Filters',
                        style: Theme.of(context).textTheme.titleLarge),
                    TextButton(
                        onPressed: () {
                          var model =
                              Provider.of<SearchModel>(context, listen: false);
                          model.reset();
                        },
                        child: Text("Reset"))
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: _CategoryFilterChips(),
                      ),
                      _MaterialFilterChips(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: FilledButton(
                    onPressed: () {},
                    child: const Text('Apply Filters'),
                  ),
                ),
              ]),
        );
      },
    );
  }
}

List<String> categories = ['Birdhouse', 'Insect hotel', 'Birdfeeder'];

List<String> materials = ['Wood', 'Plastic', 'Metal', 'Paper', 'Cardboard'];
/*
extension CategoryFilterGetter on CategoryFilter {
  String get label {
    switch (this) {
      case CategoryFilter.birdhouse:
        return 'Birdhouse';
      case CategoryFilter.insecthotel:
        return 'Insect Hotel';
    }
  }
}*/

class _CategoryFilterChips extends StatefulWidget {
  const _CategoryFilterChips({super.key});

  @override
  State<_CategoryFilterChips> createState() => _CategoryFilterChipsState();
}

class _CategoryFilterChipsState extends State<_CategoryFilterChips> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchModel>(
      builder: (context, model, child) {
        Set<String> selectedCategories = model.getSelectedCategories;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category:', style: Theme.of(context).textTheme.labelLarge),
            Wrap(
                spacing: 8.0,
                children: categories.map((String category) {
                  return FilterChip(
                    label: Text(category),
                    selected: selectedCategories.contains(category),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          selectedCategories.add(category);
                        } else {
                          selectedCategories.remove(category);
                        }
                      });
                    },
                  );
                }).toList()),
          ],
        );
      },
    );
  }
}

class _MaterialFilterChips extends StatefulWidget {
  const _MaterialFilterChips({super.key});

  @override
  State<_MaterialFilterChips> createState() => _MaterialFilterChipsState();
}

class _MaterialFilterChipsState extends State<_MaterialFilterChips> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchModel>(builder: (context, model, child) {
      Set<String> selectedMaterials = model.getSelectedMaterials;
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Materials:', style: Theme.of(context).textTheme.labelLarge),
          Wrap(
              spacing: 8.0,
              children: materials.map((String material) {
                return FilterChip(
                  label: Text(material),
                  selected: selectedMaterials.contains(material),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedMaterials.add(material);
                      } else {
                        selectedMaterials.remove(material);
                      }
                    });
                  },
                );
              }).toList()),
        ],
      );
    });
  }
}
