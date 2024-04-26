class Categories {
  int? id;
  String? code;
  String? name;
  String? description;
  String? status;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;

  Categories(
      {this.id,
      this.code,
      this.name,
      this.description,
      this.status,
      this.type,
      this.createdAt,
      this.updatedAt});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'] ?? "";
    status = json['status'];
    type = json['type'];
    // createdAt = DateTime.parse(json['created_at']);
    // updatedAt = DateTime.parse(json['updatedAt']);
  }

  Categories.fromJsonAlt(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['description'] = description;
    data['status'] = status;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
