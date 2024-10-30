import 'package:flutter/material.dart';

class CategoryDropdownMenu extends StatefulWidget {
  const CategoryDropdownMenu({super.key, this.onSelected, this.category});

  final String? category;
  final Function(String value)? onSelected;
  @override
  State<CategoryDropdownMenu> createState() => _CategoryDropdownMenuState();
}

class _CategoryDropdownMenuState extends State<CategoryDropdownMenu> {
  String? dropdownValue;
  late List<String> categories;

  @override
  void initState() {
    super.initState();
    // TODO fix proper categories
    categories = <String>['Bird house', 'Insect hotel', 'Birdfeeder'];
    dropdownValue = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Changing to: $dropdownValue");
    return DropdownMenu(
      width: MediaQuery.of(context).size.width - 32,
      label: const Text("Category"),
      initialSelection: dropdownValue,
      onSelected: (String? value) {
        widget.onSelected?.call(value!);
        setState(() {
          dropdownValue = value;
        });
      },
      dropdownMenuEntries:
          categories.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry(value: value, label: value);
      }).toList(),
    );
  }
}
