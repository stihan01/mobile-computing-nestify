import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchpageState();
}

class _SearchpageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Screen')),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Center(
              child: Column(
            children: [
              _SearchBar(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton.icon(
                      onPressed: show,
                      icon: const Icon(Icons.filter_alt),
                      label: const Text('Filter'),
                    ),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.sort),
                      label: const Text('Sort'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Go back to the Home screen'),
              ),
            ],
          ))),
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
          height: 400,
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
                    TextButton(onPressed: () {}, child: Text("Reset"))
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

enum CategoryFilter { birdhouse, insecthotel }

List<String> materials = ['Wood', 'Plastic', 'Metal', 'Paper', 'Cardboard'];

extension CategoryFilterGetter on CategoryFilter {
  String get label {
    switch (this) {
      case CategoryFilter.birdhouse:
        return 'Birdhouse';
      case CategoryFilter.insecthotel:
        return 'Insect Hotel';
    }
  }
}

class _CategoryFilterChips extends StatefulWidget {
  const _CategoryFilterChips({super.key});

  @override
  State<_CategoryFilterChips> createState() => _CategoryFilterChipsState();
}

class _CategoryFilterChipsState extends State<_CategoryFilterChips> {
  Set<CategoryFilter> selectedCategories = {};
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Category:', style: Theme.of(context).textTheme.labelLarge),
        Wrap(
            spacing: 8.0,
            children: CategoryFilter.values.map((CategoryFilter category) {
              return FilterChip(
                label: Text(category.label),
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
  }
}

class _MaterialFilterChips extends StatefulWidget {
  const _MaterialFilterChips({super.key});

  @override
  State<_MaterialFilterChips> createState() => _MaterialFilterChipsState();
}

class _MaterialFilterChipsState extends State<_MaterialFilterChips> {
  Set<String> selectedMaterials = {};
  @override
  Widget build(BuildContext context) {
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
  }
}
