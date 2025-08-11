class TaxesModel {
  int? id;
  String? name;
  double? rate;
  String? deleted;
  int? taxTypeId;

  TaxesModel({this.id, this.name, this.rate, this.deleted, this.taxTypeId});

  TaxesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rate = json['rate'];
    deleted = json['deleted'];
    taxTypeId = json['taxTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['rate'] = rate;
    data['deleted'] = deleted;
    data['taxTypeId'] = taxTypeId;
    return data;
  }
}
