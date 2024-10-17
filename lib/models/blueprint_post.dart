class BlueprintPost {
  late String _id;
  String? _title;
  String? _description;

  BlueprintPost([this._title, this._description]) {
    _id = DateTime.now().millisecondsSinceEpoch.toString();
  }

  BlueprintPost.fromJson(Map<String, dynamic> json)
      : _id = json['id'] as String,
        _title = json['title'],
        _description = json['description'];

  Map<String, dynamic> toJson() => {
        "id": _id,
        "title": _title,
        "description": _description,
      };

  String? get title => _title;
  String get id => _id;
  String? get description => _description;

  // TODO, update value in DB.
  set title(String? newValue) {
    _title = newValue;
  }

  set description(String? newValue) {
    _description = newValue;
  }
}
