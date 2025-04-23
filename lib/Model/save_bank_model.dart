class SaveBankModel {
  final int? id;
  final int? companyId;
  final int? partyId;
  final int? bankId;
  final String? bankname;
  String? branch;
  String? ifsc;
  String? accountNumber;
  final int? bankAdCode;
  double? openingBalance;
  final String? contactNumber;
  final String? swiftCode;
  final String? deleted;

  SaveBankModel({
    this.id,
    this.companyId,
    this.partyId,
    this.bankId,
    this.bankname,
    this.branch,
    this.ifsc,
    this.accountNumber,
    this.bankAdCode,
    this.openingBalance,
    this.contactNumber,
    this.swiftCode,
    this.deleted,
  });

  SaveBankModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        companyId = json['companyId'] as int?,
        partyId = json['partyId'] as int?,
        bankId = json['bankId'] as int?,
        bankname = json['bankname'] as String?,
        branch = json['branch'] as String?,
        ifsc = json['ifsc'] as String?,
        accountNumber = json['accountNumber'] as String?,
        bankAdCode = json['bankAdCode'] as int?,
        openingBalance = json['openingBalance'] as double?,
        contactNumber = json['contactNumber'] as String?,
        swiftCode = json['swiftCode'] as String?,
        deleted = json['deleted'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'companyId': companyId,
        'partyId': partyId,
        'bankId': bankId,
        'bankname': bankname,
        'branch': branch,
        'ifsc': ifsc,
        'accountNumber': accountNumber,
        'bankAdCode': bankAdCode,
        'openingBalance': openingBalance,
        'contactNumber': contactNumber,
        'swiftCode': swiftCode,
        'deleted': deleted
      };
}
