class CityModel {
   int? id;
  final String? name;
  final int? stateId;
  final dynamic areas;
  final String? deleted;

  CityModel({
    this.id,
    this.name,
    this.stateId,
    this.areas,
    this.deleted,
  });

  CityModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = json['name'] as String?,
      stateId = json['stateId'] as int?,
      areas = json['areas'],
      deleted = json['deleted'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'stateId' : stateId,
    'areas' : areas,
    'deleted' : deleted
  };
}