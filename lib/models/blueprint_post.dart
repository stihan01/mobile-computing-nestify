import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class BlueprintPost {
  String _userId = FirebaseAuth.instance.currentUser!.uid;
  String _id = DateTime.now().millisecondsSinceEpoch.toString();
  String? title;
  String? material;
  String? instruction;
  String? category;
  List<File> images = [];

  /// imageUrl : filepath. Filepath is used for deleting in fire storage
  Map<String, String> imageUrls = {};
  bool isFavorite;

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
        isFavorite = json['isFavorite'];

  Map<String, dynamic> toJson() => {
        'user_id': _userId,
        "post_id": _id,
        'imagesUrls': imageUrls,
        "title": title,
        "material": material,
        "instruction": instruction,
        'category': category,
        'isFavorite': isFavorite,
      };

  get id => _id;
}
