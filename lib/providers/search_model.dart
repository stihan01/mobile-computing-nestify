import 'package:flutter/material.dart';
import 'package:nestify/models/blueprint_post.dart';

class SearchModel with ChangeNotifier {
  Set<String> selectedCategories = {};
  Set<String> selectedMaterials = {};
  List<BlueprintPost> blueprintList = [];
  List<BlueprintPost> _searchList = [];
  List<BlueprintPost> _searchBeforeFilterList = [];

  List<BlueprintPost> get searchList {
    List<BlueprintPost> posts = [];

    // Ugly bug fix. Fine for a small amount of users.
    for (BlueprintPost searchPost in _searchList) {
      // Check post id  instad of obj ref
      for (BlueprintPost post in blueprintList) {
        if (searchPost.id == post.id) {
          posts.add(post);
        }
      }
    }

    return posts;
  }

  SearchModel();

  void reset() {
    selectedCategories = {};
    selectedMaterials = {};
    notifyListeners();
  }

  void searchBlueprints(String query) {
    List<BlueprintPost> tempFilteredList = [];
    //if query is not empty -> search though blueprintlist and see what matches the query
    if (query.isNotEmpty) {
      for (BlueprintPost post in blueprintList) {
        if (post.title != null &&
            post.title!.toLowerCase().contains(query.toLowerCase())) {
          tempFilteredList.add(post);
        }
      }
      //if query is empty -> show all blueprints
    } else {
      tempFilteredList = blueprintList;
    }

    _searchBeforeFilterList = tempFilteredList;
    _searchList = tempFilteredList;
    //filters blueprints, makes sure that only the selected categories are shown
    filterBlueprints();
  }

  void filterBlueprints() {
    List<BlueprintPost> tempFilteredList = [];
    //if no categories or materials are selected, show all blueprints
    if (selectedCategories.isEmpty && selectedMaterials.isEmpty) {
      _searchList = _searchBeforeFilterList;
    }
    //if only categories are selected, show only blueprints that have the selected categories
    else if (selectedCategories.isEmpty && selectedMaterials.isNotEmpty) {
      for (BlueprintPost post in _searchBeforeFilterList) {
        if (_containsMaterial(post)) {
          tempFilteredList.add(post);
        }
      }
      _searchList = tempFilteredList;
    }

//if only materials are selected, show only blueprints that have the selected materials
    else if (selectedCategories.isNotEmpty && selectedMaterials.isEmpty) {
      for (BlueprintPost post in _searchBeforeFilterList) {
        if (selectedCategories.contains(post.category)) {
          tempFilteredList.add(post);
        }
      }
      _searchList = tempFilteredList;
    }
//if both categories and materials are selected, show only blueprints that have the selected categories and materials
    else {
      for (BlueprintPost post in _searchBeforeFilterList) {
        if (selectedCategories.contains(post.category) &&
            _containsMaterial(post)) {
          tempFilteredList.add(post);
        }
      }
      _searchList = tempFilteredList;
    }
    notifyListeners();
  }

  // since the materials in a post is a freetext string, i must check if any of the selected materials are in the string
  bool _containsMaterial(BlueprintPost post) {
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
