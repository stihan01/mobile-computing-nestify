import 'dart:io';

class BlueprintPost {
  String _id = DateTime.now().millisecondsSinceEpoch.toString();
  String? title;
  String? material;
  String? instruction;
  String? category;
  List<File> images = [];
  bool isFavorite;

  BlueprintPost(
      [this.title,
      this.material,
      this.instruction,
      this.category,
      this.isFavorite = false]);

  BlueprintPost.fromJson(Map<String, dynamic> json)
      : _id = json['post_id'] as String,
        title = json['title'],
        material = json['material'],
        instruction = json['instruction'],
        category = json['category'],
        isFavorite = json['isFavorite'];

  Map<String, dynamic> toJson() => {
        "post_id": _id,
        "title": title,
        "material": material,
        "instruction": instruction,
        'category': category,
        'isFavorite': isFavorite,
      };

  get id => _id;
}
