import 'package:nestify/pages/searchPage/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:nestify/apis/firestore_db.dart';
import 'package:nestify/models/blueprint_post.dart';

class SearchModel with ChangeNotifier {
  Set<String> selectedCategories = {};
  Set<String> selectedMaterials = {};

  List<String> categories = ['Birdhouse', 'Insect hotel', 'Birdfeeder'];
  List<String> materials = ['Wood', 'Plastic', 'Metal', 'Paper', 'Cardboard'];

  List<BlueprintPost> blueprints = [];

//Categories and materials selected by the filterchips in the searchpage
  Set<String> get getSelectedCategories => selectedCategories;
  Set<String> get getSelectedMaterials => selectedMaterials;

  List<String> get getCategories => categories;
  List<String> get getMaterials => materials;

  SearchModel() {
    _setup();
  }

  void _setup() async {
    blueprints = await FirestoreDb.fetchBlueprints();
  }

  void reset() {
    selectedCategories = {};
    selectedMaterials = {};
    notifyListeners();
  }

  List<BlueprintPost> filterBlueprints() {
    notifyListeners();
    return blueprints;
  }
}
