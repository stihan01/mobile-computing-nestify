import 'package:flutter/material.dart';
import 'package:nestify/models/blueprint_post.dart';
import 'package:go_router/go_router.dart';
import 'package:nestify/widgets/favorite_icon_button.dart';
import 'package:nestify/providers/model.dart';
import 'package:provider/provider.dart';

class PreviewCard extends StatefulWidget {
  final BlueprintPost post;

  const PreviewCard({required this.post, super.key});

  @override
  State<PreviewCard> createState() => _PreviewCardState();
}

class _PreviewCardState extends State<PreviewCard> {
  final String placeholderImage = 'assets/images/buzzhotel.jpg';

  @override
  Widget build(BuildContext context) {
    debugPrint("Rebuilding with: ${widget.post.title}");
    List<dynamic> images = widget.post.imageUrls.keys.isEmpty
        ? []
        : widget.post.imageUrls.keys.map((url) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 400,
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
            onTap: () => context.go(
                '${GoRouterState.of(context).uri.toString()}/details',
                extra: widget.post),
            child: Column(children: [
              images.isEmpty
                  ? Image.asset(
                      placeholderImage,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 500,
                      fit: BoxFit
                          .cover, // Optional: to cover the box size proportionally
                    )
                  : images[0],
              // Text and button
              SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width,
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
                              Provider.of<Model>(context, listen: false)
                                      .isUserPostOwner(widget.post.owner)
                                  ? OptionsMenu(
                                      post: widget.post,
                                      onEdit: () {
                                        setState(() {});
                                      },
                                    )
                                  : FavoriteIconButton(post: widget.post),
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

class OptionsMenu extends StatefulWidget {
  const OptionsMenu({super.key, required this.post, required this.onEdit});

  final BlueprintPost post;
  final Function() onEdit;
  @override
  State<OptionsMenu> createState() => _OptionsMenuState();
}

class _OptionsMenuState extends State<OptionsMenu> {
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Option Button');

  @override
  void dispose() {
    _buttonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Model model = Provider.of<Model>(context, listen: false);
    return MenuAnchor(
      childFocusNode: _buttonFocusNode,
      menuChildren: <Widget>[
        MenuItemButton(
          onPressed: () {
            context.go('${GoRouterState.of(context).uri.toString()}/edit',
                extra: {'post': widget.post, 'onEdit': widget.onEdit});
          },
          child: const Text('Edit'),
        ),
        MenuItemButton(
          onPressed: () async {
            await deletionDialog(context).then(
              (onValue) {
                if (onValue == null || !onValue) {
                  return;
                }
                model.deleteUserPost(widget.post);
              },
            );
          },
          child: const Text('Delete'),
        ),
      ],
      builder: (_, MenuController controller, Widget? child) {
        return IconButton(
          focusNode: _buttonFocusNode,
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.more_vert),
        );
      },
    );
  }

  Future<bool?> deletionDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Delete blueprint: "${widget.post.title}"?',
                  style: Theme.of(context).textTheme.titleLarge!),
              const Text(
                  "The blueprint will be permanently removed from your account."),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text('Close'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
