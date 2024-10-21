import 'package:image_picker/image_picker.dart';

class BlueprintPost {
  String _id = DateTime.now().millisecondsSinceEpoch.toString();
  String? title;
  String? material;
  String? instruction;
  String? category;
  List<XFile> images = [];

  BlueprintPost([this.title, this.material, this.instruction, this.category]);

  BlueprintPost.fromJson(Map<String, dynamic> json)
      : _id = json['post_id'] as String,
        title = json['title'],
        material = json['material'],
        instruction = json['instruction'],
        category = json['category'];

  Map<String, dynamic> toJson() => {
        "post_id": _id,
        "title": title,
        "material": material,
        "instruction": instruction,
        'category': category,
      };

  get id => _id;
}
