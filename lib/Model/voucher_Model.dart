class VoucherModel {
  final String? id;
  final double? amount;
  final String? voucherNumber;
  final int? voucherId;
  final String? voucherDate;
  final int? voucherTypeId;
  final dynamic comments;
  final String? paidTo;
  final String? chequeNumber;
  final int? companyId;
  final int? financialYearId;
  final dynamic bankName;
  final dynamic chequeDate;
  final List<VoucherItems>? voucherItems;
  final String? companyName;
  final dynamic companygGstRegistrationTypeId;
  final String? companyPinCode;
  final int? companyStateId;
  final String? companyStateName;
  final int? companyCountryId;
  final String? companyPrimaryMobile;
  final String? companySecondaryMobile;
  final String? companyContactPersonNumber;
  final String? companyContactPersonName;
  final String? companyPrimaryTelephone;
  final String? companySecondaryTelephone;
  final String? companyWebsite;
  final String? companyEmail;
  final String? companyFaxNumber;
  final String? companyAddress;
  final dynamic companytagLine;
  final String? companyGstNumber;
  final dynamic compapanNumber;
  final String? companyPanDate;
  final String? companyCeritificateImagePath;
  final String? companyLogoPath;
  final String? createdBy;
  final String? updateBy;
  final String? createdDate;
  final String? updatedDate;

  VoucherModel({
    this.id,
    this.amount,
    this.voucherNumber,
    this.voucherId,
    this.voucherDate,
    this.voucherTypeId,
    this.comments,
    this.paidTo,
    this.chequeNumber,
    this.companyId,
    this.financialYearId,
    this.bankName,
    this.chequeDate,
    this.voucherItems,
    this.companyName,
    this.companygGstRegistrationTypeId,
    this.companyPinCode,
    this.companyStateId,
    this.companyStateName,
    this.companyCountryId,
    this.companyPrimaryMobile,
    this.companySecondaryMobile,
    this.companyContactPersonNumber,
    this.companyContactPersonName,
    this.companyPrimaryTelephone,
    this.companySecondaryTelephone,
    this.companyWebsite,
    this.companyEmail,
    this.companyFaxNumber,
    this.companyAddress,
    this.companytagLine,
    this.companyGstNumber,
    this.compapanNumber,
    this.companyPanDate,
    this.companyCeritificateImagePath,
    this.companyLogoPath,
    this.createdBy,
    this.updateBy,
    this.createdDate,
    this.updatedDate,
  });

  VoucherModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      amount = json['amount'] as double?,
      voucherNumber = json['voucherNumber'] as String?,
      voucherId = json['voucherId'] as int?,
      voucherDate = json['voucherDate'] as String?,
      voucherTypeId = json['voucherTypeId'] as int?,
      comments = json['comments'],
      paidTo = json['paidTo'] as String?,
      chequeNumber = json['chequeNumber'] as String?,
      companyId = json['companyId'] as int?,
      financialYearId = json['financialYearId'] as int?,
      bankName = json['bankName'],
      chequeDate = json['chequeDate'],
      voucherItems = (json['voucherItems'] as List?)?.map((dynamic e) => VoucherItems.fromJson(e as Map<String,dynamic>)).toList(),
      companyName = json['companyName'] as String?,
      companygGstRegistrationTypeId = json['companygGstRegistrationTypeId'],
      companyPinCode = json['companyPinCode'] as String?,
      companyStateId = json['companyStateId'] as int?,
      companyStateName = json['companyStateName'] as String?,
      companyCountryId = json['companyCountryId'] as int?,
      companyPrimaryMobile = json['companyPrimaryMobile'] as String?,
      companySecondaryMobile = json['companySecondaryMobile'] as String?,
      companyContactPersonNumber = json['companyContactPersonNumber'] as String?,
      companyContactPersonName = json['companyContactPersonName'] as String?,
      companyPrimaryTelephone = json['companyPrimaryTelephone'] as String?,
      companySecondaryTelephone = json['companySecondaryTelephone'] as String?,
      companyWebsite = json['companyWebsite'] as String?,
      companyEmail = json['companyEmail'] as String?,
      companyFaxNumber = json['companyFaxNumber'] as String?,
      companyAddress = json['companyAddress'] as String?,
      companytagLine = json['companytagLine'],
      companyGstNumber = json['companyGstNumber'] as String?,
      compapanNumber = json['compapanNumber'],
      companyPanDate = json['companyPanDate'] as String?,
      companyCeritificateImagePath = json['companyCeritificateImagePath'] as String?,
      companyLogoPath = json['companyLogoPath'] as String?,
      createdBy = json['createdBy'] as String?,
      updateBy = json['updateBy'] as String?,
      createdDate = json['createdDate'] as String?,
      updatedDate = json['updatedDate'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'amount' : amount,
    'voucherNumber' : voucherNumber,
    'voucherId' : voucherId,
    'voucherDate' : voucherDate,
    'voucherTypeId' : voucherTypeId,
    'comments' : comments,
    'paidTo' : paidTo,
    'chequeNumber' : chequeNumber,
    'companyId' : companyId,
    'financialYearId' : financialYearId,
    'bankName' : bankName,
    'chequeDate' : chequeDate,
    'voucherItems' : voucherItems?.map((e) => e.toJson()).toList(),
    'companyName' : companyName,
    'companygGstRegistrationTypeId' : companygGstRegistrationTypeId,
    'companyPinCode' : companyPinCode,
    'companyStateId' : companyStateId,
    'companyStateName' : companyStateName,
    'companyCountryId' : companyCountryId,
    'companyPrimaryMobile' : companyPrimaryMobile,
    'companySecondaryMobile' : companySecondaryMobile,
    'companyContactPersonNumber' : companyContactPersonNumber,
    'companyContactPersonName' : companyContactPersonName,
    'companyPrimaryTelephone' : companyPrimaryTelephone,
    'companySecondaryTelephone' : companySecondaryTelephone,
    'companyWebsite' : companyWebsite,
    'companyEmail' : companyEmail,
    'companyFaxNumber' : companyFaxNumber,
    'companyAddress' : companyAddress,
    'companytagLine' : companytagLine,
    'companyGstNumber' : companyGstNumber,
    'compapanNumber' : compapanNumber,
    'companyPanDate' : companyPanDate,
    'companyCeritificateImagePath' : companyCeritificateImagePath,
    'companyLogoPath' : companyLogoPath,
    'createdBy' : createdBy,
    'updateBy' : updateBy,
    'createdDate' : createdDate,
    'updatedDate' : updatedDate
  };
}

class VoucherItems {
   String? id;
   String? voucherHeaderId;
   String? description;
   double? amount;
   int? expenseHeaderId;
   String? expenseName;

  VoucherItems({
    this.id,
    this.voucherHeaderId,
    this.description,
    this.amount,
    this.expenseHeaderId,
    this.expenseName,
  });

  VoucherItems.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      voucherHeaderId = json['voucherHeaderId'] as String?,
      description = json['description'] as String?,
      amount = json['amount'] as double?,
      expenseHeaderId = json['expenseHeaderId'] as int?,
      expenseName = json['expenseName'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'voucherHeaderId' : voucherHeaderId,
    'description' : description,
    'amount' : amount,
    'expenseHeaderId' : expenseHeaderId,
    'expenseName' : expenseName
  };
}