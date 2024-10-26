import 'package:flutter/material.dart';
import 'package:nestify/models/blueprint_post.dart';
import 'dart:io';
import 'package:nestify/apis/firestore_db.dart';

class PostModel with ChangeNotifier {
  bool isEdit = false;
  BlueprintPost _post = BlueprintPost();
  List<File> images = [];
  List<String> _imgUrls = [];
  List<String> markedUrlDeletion = [];

  String? title;
  String? material;
  String? instruction;
  String? category;

  PostModel();

  void _reset() {}

  set post(BlueprintPost? post) {
    debugPrint("Resetting, post: $post");

    markedUrlDeletion = [];
    images = [];
    _imgUrls = [];
    if (post == null) {
      title = null;
      material = null;
      instruction = null;
      category = null;
      isEdit = false;
      _post = BlueprintPost(title, material, instruction, category);
      return;
    }

    // Else we are editing
    _post = post;

    title = _post.title;
    material = _post.material;
    instruction = _post.instruction;
    category = _post.category;
    isEdit = true;
    _imgUrls = _post.imageUrls.keys.toList();
  }

  BlueprintPost get post => _post;
  List<String> get imgUrls => _imgUrls;

  void removeImgUrl(String url) {
    _imgUrls.remove(url);
    markedUrlDeletion.add(url);
  }

  void uploadBlueprint() async {
    // Upload any image
    // Update contents
    _post.title = title;
    _post.material = material;
    _post.instruction = instruction;
    _post.category = category;

    for (File file in images) {
      await FirestoreDb.uploadImage(file, _post.id).then((value) {
        _post.imageUrls.addAll(value);
      });
    }
    images = [];

    // If a url was marked, delete
    for (String key in markedUrlDeletion) {
      String? filePath = _post.imageUrls.remove(key);
      if (filePath != null) {
        try {
          await FirestoreDb.deleteImage(filePath);
        } catch (error) {
          debugPrint("File dont exist: $error");
        }
      }
    }
    // Finally upload blueprint
    await FirestoreDb.uploadBlueprint(_post);
    // reset
    post = null;
    debugPrint("cat1 in model: $category");
    notifyListeners();
  }
}