class StockIncreaseModel {
  final int? id;
  final String? deleted;
  final int? transactionTypeId;
  final String? transactionTypeName;
  final int? partyTypeId;

  StockIncreaseModel({
    this.id,
    this.deleted,
    this.transactionTypeId,
    this.transactionTypeName,
    this.partyTypeId,
  });

  StockIncreaseModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        deleted = json['deleted'] as String?,
        transactionTypeId = json['transactionTypeId'] as int?,
        transactionTypeName = json['transactionTypeName'] as String?,
        partyTypeId = json['partyTypeId'] as int?;

  Map<String, dynamic> toJson() => {'id': id, 'deleted': deleted, 'transactionTypeId': transactionTypeId, 'transactionTypeName': transactionTypeName, 'partyTypeId': partyTypeId};
}
