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

  List<BlueprintPost> _searchList = [];
  List<BlueprintPost> get searchList => _searchList;

  List<BlueprintPost> _searchBeforeFilterList = [];

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
    _searchList = _blueprintList;
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

  void searchBlueprints(String query) {
    List<BlueprintPost> tempFilteredList = [];
    //if query is not empty -> search though blueprintlist and see what matches the query
    if (query.isNotEmpty) {
      for (BlueprintPost post in _blueprintList) {
        if (post.title != null &&
            post.title!.toLowerCase().contains(query.toLowerCase())) {
          tempFilteredList.add(post);
        }
      }
      //if query is empty -> show all blueprints
    } else {
      tempFilteredList = _blueprintList;
    }

    _searchBeforeFilterList = tempFilteredList;
    _searchList = tempFilteredList;
    //filters blueprints, makes sure that only the selected categories are shown
    filterBlueprints();

    notifyListeners();
  }

  void filterBlueprints() {
    List<BlueprintPost> tempFilteredList = [];
    //if no categories or materials are selected, show all blueprints
    if (selectedCategories.isEmpty && selectedMaterials.isEmpty) {
      _searchList = _searchBeforeFilterList;
      notifyListeners();
      return;
    }
    //if only categories are selected, show only blueprints that have the selected categories
    else if (selectedCategories.isEmpty && selectedMaterials.isNotEmpty) {
      for (BlueprintPost post in _searchBeforeFilterList) {
        if (containsMaterial(post)) {
          tempFilteredList.add(post);
        }
      }
      _searchList = tempFilteredList;
      notifyListeners();
      return;
    }

//if only materials are selected, show only blueprints that have the selected materials
    else if (selectedCategories.isNotEmpty && selectedMaterials.isEmpty) {
      for (BlueprintPost post in _searchBeforeFilterList) {
        if (selectedCategories.contains(post.category)) {
          tempFilteredList.add(post);
        }
      }
      _searchList = tempFilteredList;
      notifyListeners();
      return;
    }
//if both categories and materials are selected, show only blueprints that have the selected categories and materials
    else {
      for (BlueprintPost post in _searchBeforeFilterList) {
        if (selectedCategories.contains(post.category) &&
            containsMaterial(post)) {
          tempFilteredList.add(post);
        }
      }
      _searchList = tempFilteredList;
      notifyListeners();
      return;
    }
  }

  // since the materials in a post is a freetext string, i must check if any of the selected materials are in the string
  bool containsMaterial(BlueprintPost post) {
    for (String filterMaterial in selectedMaterials) {
      if (post.material != null &&
          post.material!.toLowerCase().contains(filterMaterial.toLowerCase())) {
        return true;
      }
    }
    return false;
  }

  int filterNumber() {
    if (selectedCategories.isEmpty && selectedMaterials.isEmpty) {
      return 0;
    }
    return selectedCategories.length + selectedMaterials.length;
  }
}
