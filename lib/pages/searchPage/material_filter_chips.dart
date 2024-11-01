import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nestify/models/search_model.dart';

class MaterialFilterChips extends StatefulWidget {
  const MaterialFilterChips({super.key});

  @override
  State<MaterialFilterChips> createState() => _MaterialFilterChipsState();
}

class _MaterialFilterChipsState extends State<MaterialFilterChips> {
  late List<String> materials;

  @override
  void initState() {
    materials = ['Wood', 'Plastic', 'Metal', 'Paper', 'Cardboard'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchModel>(builder: (context, model, child) {
      Set<String> selectedMaterials = model.selectedMaterials;
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
