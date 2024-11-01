import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nestify/models/search_model.dart';
import 'package:nestify/pages/searchPage/category_filter_chips.dart';
import 'package:nestify/pages/searchPage/material_filter_chips.dart';
import 'package:go_router/go_router.dart';

void filterModalBottomsheet(BuildContext context) {
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
                      child: CategoryFilterChips(),
                    ),
                    MaterialFilterChips(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: FilledButton(
                  onPressed: () {
                    var model =
                        Provider.of<SearchModel>(context, listen: false);
                    model.filterBlueprints();
                    context.pop();
                  },
                  child: const Text('Apply Filters'),
                ),
              ),
            ]),
      );
    },
  );
}
