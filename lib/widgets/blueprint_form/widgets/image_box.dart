import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  const ImageBox({super.key, required this.image, required this.onDelete});

  final Image image;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(border: Border.all()),
        height: 300,
        width: 200,
        child: image,
      ),
      Positioned(
          left: 135,
          top: -10,
          child: IconButton(
              onPressed: () {
                onDelete();
              },
              color: Colors.red,
              icon: const Icon(Icons.delete)))
    ]);
  }
}
