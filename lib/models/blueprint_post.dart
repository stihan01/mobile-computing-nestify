import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class BlueprintPost {
  String _userId = FirebaseAuth.instance.currentUser == null
      ? ""
      : FirebaseAuth.instance.currentUser!.uid;
  String _id = DateTime.now().millisecondsSinceEpoch.toString();
  String? title;
  String? material;
  String? instruction;
  String? category;
  bool isFavorite = false;
  List<File> images = [];
  List<dynamic>? favoritedBy;

  /// imageUrl : filepath. Filepath is used for deleting in fire storage
  Map<String, dynamic> imageUrls = {};

  BlueprintPost(
      [this.title,
      this.material,
      this.instruction,
      this.category,
      this.isFavorite = false]);

  BlueprintPost.fromJson(Map<String, dynamic> json)
      : _userId = json['user_id'],
        _id = json['post_id'],
        imageUrls = json['imageUrls'] ?? {},
        title = json['title'],
        material = json['material'],
        instruction = json['instruction'],
        category = json['category'],
        favoritedBy = json['favorited'] {
    favoritedBy ??= [];
  }

  Map<String, dynamic> toJson() => {
        'user_id': _userId,
        "post_id": _id,
        'imageUrls': imageUrls,
        "title": title,
        "material": material,
        "instruction": instruction,
        'category': category,
      };

  get id => _id;
  get owner => _userId;
}
