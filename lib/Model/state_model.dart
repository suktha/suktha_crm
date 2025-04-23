class StateModel {
   int? id;
  final String? name;
  final String? stateCode;
  final int? countryId;
  final String? deleted;
  final int? typeStateId;

  StateModel({
    this.id,
    this.name,
    this.stateCode,
    this.countryId,
    this.deleted,
    this.typeStateId,
  });

  StateModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = json['name'] as String?,
      stateCode = json['stateCode'] as String?,
      countryId = json['countryId'] as int?,
      deleted = json['deleted'] as String?,
      typeStateId = json['typeStateId'] as int?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'stateCode' : stateCode,
    'countryId' : countryId,
    'deleted' : deleted,
    'typeStateId' : typeStateId
  };
}