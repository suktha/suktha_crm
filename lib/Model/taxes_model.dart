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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['rate'] = this.rate;
    data['deleted'] = this.deleted;
    data['taxTypeId'] = this.taxTypeId;
    return data;
  }
}
