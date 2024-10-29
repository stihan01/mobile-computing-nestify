import 'package:flutter/material.dart';
import '../models/blueprint_post.dart';
import 'package:nestify/apis/firestore_db.dart';

class Model extends ChangeNotifier {
  List<BlueprintPost> _blueprintList = [];
  List<BlueprintPost> get blueprintList => _blueprintList;

  List<BlueprintPost> _favorites = [];
  List<BlueprintPost> get favorites => _favorites;

  List<BlueprintPost> _usersPosts = [];
  List<BlueprintPost> get usersPosts => _usersPosts;

  Model() {
    _setup();
  }

  void _setup() async {
    await fetchBlueprints();
    await fetchFavorites();
    await fetchUsersPosts();
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
    fetchFavorites();
    notifyListeners();
  }

  Future<void> fetchFavorites() async {
    await FirestoreDb.getMyFavoriteBlueprints().then((posts) {
      _favorites = posts;
    });
    notifyListeners();
  }

  Future<void> fetchUsersPosts() async {
    await FirestoreDb.getCurrentUserBlueprints().then((posts) {
      _usersPosts = posts;
    });
    notifyListeners();
  }
}
