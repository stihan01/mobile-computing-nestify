import 'package:flutter/material.dart';
import 'package:nestify/models/blueprint_post.dart';
import 'package:nestify/models/model.dart';
import 'package:provider/provider.dart';

class FavoriteIconButton extends StatefulWidget {
  const FavoriteIconButton({
    super.key,
    required this.post,
  });

  final BlueprintPost post;

  @override
  State<FavoriteIconButton> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: widget.post.isFavorite
          ? const Icon(Icons.favorite)
          : const Icon(Icons.favorite_outline),
      onPressed: () {
        setState(() {
          widget.post.isFavorite = !widget.post.isFavorite;

          Provider.of<Model>(context, listen: false)
              .updateFavorites(widget.post);
        });
      },
    );
  }
}
