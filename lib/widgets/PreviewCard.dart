import 'package:flutter/material.dart';

class PreviewCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const PreviewCard(
      {required this.image,
      required this.title,
      required this.description,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            debugPrint('Card tapped.');
          },
          child: Column(children: [
            Container(
              height: 200,
              width: 350,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 100,
              width: 350,
              child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
