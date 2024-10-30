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
  }

  Future<void> fetchBlueprints() async {
    await FirestoreDb.fetchBlueprints().then((posts) {
      _usersPosts = [];
      _favorites = [];
      for (var post in posts) {
        if (isUserPostOwner(post.owner)) {
          _usersPosts.add(post);
        }
        if (post.isFavorite) _favorites.add(post);
      }
      _blueprintList = posts;
    });

    notifyListeners();
  }

  void updateFavorites(BlueprintPost post) async {
    await FirestoreDb.updateFavoritePosts(post);
    post.isFavorite ? _favorites.add(post) : _favorites.remove(post);
    notifyListeners();
  }

  bool isUserPostOwner(String owner) {
    return FirestoreDb.userID == owner;
  }

  void deleteUserPost(BlueprintPost post) async {
    await FirestoreDb.deleteUserBlueprint(post).then((onValue) {
      debugPrint(onValue.toString());
      if (onValue) {
        _usersPosts.remove(post);
        fetchBlueprints();
      }
    });
    notifyListeners();
  }
}
