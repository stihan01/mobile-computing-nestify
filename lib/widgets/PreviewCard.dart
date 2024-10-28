import 'package:flutter/material.dart';
import 'package:nestify/models/blueprint_post.dart';

import 'package:go_router/go_router.dart';

class PreviewCard extends StatefulWidget {
  final BlueprintPost post;
  final String placeholderImage = 'assets/images/buzzhotel.jpg';

  const PreviewCard({required this.post, super.key});

  @override
  State<PreviewCard> createState() => _PreviewCardState();
}

class _PreviewCardState extends State<PreviewCard> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> images = widget.post.imageUrls.keys.isEmpty
        ? []
        : widget.post.imageUrls.keys.map((url) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                url,
                fit: BoxFit.fill,
              ),
            );
          }).toList();
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: SizedBox(
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () => context.go('/details', extra: widget.post),
            child: Column(children: [
              images.isEmpty
                  ? Image.asset(
                      widget.placeholderImage,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit
                          .cover, // Optional: to cover the box size proportionally
                    )
                  : images[0],
              SizedBox(
                height: 100,
                width: 350,
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.post.title ?? 'Title',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              widget.post.category ?? 'Category',
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
                                icon: widget.post.isFavorite
                                    ? const Icon(Icons.favorite)
                                    : const Icon(Icons.favorite_outline),
                                onPressed: () {
                                  if (widget.post.isFavorite) {
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
      ),
    );
  }
}
