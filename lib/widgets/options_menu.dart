import 'package:flutter/material.dart';
import 'package:nestify/models/blueprint_post.dart';
import 'package:go_router/go_router.dart';
import 'package:nestify/providers/model.dart';
import 'package:provider/provider.dart';

class OptionsMenu extends StatefulWidget {
  const OptionsMenu(
      {super.key, required this.post, required this.onEdit, this.onDelete});

  final BlueprintPost post;

  /// onEdit just to tell the caller widget to rebuild through a setState
  final Function() onEdit;

  /// if in detailed view, maybe pop the context to go back to previous screen
  final Function()? onDelete;
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
                if (widget.onDelete != null) {
                  widget.onDelete!();
                }
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
