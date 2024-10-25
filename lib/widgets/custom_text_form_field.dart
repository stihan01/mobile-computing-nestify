import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {super.key,
      required this.errorText,
      required this.textController,
      this.maxLength,
      this.maxLines,
      this.label,
      this.hintText});

  final TextEditingController textController;
  final String errorText;
  final int? maxLength;
  final int? maxLines;
  final Text? label;
  final String? hintText;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        label: widget.label,
        hintText: widget.hintText,
      ),
      maxLines: widget.maxLines,

      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.errorText;
        }
        return null;
      },
    );
  }
}
