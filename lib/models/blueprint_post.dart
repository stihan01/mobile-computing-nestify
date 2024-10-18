import 'package:image_picker/image_picker.dart';

class BlueprintPost {
  late String _id;
  late String title;
  late String material;
  late String instruction;

  List<XFile> images = [];

  BlueprintPost([this.title = "", this.material = "", this.instruction = ""]) {
    _id = DateTime.now().millisecondsSinceEpoch.toString();
  }

  BlueprintPost.fromJson(Map<String, dynamic> json)
      : _id = json['id'] as String,
        title = json['title'],
        material = json['material'],
        instruction = json['instruction'];

  Map<String, dynamic> toJson() => {
        "id": _id,
        "title": title,
        "material": material,
        "instruction": instruction
      };

  get id => _id;
}
