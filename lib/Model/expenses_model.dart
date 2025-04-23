class ExpensesModel {
  final int? id;
  final String? createdDateTime;
  final String? createdBy;
  final String? updatedDateTime;
  final String? updatedBy;
  final String? deleted;
  final String? name;

  ExpensesModel({
    this.id,
    this.createdDateTime,
    this.createdBy,
    this.updatedDateTime,
    this.updatedBy,
    this.deleted,
    this.name,
  });

  ExpensesModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      createdDateTime = json['createdDateTime'] as String?,
      createdBy = json['createdBy'] as String?,
      updatedDateTime = json['updatedDateTime'] as String?,
      updatedBy = json['updatedBy'] as String?,
      deleted = json['deleted'] as String?,
      name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'createdDateTime' : createdDateTime,
    'createdBy' : createdBy,
    'updatedDateTime' : updatedDateTime,
    'updatedBy' : updatedBy,
    'deleted' : deleted,
    'name' : name
  };
}

class ExpenseHeaderModel {
  String? id;
  String? deleted;
  String? name;
  int? companyId;
  int? supplyTypeId;

  ExpenseHeaderModel({
    this.id,
    this.deleted,
    this.name,
     this.companyId,
     this.supplyTypeId,
  });

  // toJson method converts the object into a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'deleted': deleted,
      'name': name,
      'companyId': companyId,
      'supplyTypeId': supplyTypeId,
    };
  }
}
