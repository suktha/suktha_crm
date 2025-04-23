class StockTraceReportModel {
  final String? id;
  final String? businessDate;
  final String? transactionDate;
  final int? materialId;
  final String? materialName;
  final String? transactionNote;
  final int? transactionTypeId;
  final String? transactionHeaderId;
  final String? transactionNumber;
  final int? partyId;
  final String? partyName;
  final double? quantityIn;
  final double? quantityOut;
  final double? closingStock;
  final String? reverse;
  final String? partyCode;
  final String? materialPartNumber;
  final String? transactionItemId;
  final String? materialMinimumStock;
  final dynamic price;

  StockTraceReportModel({
    this.id,
    this.businessDate,
    this.transactionDate,
    this.materialId,
    this.materialName,
    this.transactionNote,
    this.transactionTypeId,
    this.transactionHeaderId,
    this.transactionNumber,
    this.partyId,
    this.partyName,
    this.quantityIn,
    this.quantityOut,
    this.closingStock,
    this.reverse,
    this.partyCode,
    this.materialPartNumber,
    this.transactionItemId,
    this.materialMinimumStock,
    this.price,
  });

  StockTraceReportModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        businessDate = json['businessDate'] as String?,
        transactionDate = json['transactionDate'] as String?,
        materialId = json['materialId'] as int?,
        materialName = json['materialName'] as String?,
        transactionNote = json['transactionNote'] as String?,
        transactionTypeId = json['transactionTypeId'] as int?,
        transactionHeaderId = json['transactionHeaderId'] as String?,
        transactionNumber = json['transactionNumber'] as String?,
        partyId = json['partyId'] as int?,
        partyName = json['partyName'] as String?,
        quantityIn = json['quantityIn'] as double?,
        quantityOut = json['quantityOut'] as double?,
        closingStock = json['closingStock'] as double?,
        reverse = json['reverse'] as String?,
        partyCode = json['partyCode'] as String?,
        materialPartNumber = json['materialPartNumber'] as String?,
        transactionItemId = json['transactionItemId'] as String?,
        materialMinimumStock = json['materialMinimumStock'] as String?,
        price = json['price'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'businessDate': businessDate,
        'transactionDate': transactionDate,
        'materialId': materialId,
        'materialName': materialName,
        'transactionNote': transactionNote,
        'transactionTypeId': transactionTypeId,
        'transactionHeaderId': transactionHeaderId,
        'transactionNumber': transactionNumber,
        'partyId': partyId,
        'partyName': partyName,
        'quantityIn': quantityIn,
        'quantityOut': quantityOut,
        'closingStock': closingStock,
        'reverse': reverse,
        'partyCode': partyCode,
        'materialPartNumber': materialPartNumber,
        'transactionItemId': transactionItemId,
        'materialMinimumStock': materialMinimumStock,
        'price': price
      };
}
