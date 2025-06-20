
class MaterialPriceListDTOList {
  final int? id;
  final int? partyId;
  final String? materialTypeName;
  final String? materialName;
  final dynamic partNumber;
  final int? materialId;
  final dynamic discountPercentage;
  double? sellingPrice;
  String? comment;
  final String? deleted;
  final dynamic currentSellingPrice;
  final dynamic currentBuyingPrice;

  MaterialPriceListDTOList({
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

  MaterialPriceListDTOList.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        partyId = json['partyId'] as int?,
        materialTypeName = json['materialTypeName'] as String?,
        materialName = json['materialName'] as String?,
        partNumber = json['partNumber'],
        materialId = json['materialId'] as int?,
        discountPercentage = json['discountPercentage'],
        sellingPrice = json['sellingPrice'] as double?,
        comment = json['comment'] as String?,
        deleted = json['deleted'] as String?,
        currentSellingPrice = json['currentSellingPrice'],
        currentBuyingPrice = json['currentBuyingPrice'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'partyId': partyId,
        'materialTypeName': materialTypeName,
        'materialName': materialName,
        'partNumber': partNumber,
        'materialId': materialId,
        'discountPercentage': discountPercentage,
        'sellingPrice': sellingPrice,
        'comment': comment,
        'deleted': deleted,
        'currentSellingPrice': currentSellingPrice,
        'currentBuyingPrice': currentBuyingPrice
      };
}
