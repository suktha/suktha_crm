class PartyPriceListModel {
  final int? id;
  final double? partyPrice;
  final String? comments;
  final String? partyName;
  final int? materialId;
  final String? materialName;
  final double? currentPrice;
  final String? partNumber;
  final String? materialTypeName;

  PartyPriceListModel({
    this.id,
    this.partyPrice,
    this.comments,
    this.partyName,
    this.materialId,
    this.materialName,
    this.currentPrice,
    this.partNumber,
    this.materialTypeName,
  });

  PartyPriceListModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      partyPrice = json['partyPrice'] as double?,
      comments = json['comments'] as String?,
      partyName = json['partyName'] as String?,
      materialId = json['materialId'] as int?,
      materialName = json['materialName'] as String?,
      currentPrice = json['currentPrice'] as double?,
      partNumber = json['partNumber'] as String?,
      materialTypeName = json['materialTypeName'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'partyPrice' : partyPrice,
    'comments' : comments,
    'partyName' : partyName,
    'materialId' : materialId,
    'materialName' : materialName,
    'currentPrice' : currentPrice,
    'partNumber' : partNumber,
    'materialTypeName' : materialTypeName
  };
}