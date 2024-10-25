import 'package:flutter/material.dart';
import 'package:nestify/models/blueprint_post.dart';
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

  @override
  void initState() {
    super.initState();
    postModel = Provider.of<PostModel>(context, listen: false);
    postModel.post = widget.post;
  }

  @override
  Widget build(BuildContext context) {
    final formContent = [
      Center(
        child: Text(
            postModel.isEdit
                ? "Editing blueprint post"
                : "Upload blueprint post",
            style: Theme.of(context).textTheme.titleLarge),
      ),
      imageGrid(),
      cameraButton(),
      titleFormField(),
      CategoryDropdownMenu(
        category: postModel.post.category,
        onSelected: (category) {
          postModel.post.category = category;
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
                postModel.imgUrls.remove(value);
              });
            },
          ),
        )
        .toList();
    return GridView.count(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        //  padding: const EdgeInsets.all(8),

        shrinkWrap: true,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: 2,
        children: [fromUrl, fromImages].expand((element) => element).toList());
  }

  OutlinedButton saveDraftButton() {
    return OutlinedButton(
      // TODO implement onPressed
      onPressed: () {},
      child: const Text("Save draft"),
    );
  }

  FilledButton publishButton() {
    return FilledButton(
      // TODO implement onPressed
      onPressed: () {
        // Validate returns true if the form is valid, or false otherwise.
        if (_formKey.currentState!.validate()) {
          // If the form is valid, display a snackbar. In the real world,
          // you'd often call a server or save the information in a database.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(postModel.post.toJson().toString()),
            ),
          );
        }
      },
      child: Text(postModel.isEdit ? "Update" : 'Publish'),
    );
  }

  CustomTextFormField titleFormField() {
    return CustomTextFormField(
        initialValue: postModel.isEdit ? postModel.post.title : null,
        onChanged: (value) {
          postModel.post.title = value;
        },
        maxLength: 60,
        label: const Text("Title"),
        hintText: "Title of your creation",
        errorText: "Please enter a title");
  }

  CustomTextFormField materialFormField() {
    return CustomTextFormField(
        initialValue: postModel.isEdit ? postModel.post.material : null,
        onChanged: (value) {
          postModel.post.material = value;
        },
        label: const Text("Material"),
        hintText: "Recommended material",
        errorText: "Please enter materials");
  }

  CustomTextFormField instructionFormField() {
    return CustomTextFormField(
        initialValue: postModel.isEdit ? postModel.post.instruction : null,
        onChanged: (value) {
          postModel.post.instruction = value;
        },
        label: const Text("Instructions"),
        hintText: "Describe how to build your creation",
        errorText: "Please enter instructions");
  }
}
