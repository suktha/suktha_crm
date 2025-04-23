class TaxTypeGetModel {
  final int? id;
  final String? name;
  final int? rate;
  final String? deleted;
  final int? taxTypeId;

  TaxTypeGetModel({
    this.id,
    this.name,
    this.rate,
    this.deleted,
    this.taxTypeId,
  });

  factory TaxTypeGetModel.fromJson(Map<String, dynamic> json) {
    return TaxTypeGetModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      rate: json['rate'] is double ? (json['rate'] as double).toInt() : json['rate'] as int?,
      deleted: json['deleted'] as String?,
      taxTypeId: json['taxTypeId'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'rate': rate,
        'deleted': deleted,
        'taxTypeId': taxTypeId,
      };
}
