class BlueprintPost {
  late String _id;
  late String _title;
  late String _material;

  late String _instruction;

  BlueprintPost([title = "", material = "", instructions = ""]) {
    _id = DateTime.now().millisecondsSinceEpoch.toString();
    _title = title;
    _material = material;
    _instruction = instructions;
  }

  BlueprintPost.fromJson(Map<String, dynamic> json)
      : _id = json['id'] as String,
        _title = json['title'],
        _material = json['material'];

  Map<String, dynamic> toJson() => {
        "id": _id,
        "title": _title,
        "material": _material,
        "instruction": _instruction
      };

  String get title => _title;
  String get id => _id;
  String get material => _material;
  String get instruction => _instruction;

  // TODO, update value in DB.
  set title(String newValue) {
    _title = newValue;
  }

  set material(String newValue) {
    _material = newValue;
  }

  set instruction(String newValue) {
    _instruction = newValue;
  }
}
