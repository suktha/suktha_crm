class LeadDesignationModel {
  final int? id;
  final String? designationName;
  final String? deleted;

  LeadDesignationModel({
    this.id,
    this.designationName,
    this.deleted,
  });

  LeadDesignationModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        designationName = json['designationName'] as String?,
        deleted = json['deleted'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'designationName': designationName, 'deleted': deleted};
}
