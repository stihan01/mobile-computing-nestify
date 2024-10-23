import 'package:flutter/material.dart';

class PreviewCard extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  final bool favorite = false;

  const PreviewCard(
      {required this.image,
      required this.title,
      required this.description,
      super.key});

  @override
  State<PreviewCard> createState() => _PreviewCardState();
}

class _PreviewCardState extends State<PreviewCard> {
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
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 100,
              width: 350,
              child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            widget.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: widget.favorite
                                  ? const Icon(Icons.favorite)
                                  : const Icon(Icons.favorite_outline),
                              onPressed: () {
                                if (widget.favorite) {
                                  //TODO
                                }
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
