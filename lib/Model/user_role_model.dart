class UserRoleModel {
  final int? id;
  final String? role;
  final int? roleTypeId;
  final String? roleTypeName;
  final int? dataVisibility;

  UserRoleModel({
    this.id,
    this.role,
    this.roleTypeId,
    this.roleTypeName,
    this.dataVisibility,
  });

  UserRoleModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        role = json['role'] as String?,
        roleTypeId = json['roleTypeId'] as int?,
        roleTypeName = json['roleTypeName'] as String?,
        dataVisibility = json['dataVisibility'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'role': role,
        'roleTypeId': roleTypeId,
        'roleTypeName': roleTypeName,
        'dataVisibility': dataVisibility,
      };
}
