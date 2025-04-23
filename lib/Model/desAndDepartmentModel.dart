class DesDepartmentModel {
  final int? id;
  final String? departmentName;
  final String? deleted;

  DesDepartmentModel({
    this.id,
    this.departmentName,
    this.deleted,
  });

  DesDepartmentModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        departmentName = json['departmentName'] as String?,
        deleted = json['deleted'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'departmentName': departmentName, 'deleted': deleted};
}
