import 'package:image_picker/image_picker.dart';

class BlueprintPost {
  late String _id;
  late String? title;
  late String? material;
  late String? instruction;
  late String? category;
  List<XFile> images = [];

  BlueprintPost([this.title, this.material, this.instruction, this.category]) {
    _id = DateTime.now().millisecondsSinceEpoch.toString();
  }

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
