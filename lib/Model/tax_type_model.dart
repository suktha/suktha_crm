class TaxTypeModel {
  final int? id;
  final dynamic createdDateTime;
  final dynamic createdBy;
  final dynamic updatedDateTime;
  final dynamic updatedBy;
  final String? name;
  final String? deleted;

  TaxTypeModel({
    this.id,
    this.createdDateTime,
    this.createdBy,
    this.updatedDateTime,
    this.updatedBy,
    this.name,
    this.deleted,
  });

  TaxTypeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        createdDateTime = json['createdDateTime'],
        createdBy = json['createdBy'],
        updatedDateTime = json['updatedDateTime'],
        updatedBy = json['updatedBy'],
        name = json['name'] as String?,
        deleted = json['deleted'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'createdDateTime': createdDateTime, 'createdBy': createdBy, 'updatedDateTime': updatedDateTime, 'updatedBy': updatedBy, 'name': name, 'deleted': deleted};
}
