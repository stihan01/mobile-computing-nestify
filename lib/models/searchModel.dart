import 'package:nestify/pages/searchPage/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:nestify/apis/firestore_db.dart';
import 'package:nestify/models/blueprint_post.dart';

class SearchModel with ChangeNotifier {
  Set<String> selectedCategories = {};
  Set<String> selectedMaterials = {};

  List<String> categories = ['Bird house', 'Insect hotel', 'Birdfeeder'];
  List<String> materials = ['Wood', 'Plastic', 'Metal', 'Paper', 'Cardboard'];

  List<BlueprintPost> _blueprintList = [];
  List<BlueprintPost> get blueprintList => _blueprintList;

  List<BlueprintPost> _filteredList = [];
  List<BlueprintPost> get filteredList => _filteredList;

//Categories and materials selected by the filterchips in the searchpage
  Set<String> get getSelectedCategories => selectedCategories;
  Set<String> get getSelectedMaterials => selectedMaterials;

  List<String> get getCategories => categories;
  List<String> get getMaterials => materials;

  SearchModel() {
    _setup();
  }

  _setup() async {
    await fetchBlueprints();
  }

  Future<void> fetchBlueprints() async {
    await FirestoreDb.fetchBlueprints().then((posts) {
      _blueprintList = posts;
    });
    notifyListeners();
  }

  void reset() {
    selectedCategories = {};
    selectedMaterials = {};
    notifyListeners();
  }

  void filterBlueprints() {
    List<BlueprintPost> tempFilteredList = [];
    if (selectedCategories.isNotEmpty) {
      for (BlueprintPost post in _blueprintList) {
        if (selectedCategories.contains(post.category)) {
          tempFilteredList.add(post);
        }
      }
    } else {
      tempFilteredList = _blueprintList;
    }
    _filteredList = tempFilteredList;

    notifyListeners();
  }
}
