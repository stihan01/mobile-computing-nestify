import 'package:nestify/pages/searchPage/searchPage.dart';
import 'package:flutter/material.dart';

class SearchModel with ChangeNotifier {
  Set<String> selectedCategories = {};
  Set<String> selectedMaterials = {};

  List<String> categories = ['Birdhouse', 'Insect hotel', 'Birdfeeder'];
  List<String> materials = ['Wood', 'Plastic', 'Metal', 'Paper', 'Cardboard'];

//Categories and materials selected by the filterchips in the searchpage
  Set<String> get getSelectedCategories => selectedCategories;
  Set<String> get getSelectedMaterials => selectedMaterials;

  List<String> get getCategories => categories;
  List<String> get getMaterials => materials;

  void reset() {
    selectedCategories = {};
    selectedMaterials = {};
    notifyListeners();
  }
}
