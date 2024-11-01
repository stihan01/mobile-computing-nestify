import 'package:flutter/material.dart';
import 'package:nestify/models/post_model.dart';
import 'package:nestify/screens/detail_screen/detail_screen.dart';
import 'package:nestify/screens/upsert_screens/edit_blue_print_screen.dart';

EditBlueprintScreen getEditScreen({
  required Map<String, dynamic> map,
  required BuildContext context,
  required PostModel model,
  required GlobalKey<NavigatorState> key,
}) {
  return EditBlueprintScreen(
      post: map['post'], onEdit: map['onEdit'], model: model, key: key);
}

DetailScreen getDetailsScreen({
  required Map<String, dynamic> map,
  required BuildContext context,
  required GlobalKey<NavigatorState> key,
}) {
  return DetailScreen(post: map['post'], onEdit: map['onEdit'], key: key);
}
