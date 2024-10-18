import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nestify/models/blueprint_post.dart';
import 'package:nestify/widgets/custom_text_form_field.dart';
import 'package:image_picker/image_picker.dart';

class AddBlueprintScreen extends StatelessWidget {
  const AddBlueprintScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(body: BlueprintForm(isEdit: false)),
    );
  }
}

class BlueprintForm extends StatefulWidget {
  const BlueprintForm({super.key, required this.isEdit});

  final bool isEdit;

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
  final BlueprintPost blueprint = BlueprintPost();
  @override
  Widget build(BuildContext context) {
    final formContent = [
      Center(
        child: Text(
            widget.isEdit ? "Editing blueprint post" : "Upload blueprint post",
            style: Theme.of(context).textTheme.titleLarge),
      ),
      GridView.count(
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          //  padding: const EdgeInsets.all(8),

          shrinkWrap: true,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          crossAxisCount: 2,
          children: blueprint.images
              .map(
                (file) => ImageBox(
                  file: file,
                  onDelete: (value) {
                    setState(() {
                      blueprint.images.remove(value);
                    });
                  },
                ),
              )
              .toList()),
      ImageCaptureButton(
        onImageSelected: (xFile) {
          setState(() {
            blueprint.images.add(xFile);
          });
        },
      ),
      titleFormField(),
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
            separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
          )),
    );
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
            const SnackBar(
              content: Text("Processing"),
            ),
          );
        }
      },
      child: const Text('Publish'),
    );
  }

  CustomTextFormField titleFormField() {
    return CustomTextFormField(
        initialValue: widget.isEdit ? blueprint.title : null,
        onChanged: (value) {
          blueprint.title = value;
        },
        maxLength: 60,
        label: const Text("Title"),
        hintText: "Title of your creation",
        errorText: "Please enter a title");
  }

  CustomTextFormField materialFormField() {
    return CustomTextFormField(
        initialValue: widget.isEdit ? blueprint.material : null,
        onChanged: (value) {
          blueprint.material = value;
        },
        label: const Text("Material"),
        hintText: "Recommended material",
        errorText: "Please enter materials");
  }

  CustomTextFormField instructionFormField() {
    return CustomTextFormField(
        initialValue: widget.isEdit ? blueprint.instruction : null,
        onChanged: (value) {
          blueprint.instruction = value;
        },
        label: const Text("Instructions"),
        hintText: "Describe how to build your creation",
        errorText: "Please enter instructions");
  }
}

class ImageBox extends StatelessWidget {
  const ImageBox({super.key, required this.file, required this.onDelete});

  final XFile file;
  final Function(XFile) onDelete;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(border: Border.all()),
        height: 300,
        width: 200,
        child: Image.file(
          File(file.path),
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
          left: 135,
          top: -10,
          child: IconButton(
              onPressed: () {
                onDelete(file);
              },
              color: Colors.red,
              icon: const Icon(Icons.delete)))
    ]);
  }
}

class ImageCaptureButton extends StatelessWidget {
  const ImageCaptureButton({super.key, required this.onImageSelected});

  final Function(XFile) onImageSelected;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: IconButton(
          onPressed: () async {
            await _pickImageFromGallery();
          },
          icon: const Icon(Icons.add_a_photo)),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) {
      return;
    }

    onImageSelected(returnedImage);
  }
}
