import 'package:flutter/material.dart';
import 'package:nestify/models/blueprint_post.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:nestify/apis/firestore_db.dart';

class PostModel with ChangeNotifier {
  bool isEdit = false;
  BlueprintPost _post = BlueprintPost();
  List<File> images = [];
  List<String> _imgUrls = [];
  List<String> markedUrlDeletion = [];

  set post(BlueprintPost? post) {
    markedUrlDeletion = [];
    images = [];
    _imgUrls = [];
    if (post == null) {
      isEdit = false;
      _post = BlueprintPost();
      return;
    }

    // Else we are editing
    isEdit = true;
    _post = post;
    _imgUrls = _post.imageUrls.keys.toList();
  }

  BlueprintPost get post => _post;
  List<String> get imgUrls => _imgUrls;

  void removeImgUrl(String url) {
    _imgUrls.remove(url);
    markedUrlDeletion.add(url);
  }
}
