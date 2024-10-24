import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageBox extends StatelessWidget {
  const ImageBox({super.key, required this.file, required this.onDelete});

  final File file;
  final Function(File) onDelete;

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
