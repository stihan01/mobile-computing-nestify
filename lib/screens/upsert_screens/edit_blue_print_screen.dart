import 'package:flutter/material.dart';
import 'package:nestify/models/blueprint_post.dart';
import 'package:nestify/widgets/blueprint_form/blueprint_form.dart';
import 'package:nestify/models/post_model.dart';

class EditBlueprintScreen extends StatelessWidget {
  const EditBlueprintScreen(
      {super.key,
      required this.post,
      required this.onEdit,
      required this.model});
  final BlueprintPost post;
  final PostModel model;
  final Function() onEdit;
  @override
  Widget build(BuildContext context) {
    model.post = post;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Editing blueprint"),
          ),
          body: BlueprintForm(
            onEdit: onEdit,
            postModel: model,
            snackBarMessage: "Blueprint updated",
            //  imgUrls: ,
          )),
    );
  }
}
