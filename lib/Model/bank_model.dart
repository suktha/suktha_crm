class BankModel {
  final int? id;
  final String? bankname;
  final String? bankAddress;
  final String? deleted;

  BankModel({
    this.id,
    this.bankname,
    this.bankAddress,
    this.deleted,
  });

  BankModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      bankname = json['bankname'] as String?,
      bankAddress = json['bankAddress'] as String?,
      deleted = json['deleted'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'bankname' : bankname,
    'bankAddress' : bankAddress,
    'deleted' : deleted
  };
}