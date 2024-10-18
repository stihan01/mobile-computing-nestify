import 'package:flutter/material.dart';
import 'package:nestify/models/blueprint_post.dart';
import 'package:nestify/widgets/custom_text_form_field.dart';

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
      titleFormField(),
      materialFormField(),
      instructionFormField(),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        saveDraftButton(),
        publishButton(),
      ])
    ];

    // Build a Form widget using the _formKey created above.
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32, top: 16),
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
