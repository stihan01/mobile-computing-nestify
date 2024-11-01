import 'package:flutter/material.dart';
import 'package:nestify/models/blueprint_post.dart';
import 'package:go_router/go_router.dart';
import 'package:nestify/widgets/favorite_icon_button.dart';
import 'package:nestify/providers/model.dart';
import 'package:nestify/widgets/options_menu.dart';
import 'package:provider/provider.dart';

class PreviewCard extends StatefulWidget {
  final BlueprintPost post;

  const PreviewCard({super.key, required this.post});

  @override
  State<PreviewCard> createState() => _PreviewCardState();
}

class _PreviewCardState extends State<PreviewCard> {
  final String placeholderImage = 'assets/images/buzzhotel.jpg';

  @override
  Widget build(BuildContext context) {
    Provider.of<Model>(context);
    List<dynamic> images = [];
    try {
      images = widget.post.imageUrls.keys.isEmpty
          ? []
          : widget.post.imageUrls.keys.map((url) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              );
            }).toList();
    } catch (error) {
      debugPrint("Displaying network image failed: $error");
    }

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 4, top: 4),
      child: SizedBox(
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () => context.go(
                '${GoRouterState.of(context).uri.toString()}/details',
                extra: {'post': widget.post, 'onEdit': () => null}),
            child: Column(children: [
              images.isEmpty
                  ? Image.asset(
                      placeholderImage,
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      fit: BoxFit
                          .cover, // Optional: to cover the box size proportionally
                    )
                  : images[0],
              // Text and button

              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  title: Text(
                    widget.post.title ?? 'Title',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    widget.post.category ?? 'Category',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Provider.of<Model>(context, listen: false)
                          .isUserPostOwner(widget.post.owner)
                      ? OptionsMenu(
                          post: widget.post,
                          onEdit: () {
                            setState(() {});
                          },
                        )
                      : FavoriteIconButton(post: widget.post),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
