import 'package:flutter/material.dart';
import 'package:nestify/providers/add_post_model.dart';
import 'package:nestify/models/model.dart';
import 'package:nestify/providers/post_model.dart';
import 'package:nestify/widgets/blueprint_form/widgets/image_box.dart';
import 'package:nestify/widgets/blueprint_form/widgets/image_capture_button.dart';
import 'package:nestify/widgets/custom_text_form_field.dart';
import 'package:nestify/widgets/blueprint_form/widgets/category_dropdown_menu.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class BlueprintForm extends StatefulWidget {
  const BlueprintForm({
    super.key,
    this.onEdit,
    required this.postModel,
    required this.snackBarMessage,
    //  required this.gridView,
  });

  // If blueprint object is provided, the form changes to editing, else it creates a new object
  final Function()? onEdit;
  final PostModel postModel;
  final String snackBarMessage;
//  final GridView gridView;
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
  // late final AddPostModel postModel;
  late TextEditingController titleTextController;
  late TextEditingController materialTextController;
  late TextEditingController instructionTextController;
  late List<TextEditingController> controllers;

  @override
  void initState() {
    // Controllers
    titleTextController =
        TextEditingController(text: widget.postModel.post.title);
    materialTextController =
        TextEditingController(text: widget.postModel.post.material);
    instructionTextController =
        TextEditingController(text: widget.postModel.post.instruction);

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
    context.watch<AddPostModel>();
    final formContent = [
      imageGrid(),
      cameraButton(),
      titleFormField(),
      CategoryDropdownMenu(
        category: widget.postModel.category,
        onSelected: (category) {
          widget.postModel.category = category;
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
          widget.postModel.images.add(file);
        });
      },
    );
  }

  GridView imageGrid() {
    List<ImageBox> fromUrl = [];
    List<ImageBox> fromImages = widget.postModel.images
        .map(
          (value) => ImageBox(
            image: Image.file(
              File(value.path),
              fit: BoxFit.cover,
            ),
            onDelete: () {
              setState(() {
                widget.postModel.images.remove(value);
              });
            },
          ),
        )
        .toList();

    for (String url in widget.postModel.imgUrls) {
      fromUrl.add(ImageBox(
        image: Image.network(
          url,
          fit: BoxFit.cover,
        ),
        onDelete: () {
          setState(() {
            widget.postModel.removeImgUrl(url);
          });
        },
      ));
    }

    debugPrint(fromUrl.toString());

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
      onPressed: () async {
        var model = Provider.of<Model>(context, listen: false);
        // Validate returns true if the form is valid, or false otherwise.
        if (_formKey.currentState!.validate()) {
          widget.postModel.updatePostFields(
            title: titleTextController.text,
            material: materialTextController.text,
            instruction: instructionTextController.text,
          );

          if (widget.postModel.isEdit) {
            if (widget.onEdit != null) {
              widget.onEdit!(); // Reload previewCard
              context.pop();
            }
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(widget.snackBarMessage)),
          );
          await widget.postModel.updateBlueprint();

          if (!widget.postModel.isEdit) {
            for (var controller in controllers) {
              controller.clear();
            }
          }

          model.fetchBlueprints();
        }
      },
      child: Text(widget.postModel.isEdit ? "Update" : 'Publish'),
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
