class GetServiceExecutionModel {
  final String? deleted;
  final String? name;
  final int? id;

  GetServiceExecutionModel({
    this.deleted,
    this.name,
    this.id,
  });

  GetServiceExecutionModel.fromJson(Map<String, dynamic> json)
      : deleted = json['deleted'] as String?,
        name = json['name'] as String?,
        id = json['id'] as int?;

  Map<String, dynamic> toJson() => {'deleted': deleted, 'name': name, 'id': id};
}
