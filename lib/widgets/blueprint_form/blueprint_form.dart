import 'package:flutter/material.dart';
import 'package:nestify/models/blueprint_post.dart';
import 'package:nestify/providers/model.dart';
import 'package:nestify/providers/post_model.dart';
import 'package:nestify/widgets/blueprint_form/widgets/image_box.dart';
import 'package:nestify/widgets/blueprint_form/widgets/image_capture_button.dart';
import 'package:nestify/widgets/custom_text_form_field.dart';
import 'package:nestify/widgets/blueprint_form/widgets/category_dropdown_menu.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class BlueprintForm extends StatefulWidget {
  const BlueprintForm({super.key, this.post});

  // If blueprint object is provided, the form changes to editing, else it creates a new object
  final BlueprintPost? post;

  @override
  BlueprintFormState createState() {
    return BlueprintFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class BlueprintFormState extends State<BlueprintForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  final _formKey = GlobalKey<FormState>();
  late final PostModel postModel;
  late TextEditingController titleTextController;
  late TextEditingController materialTextController;
  late TextEditingController instructionTextController;
  late List<TextEditingController> controllers;

  @override
  void initState() {
    postModel = Provider.of<PostModel>(context, listen: false);
    postModel.post = widget.post;
    // Controllers
    titleTextController = TextEditingController(text: postModel.post.title);
    materialTextController =
        TextEditingController(text: postModel.post.material);
    instructionTextController =
        TextEditingController(text: postModel.post.instruction);

    controllers = [
      titleTextController,
      materialTextController,
      instructionTextController
    ];

    super.initState();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<PostModel>();
    final formContent = [
      imageGrid(),
      cameraButton(),
      titleFormField(),
      CategoryDropdownMenu(
        category: postModel.category,
        onSelected: (category) {
          postModel.category = category;
        },
      ),
      materialFormField(),
      instructionFormField(),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        saveDraftButton(),
        publishButton(),
      ]),
      const SizedBox(height: 20)
    ];

    // Build a Form widget using the _formKey created above.
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 0),
      child: Form(
          key: _formKey,
          child: ListView.separated(
            itemCount: formContent.length,
            itemBuilder: (context, index) {
              return formContent[index];
            },
            // Adds padding between each widget vertically
            separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
          )),
    );
  }

  ImageCaptureButton cameraButton() {
    return ImageCaptureButton(
      onImageSelected: (file) {
        setState(() {
          postModel.images.add(file);
        });
      },
    );
  }

  GridView imageGrid() {
    List<ImageBox> fromImages = postModel.images
        .map(
          (value) => ImageBox(
            image: Image.file(
              File(value.path),
              fit: BoxFit.cover,
            ),
            onDelete: () {
              setState(() {
                postModel.images.remove(value);
              });
            },
          ),
        )
        .toList();

    List<ImageBox> fromUrl = postModel.imgUrls
        .map(
          (value) => ImageBox(
            image: Image.network(
              value,
              fit: BoxFit.cover,
            ),
            onDelete: () {
              setState(() {
                postModel.removeImgUrl(value);
              });
            },
          ),
        )
        .toList();
    return GridView.count(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: 2,
        children: [fromUrl, fromImages].expand((element) => element).toList());
  }

  OutlinedButton saveDraftButton() {
    return OutlinedButton(
      // TODO implement onPressed
      onPressed: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Not implemented")));
      },
      child: const Text("Save draft"),
    );
  }

  FilledButton publishButton() {
    return FilledButton(
      onPressed: () {
        var model = Provider.of<Model>(context, listen: false);
        // Validate returns true if the form is valid, or false otherwise.
        if (_formKey.currentState!.validate()) {
          postModel.updatePostFields(
            title: titleTextController.text,
            material: materialTextController.text,
            instruction: instructionTextController.text,
          );

          if (!postModel.isEdit) {
            for (var controller in controllers) {
              controller.clear();
            }
            postModel.uploadBlueprint();
          } else {
            postModel.updateBlueprint();
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: postModel.isEdit
                  ? const Text("Blueprint updated")
                  : const Text("Blueprint created"),
            ),
          );
          model.fetchBlueprints();

          // Provider.of<Model>(context, listen: false).fetchUsersPosts();
          setState(() {});
        }
      },
      child: Text(postModel.isEdit ? "Update" : 'Publish'),
    );
  }

  CustomTextFormField titleFormField() {
    return CustomTextFormField(
        textController: titleTextController,
        maxLength: 60,
        label: const Text("Title"),
        hintText: "Title of your creation",
        errorText: "Please enter a title");
  }

  CustomTextFormField materialFormField() {
    return CustomTextFormField(
        textController: materialTextController,
        label: const Text("Material"),
        hintText: "Recommended material",
        errorText: "Please enter materials");
  }

  CustomTextFormField instructionFormField() {
    return CustomTextFormField(
        textController: instructionTextController,
        label: const Text("Instructions"),
        hintText: "Describe how to build your creation",
        errorText: "Please enter instructions");
  }
}
