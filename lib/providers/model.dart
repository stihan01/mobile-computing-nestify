import 'package:flutter/material.dart';
import '../models/blueprint_post.dart';
import 'package:nestify/apis/firestore_db.dart';

class Model extends ChangeNotifier {
  List<BlueprintPost> _blueprintList = [];
  List<BlueprintPost> get blueprintList => _blueprintList;

  final List<BlueprintPost> _favorites = [];
  List<BlueprintPost> get favorites => _favorites;

  Model() {
    _setup();
  }

  void _setup() async {
    await fetchBlueprints();
  }

  Future<void> fetchBlueprints() async {
    await FirestoreDb.fetchBlueprints().then((posts) {
      _blueprintList = posts;
    });

    debugPrint("Fetchign");
    notifyListeners();
  }

  void addFavorite(BlueprintPost post) {
    _favorites.add(post);
    notifyListeners();
  }

  void updateFavorites(BlueprintPost post) async {
    await FirestoreDb.updateFavoritePosts(post);
  }
}
