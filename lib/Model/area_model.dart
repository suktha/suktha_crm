class AreaModel {
   int? id;
  final String? name;
  final int? cityId;
  final String? deleted;

  AreaModel({
    this.id,
    this.name,
    this.cityId,
    this.deleted,
  });

  AreaModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = json['name'] as String?,
      cityId = json['cityId'] as int?,
      deleted = json['deleted'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'cityId' : cityId,
    'deleted' : deleted
  };
}