class CountryMasterModel {
  final int? id;
  final String? name;
  final String? deleted;
  final dynamic countryCode;

  CountryMasterModel({
    this.id,
    this.name,
    this.deleted,
    this.countryCode,
  });

  CountryMasterModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        deleted = json['deleted'] as String?,
        countryCode = json['countryCode'];

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'deleted': deleted, 'countryCode': countryCode};
}
