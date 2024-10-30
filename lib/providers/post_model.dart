import 'package:flutter/material.dart';
import 'package:nestify/models/blueprint_post.dart';
import 'dart:io';
import 'package:nestify/apis/firestore_db.dart';

class PostModel with ChangeNotifier {
  BlueprintPost _post = BlueprintPost();
  List<File> images = [];
  List<String> _imgUrls = [];
  List<String> markedUrlDeletion = [];
  String? category;
  bool isEdit = false;

  PostModel();

  set post(BlueprintPost? post) {
    markedUrlDeletion = [];
    images = [];
    _imgUrls = [];
    if (post == null) {
//      category = null;
      isEdit = false;
      _post = BlueprintPost();
      return;
    }

    // Else we are editing
    _post = post;
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

  Future<void> updateBlueprint() async {
    await FirestoreDb.updateUserBlueprint(_post);
    notifyListeners();
  }

  void updatePostFields(
      {String? title,
      String? material,
      String? instruction,
      String? category}) {
    _post.title = title;
    _post.material = material;
    _post.instruction = instruction;
    if (!(category == null)) post.category = category;
  }

  Future<void> uploadBlueprint() async {
    // Upload any image
    // Update contents

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
    notifyListeners();
  }
}
