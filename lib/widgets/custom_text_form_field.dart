import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {super.key,
      required this.onChanged,
      required this.errorText,
      this.initialValue,
      this.maxLength,
      this.maxLines,
      this.label,
      this.hintText});

  final Function(String) onChanged;
  final String errorText;
  final String? initialValue;
  final int? maxLength;
  final int? maxLines;
  final Text? label;
  final String? hintText;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      controller: textController,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        label: widget.label,
        hintText: widget.hintText,
      ),
      maxLines: widget.maxLines,
      onChanged: (_) {
        widget.onChanged(textController.text);
      },
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
