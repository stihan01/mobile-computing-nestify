import 'package:flutter/material.dart';
import 'package:nestify/providers/add_post_model.dart';
import 'package:nestify/widgets/blueprint_form/blueprint_form.dart';
import 'package:provider/provider.dart';

class AddBlueprintScreen extends StatelessWidget {
  const AddBlueprintScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Upload blueprint post"),
      ),
      body: BlueprintForm(
        postModel: Provider.of<AddPostModel>(context, listen: false),
        snackBarMessage: "Blueprint created",
      ),
    ));
  }
}
