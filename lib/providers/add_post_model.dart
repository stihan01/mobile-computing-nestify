import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nestify/apis/firestore_db.dart';
import 'package:nestify/models/blueprint_post.dart';
import 'package:nestify/models/post_model.dart';

class AddPostModel extends ChangeNotifier implements PostModel {
  BlueprintPost _post = BlueprintPost();
  @override
  List<File> images = [];
  List<String> _imgUrls = [];
  List<String> markedUrlDeletion = [];
  @override
  String? category;
  final bool _isEdit = false;

  @override
  bool get isEdit => _isEdit;
  AddPostModel();

  @override
  set post(BlueprintPost post) {
    markedUrlDeletion = [];
    images = [];
    _imgUrls = [];

    // category = null;
    _post = post;
  }

  @override
  BlueprintPost get post => _post;
  @override
  List<String> get imgUrls => _imgUrls;
  @override
  void removeImgUrl(String url) {
    _imgUrls.remove(url);
    markedUrlDeletion.add(url);
  }

  @override
  void updatePostFields({
    String? title,
    String? material,
    String? instruction,
  }) {
    debugPrint("Category is: $category");
    _post.title = title;
    _post.material = material;
    _post.instruction = instruction;
    _post.category = category;
  }

  @override
  Future<void> updateBlueprint() async {
    // Upload any image
    // Update contents

    for (File file in images) {
      await FirestoreDb.uploadImage(file, _post.id).then((value) {
        _post.imageUrls.addAll(value);
      });
    }
    images = [];

    // Finally upload blueprint
    await FirestoreDb.uploadBlueprint(_post);
    // reset
    post = BlueprintPost();
    notifyListeners();
  }
}
