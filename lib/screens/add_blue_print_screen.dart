import 'package:flutter/material.dart';

class AddBluePrintScreen extends StatelessWidget {
  const AddBluePrintScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String test = "Hello World";
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: Text('text: $test',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            const BluePrintForm()
          ],
        ),
      ),
    );
  }
}

class BluePrintForm extends StatefulWidget {
  const BluePrintForm({super.key});

  @override
  BluePrintFormState createState() {
    return BluePrintFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class BluePrintFormState extends State<BluePrintForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 16),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            // Add TextFormFields and ElevatedButton here.
            CustomTextFormField(),

            ElevatedButton(
              // TODO change in the future
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {super.key, this.onChanged, this.initialValue, this.inputDecoration});

  final Function(String)? onChanged;
  final String? initialValue;
  final InputDecoration? inputDecoration;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final TextEditingController textController = TextEditingController();

  // Dispose to prevent memory leaks
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      // controller: textController,
      decoration: widget.inputDecoration,
      onChanged: (value) {
        debugPrint("Text is: ${value}");
      },
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}
