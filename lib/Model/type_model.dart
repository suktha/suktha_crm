class TypeModel {
  final int? id;
  final String? createdDateTime;
  final String? createdBy;
  final String? updatedDateTime;
  final String? updatedBy;
  final String? deleted;
  final String? name;

  TypeModel({
    this.id,
    this.createdDateTime,
    this.createdBy,
    this.updatedDateTime,
    this.updatedBy,
    this.deleted,
    this.name,
  });

  TypeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        createdDateTime = json['createdDateTime'] as String?,
        createdBy = json['createdBy'] as String?,
        updatedDateTime = json['updatedDateTime'] as String?,
        updatedBy = json['updatedBy'] as String?,
        deleted = json['deleted'] as String?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdDateTime': createdDateTime,
        'createdBy': createdBy,
        'updatedDateTime': updatedDateTime,
        'updatedBy': updatedBy,
        'deleted': deleted,
        'name': name
      };
}
