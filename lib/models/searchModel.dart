import 'package:nestify/pages/searchPage.dart';
import 'package:flutter/material.dart';

class SearchModel with ChangeNotifier {
  Set<String> selectedCategories = {};
  Set<String> selectedMaterials = {};

  Set<String> get getSelectedCategories => selectedCategories;
  Set<String> get getSelectedMaterials => selectedMaterials;

  void reset() {
    selectedCategories = {};
    selectedMaterials = {};
    notifyListeners();
  }
}
