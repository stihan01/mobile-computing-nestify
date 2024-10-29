import 'package:flutter/material.dart';
import 'package:nestify/models/blueprint_post.dart';
import 'package:go_router/go_router.dart';
import 'package:nestify/utils/router.dart';
import 'package:nestify/widgets/favorite_icon_button.dart';

class PreviewCard extends StatelessWidget {
  final BlueprintPost post;
  final String placeholderImage = 'assets/images/buzzhotel.jpg';

  const PreviewCard({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> images = post.imageUrls.keys.isEmpty
        ? []
        : post.imageUrls.keys.map((url) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                url,
                fit: BoxFit.fill,
              ),
            );
          }).toList();
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 4, top: 4),
      child: SizedBox(
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () => context.go('${GoRouterState.of(context).uri.toString()}/details', extra: post),
            child: Column(children: [
              images.isEmpty
                  ? Image.asset(
                      placeholderImage,
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
                              post.title ?? 'Title',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              post.category ?? 'Category',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              FavoriteIconButton(post: post),
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
