class GetAllBranchesModel {
  final int? id;
  final String? name;
  final dynamic deleted;
  final int? branchAdminId;
  final String? branchAdminName;

  GetAllBranchesModel({
    this.id,
    this.name,
    this.deleted,
    this.branchAdminId,
    this.branchAdminName,
  });

  GetAllBranchesModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        deleted = json['deleted'],
        branchAdminId = json['branchAdminId'] as int?,
        branchAdminName = json['branchAdminName'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'deleted': deleted, 'branchAdminId': branchAdminId, 'branchAdminName': branchAdminName};
}
