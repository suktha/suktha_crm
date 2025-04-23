class CardTypeModel {
  final int? id;
  final String? name;
  final String? deleted;

  CardTypeModel({
    this.id,
    this.name,
    this.deleted,
  });

  CardTypeModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = json['name'] as String?,
      deleted = json['deleted'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'deleted' : deleted
  };
}