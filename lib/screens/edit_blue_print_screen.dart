import 'package:flutter/material.dart';
import 'package:nestify/models/blueprint_post.dart';
import 'package:nestify/providers/edit_post_model.dart';
import 'package:nestify/widgets/blueprint_form/blueprint_form.dart';
import 'package:provider/provider.dart';
import 'package:nestify/models/post_model.dart';

class EditBlueprintScreen extends StatelessWidget {
  const EditBlueprintScreen(
      {super.key, required this.post, required this.onEdit});
  final BlueprintPost post;
  final Function() onEdit;
  @override
  Widget build(BuildContext context) {
    PostModel model = Provider.of<EditPostModel>(context, listen: false);
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
