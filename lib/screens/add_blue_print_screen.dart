import 'package:flutter/material.dart';
import 'package:nestify/widgets/blueprint_form/blueprint_form.dart';

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
          body: const BlueprintForm()),
    );
  }
}
