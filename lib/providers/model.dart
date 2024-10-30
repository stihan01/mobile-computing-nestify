import 'package:flutter/material.dart';
import '../models/blueprint_post.dart';
import 'package:nestify/apis/firestore_db.dart';

class Model extends ChangeNotifier {
  List<BlueprintPost> _blueprintList = [];
  List<BlueprintPost> get blueprintList => _blueprintList;

  final List<BlueprintPost> _favorites = [];
  List<BlueprintPost> get favorites => _favorites;

  List<BlueprintPost> _usersPosts = [];
  List<BlueprintPost> get usersPosts => _usersPosts;

  Model() {
    _setup();
  }

  void _setup() async {
    await fetchBlueprints();
    // await fetchFavorites();
    //  await fetchUsersPosts();
  }

  Future<void> fetchBlueprints() async {
    await FirestoreDb.fetchBlueprints().then((posts) {
      _usersPosts = [];
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
    debugPrint("Update fb: ${post.isFavorite} | length: ${_favorites.length}");
    post.isFavorite ? _favorites.add(post) : _favorites.remove(post);
    notifyListeners();
  }

/* 
  Future<void> fetchFavorites() async {
    await FirestoreDb.getMyFavoriteBlueprints().then((posts) {
      _favorites = posts;
    });
    debugPrint("Getting favs...${_favorites.length}");

    notifyListeners();
  }
*/
/*
  Future<void> fetchUsersPosts() async {
    await FirestoreDb.getCurrentUserBlueprints().then((posts) {
      _usersPosts = posts;
    });
    notifyListeners();
  }
*/
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
