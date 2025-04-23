class GetCountryModel {
  final int? id;
  final String? name;
  final String? deleted;
  final String? countryCode;

  GetCountryModel({
    this.id,
    this.name,
    this.deleted,
    this.countryCode,
  });

  GetCountryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        deleted = json['deleted'] as String?,
        countryCode = json['countryCode'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'deleted': deleted, 'countryCode': countryCode};
}
