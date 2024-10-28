import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageCaptureButton extends StatelessWidget {
  const ImageCaptureButton({super.key, required this.onImageSelected});

  final Function(File) onImageSelected;
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

    onImageSelected(File(returnedImage.path));
  }
}
