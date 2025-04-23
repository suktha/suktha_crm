class CurrencyModel {
  final int? id;
  final String? currencyName;
  final String? deleted;
  final String? shortName;
  final String? currencySymbol;
  final String? currencyFraction;
  final String? currencyDecimal;

  CurrencyModel({
    this.id,
    this.currencyName,
    this.deleted,
    this.shortName,
    this.currencySymbol,
    this.currencyFraction,
    this.currencyDecimal,
  });

  CurrencyModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      currencyName = json['currencyName'] as String?,
      deleted = json['deleted'] as String?,
      shortName = json['shortName'] as String?,
      currencySymbol = json['currencySymbol'] as String?,
      currencyFraction = json['currencyFraction'] as String?,
      currencyDecimal = json['currencyDecimal'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'currencyName' : currencyName,
    'deleted' : deleted,
    'shortName' : shortName,
    'currencySymbol' : currencySymbol,
    'currencyFraction' : currencyFraction,
    'currencyDecimal' : currencyDecimal
  };
}