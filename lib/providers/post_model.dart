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

  set post(BlueprintPost? post) {
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

  Future<void> updateBlueprint() async {
    _updatePostFields();
    await FirestoreDb.updateUserBlueprint(_post);
    notifyListeners();
  }

  void _updatePostFields() {
    _post.title = title;
    _post.material = material;
    _post.instruction = instruction;
    _post.category = category;
  }

  Future<void> uploadBlueprint() async {
    // Upload any image
    // Update contents
    _updatePostFields();

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
