class GetServiceCategoryModel {
  final int? id;
  final String? name;
  final String? deleted;
  final int? usedFor;

  GetServiceCategoryModel({
    this.id,
    this.name,
    this.deleted,
    this.usedFor,
  });

  GetServiceCategoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        deleted = json['deleted'] as String?,
        usedFor = json['usedFor'] as int?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'deleted': deleted, 'usedFor': usedFor};
}
