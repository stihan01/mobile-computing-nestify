import 'package:nestify/models/blueprint_post.dart';
import 'dart:io';

abstract class PostModel {
  Future<void> updateBlueprint();

  BlueprintPost get post;
  set post(BlueprintPost post);
  // get category;
  String? category;
  List<File> images = [];

  void removeImgUrl(String url);
  void updatePostFields({
    String? title,
    String? material,
    String? instruction,
  });
  get isEdit;

  get imgUrls;

  /// set category;
}
