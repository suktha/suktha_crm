class MaterialPriceListModel {
  final int? id;
  final int? partyId;
  final String? materialTypeName;
  final String? materialName;
  final dynamic partNumber;
  final int? materialId;
  final dynamic discountPercentage;
  final double? sellingPrice;
  final dynamic comment;
  final String? deleted;
  final double? currentSellingPrice;
  final double? currentBuyingPrice;

  MaterialPriceListModel({
    this.id,
    this.partyId,
    this.materialTypeName,
    this.materialName,
    this.partNumber,
    this.materialId,
    this.discountPercentage,
    this.sellingPrice,
    this.comment,
    this.deleted,
    this.currentSellingPrice,
    this.currentBuyingPrice,
  });

  MaterialPriceListModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      partyId = json['partyId'] as int?,
      materialTypeName = json['materialTypeName'] as String?,
      materialName = json['materialName'] as String?,
      partNumber = json['partNumber'],
      materialId = json['materialId'] as int?,
      discountPercentage = json['discountPercentage'],
      sellingPrice = json['sellingPrice'] as double?,
      comment = json['comment'],
      deleted = json['deleted'] as String?,
      currentSellingPrice = json['currentSellingPrice'] as double?,
      currentBuyingPrice = json['currentBuyingPrice'] as double?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'partyId' : partyId,
    'materialTypeName' : materialTypeName,
    'materialName' : materialName,
    'partNumber' : partNumber,
    'materialId' : materialId,
    'discountPercentage' : discountPercentage,
    'sellingPrice' : sellingPrice,
    'comment' : comment,
    'deleted' : deleted,
    'currentSellingPrice' : currentSellingPrice,
    'currentBuyingPrice' : currentBuyingPrice
  };
}