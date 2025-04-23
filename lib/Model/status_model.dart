class StatusModel {
  int? id;
  final String? name;
  final String? deleted;
  final int? transactionTypeId;
  final String? transactionTypeName;

  StatusModel({
    this.id,
    this.name,
    this.deleted,
    this.transactionTypeId,
    this.transactionTypeName,
  });

  StatusModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        deleted = json['deleted'] as String?,
        transactionTypeId = json['transactionTypeId'] as int?,
        transactionTypeName = json['transactionTypeName'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'deleted': deleted, 'transactionTypeId': transactionTypeId, 'transactionTypeName': transactionTypeName};
}
