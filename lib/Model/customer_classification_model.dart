class CustomerClassificationModel {
  final int? id;
  final String? name;
  final String? deleted;
  final dynamic dueDaysLimit;
  final dynamic creditLimit;

  CustomerClassificationModel({
    this.id,
    this.name,
    this.deleted,
    this.dueDaysLimit,
    this.creditLimit,
  });

  CustomerClassificationModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = json['name'] as String?,
      deleted = json['deleted'] as String?,
      dueDaysLimit = json['dueDaysLimit'],
      creditLimit = json['creditLimit'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'deleted' : deleted,
    'dueDaysLimit' : dueDaysLimit,
    'creditLimit' : creditLimit
  };
}