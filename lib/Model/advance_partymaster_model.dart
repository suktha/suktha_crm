class AdvanceTypePartymaterModel {
  final List<AdvanceReciepts>? advanceReciepts;
  final int? totalCount;

  AdvanceTypePartymaterModel({
    this.advanceReciepts,
    this.totalCount,
  });

  AdvanceTypePartymaterModel.fromJson(Map<String, dynamic> json)
      : advanceReciepts = (json['advanceReciepts'] as List?)?.map((dynamic e) => AdvanceReciepts.fromJson(e as Map<String, dynamic>)).toList(),
        totalCount = json['totalCount'] as int?;

  Map<String, dynamic> toJson() => {'advanceReciepts': advanceReciepts?.map((e) => e.toJson()).toList(), 'totalCount': totalCount};
}

class AdvanceReciepts {
  final String? id;
  final String? advanceReceiptNumber;
  final int? advanceReceiptId;
  final String? advanceReceiptDate;
  final double? advanceAmount;
  final int? paymentMethodId;
  final dynamic paymentMethodName;
  final String? paymentDate;
  final dynamic paymentMemo;
  final dynamic bankCharges;
  final dynamic bankId;
  final dynamic totalAdvanceAmount;
  final dynamic advanceAmountUsed;
  final double? totalBalanceAdvanceAmount;
  final dynamic amountAfterBankCharges;
  final int? partyId;
  final int? statusId;
  final String? gstNumber;
  final int? financialYearId;
  final int? companyId;
  final int? transactionTypeId;
  final String? partyName;
  final String? companyName;
  final int? companyGstRegistrationTypeId;
  final String? companyPinCode;
  final int? companyStateId;
  final String? companyStateName;
  final int? companyCountryId;
  final String? companyPrimaryMobile;
  final String? companySecondaryMobile;
  final dynamic companyContactPersonNumber;
  final dynamic companyContactPersonName;
  final dynamic companyPrimaryTelephone;
  final dynamic companySecondaryTelephone;
  final String? companyWebsite;
  final String? companyEmail;
  final String? companyFaxNumber;
  final String? companyAddress;
  final String? companyTagLine;
  final String? companyGstNumber;
  final dynamic companyPanNumber;
  final dynamic companyPanDate;
  final String? companyCeritificateImagePath;
  final String? companyLogoPath;
  final String? partyContactPersonNumber;
  final String? partyPinCode;
  final dynamic partyAreaId;
  final int? partyCityId;
  final int? partyStateId;
  final int? partyCountryId;
  final String? partyPrimaryTelephone;
  final String? partySecondaryTelephone;
  final String? partyPrimaryMobile;
  final String? partySecondaryMobile;
  final dynamic partyEmail;
  final String? partyWebsite;
  final String? partyContactPersonName;
  final String? partyBillToAddress;
  final dynamic partyShipAddress;
  final dynamic partyDueDaysLimit;
  final int? partyGstRegistrationTypeId;
  final dynamic partyGstNumber;
  final String? partyPanNumber;
  final dynamic isIgst;
  final String? partyCode;
  final String? createdBy;
  final String? updateBy;
  final String? createdDate;
  final String? updatedDate;
  final dynamic email;
  final String? statusName;
  final String? deleted;
  final dynamic remarks;

  AdvanceReciepts({
    this.id,
    this.advanceReceiptNumber,
    this.advanceReceiptId,
    this.advanceReceiptDate,
    this.advanceAmount,
    this.paymentMethodId,
    this.paymentMethodName,
    this.paymentDate,
    this.paymentMemo,
    this.bankCharges,
    this.bankId,
    this.totalAdvanceAmount,
    this.advanceAmountUsed,
    this.totalBalanceAdvanceAmount,
    this.amountAfterBankCharges,
    this.partyId,
    this.statusId,
    this.gstNumber,
    this.financialYearId,
    this.companyId,
    this.transactionTypeId,
    this.partyName,
    this.companyName,
    this.companyGstRegistrationTypeId,
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
    this.companyTagLine,
    this.companyGstNumber,
    this.companyPanNumber,
    this.companyPanDate,
    this.companyCeritificateImagePath,
    this.companyLogoPath,
    this.partyContactPersonNumber,
    this.partyPinCode,
    this.partyAreaId,
    this.partyCityId,
    this.partyStateId,
    this.partyCountryId,
    this.partyPrimaryTelephone,
    this.partySecondaryTelephone,
    this.partyPrimaryMobile,
    this.partySecondaryMobile,
    this.partyEmail,
    this.partyWebsite,
    this.partyContactPersonName,
    this.partyBillToAddress,
    this.partyShipAddress,
    this.partyDueDaysLimit,
    this.partyGstRegistrationTypeId,
    this.partyGstNumber,
    this.partyPanNumber,
    this.isIgst,
    this.partyCode,
    this.createdBy,
    this.updateBy,
    this.createdDate,
    this.updatedDate,
    this.email,
    this.statusName,
    this.deleted,
    this.remarks,
  });

  AdvanceReciepts.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        advanceReceiptNumber = json['advanceReceiptNumber'] as String?,
        advanceReceiptId = json['advanceReceiptId'] as int?,
        advanceReceiptDate = json['advanceReceiptDate'] as String?,
        advanceAmount = json['advanceAmount'] as double?,
        paymentMethodId = json['paymentMethodId'] as int?,
        paymentMethodName = json['paymentMethodName'],
        paymentDate = json['paymentDate'] as String?,
        paymentMemo = json['paymentMemo'],
        bankCharges = json['bankCharges'],
        bankId = json['bankId'],
        totalAdvanceAmount = json['totalAdvanceAmount'],
        advanceAmountUsed = json['advanceAmountUsed'],
        totalBalanceAdvanceAmount = json['totalBalanceAdvanceAmount'] as double?,
        amountAfterBankCharges = json['amountAfterBankCharges'],
        partyId = json['partyId'] as int?,
        statusId = json['statusId'] as int?,
        gstNumber = json['gstNumber'] as String?,
        financialYearId = json['financialYearId'] as int?,
        companyId = json['companyId'] as int?,
        transactionTypeId = json['transactionTypeId'] as int?,
        partyName = json['partyName'] as String?,
        companyName = json['companyName'] as String?,
        companyGstRegistrationTypeId = json['companyGstRegistrationTypeId'] as int?,
        companyPinCode = json['companyPinCode'] as String?,
        companyStateId = json['companyStateId'] as int?,
        companyStateName = json['companyStateName'] as String?,
        companyCountryId = json['companyCountryId'] as int?,
        companyPrimaryMobile = json['companyPrimaryMobile'] as String?,
        companySecondaryMobile = json['companySecondaryMobile'] as String?,
        companyContactPersonNumber = json['companyContactPersonNumber'],
        companyContactPersonName = json['companyContactPersonName'],
        companyPrimaryTelephone = json['companyPrimaryTelephone'],
        companySecondaryTelephone = json['companySecondaryTelephone'],
        companyWebsite = json['companyWebsite'] as String?,
        companyEmail = json['companyEmail'] as String?,
        companyFaxNumber = json['companyFaxNumber'] as String?,
        companyAddress = json['companyAddress'] as String?,
        companyTagLine = json['companyTagLine'] as String?,
        companyGstNumber = json['companyGstNumber'] as String?,
        companyPanNumber = json['companyPanNumber'],
        companyPanDate = json['companyPanDate'],
        companyCeritificateImagePath = json['companyCeritificateImagePath'] as String?,
        companyLogoPath = json['companyLogoPath'] as String?,
        partyContactPersonNumber = json['partyContactPersonNumber'] as String?,
        partyPinCode = json['partyPinCode'] as String?,
        partyAreaId = json['partyAreaId'],
        partyCityId = json['partyCityId'] as int?,
        partyStateId = json['partyStateId'] as int?,
        partyCountryId = json['partyCountryId'] as int?,
        partyPrimaryTelephone = json['partyPrimaryTelephone'] as String?,
        partySecondaryTelephone = json['partySecondaryTelephone'] as String?,
        partyPrimaryMobile = json['partyPrimaryMobile'] as String?,
        partySecondaryMobile = json['partySecondaryMobile'] as String?,
        partyEmail = json['partyEmail'],
        partyWebsite = json['partyWebsite'] as String?,
        partyContactPersonName = json['partyContactPersonName'] as String?,
        partyBillToAddress = json['partyBillToAddress'] as String?,
        partyShipAddress = json['partyShipAddress'],
        partyDueDaysLimit = json['partyDueDaysLimit'],
        partyGstRegistrationTypeId = json['partyGstRegistrationTypeId'] as int?,
        partyGstNumber = json['partyGstNumber'],
        partyPanNumber = json['partyPanNumber'] as String?,
        isIgst = json['isIgst'],
        partyCode = json['partyCode'] as String?,
        createdBy = json['createdBy'] as String?,
        updateBy = json['updateBy'] as String?,
        createdDate = json['createdDate'] as String?,
        updatedDate = json['updatedDate'] as String?,
        email = json['email'],
        statusName = json['statusName'] as String?,
        deleted = json['deleted'] as String?,
        remarks = json['remarks'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'advanceReceiptNumber': advanceReceiptNumber,
        'advanceReceiptId': advanceReceiptId,
        'advanceReceiptDate': advanceReceiptDate,
        'advanceAmount': advanceAmount,
        'paymentMethodId': paymentMethodId,
        'paymentMethodName': paymentMethodName,
        'paymentDate': paymentDate,
        'paymentMemo': paymentMemo,
        'bankCharges': bankCharges,
        'bankId': bankId,
        'totalAdvanceAmount': totalAdvanceAmount,
        'advanceAmountUsed': advanceAmountUsed,
        'totalBalanceAdvanceAmount': totalBalanceAdvanceAmount,
        'amountAfterBankCharges': amountAfterBankCharges,
        'partyId': partyId,
        'statusId': statusId,
        'gstNumber': gstNumber,
        'financialYearId': financialYearId,
        'companyId': companyId,
        'transactionTypeId': transactionTypeId,
        'partyName': partyName,
        'companyName': companyName,
        'companyGstRegistrationTypeId': companyGstRegistrationTypeId,
        'companyPinCode': companyPinCode,
        'companyStateId': companyStateId,
        'companyStateName': companyStateName,
        'companyCountryId': companyCountryId,
        'companyPrimaryMobile': companyPrimaryMobile,
        'companySecondaryMobile': companySecondaryMobile,
        'companyContactPersonNumber': companyContactPersonNumber,
        'companyContactPersonName': companyContactPersonName,
        'companyPrimaryTelephone': companyPrimaryTelephone,
        'companySecondaryTelephone': companySecondaryTelephone,
        'companyWebsite': companyWebsite,
        'companyEmail': companyEmail,
        'companyFaxNumber': companyFaxNumber,
        'companyAddress': companyAddress,
        'companyTagLine': companyTagLine,
        'companyGstNumber': companyGstNumber,
        'companyPanNumber': companyPanNumber,
        'companyPanDate': companyPanDate,
        'companyCeritificateImagePath': companyCeritificateImagePath,
        'companyLogoPath': companyLogoPath,
        'partyContactPersonNumber': partyContactPersonNumber,
        'partyPinCode': partyPinCode,
        'partyAreaId': partyAreaId,
        'partyCityId': partyCityId,
        'partyStateId': partyStateId,
        'partyCountryId': partyCountryId,
        'partyPrimaryTelephone': partyPrimaryTelephone,
        'partySecondaryTelephone': partySecondaryTelephone,
        'partyPrimaryMobile': partyPrimaryMobile,
        'partySecondaryMobile': partySecondaryMobile,
        'partyEmail': partyEmail,
        'partyWebsite': partyWebsite,
        'partyContactPersonName': partyContactPersonName,
        'partyBillToAddress': partyBillToAddress,
        'partyShipAddress': partyShipAddress,
        'partyDueDaysLimit': partyDueDaysLimit,
        'partyGstRegistrationTypeId': partyGstRegistrationTypeId,
        'partyGstNumber': partyGstNumber,
        'partyPanNumber': partyPanNumber,
        'isIgst': isIgst,
        'partyCode': partyCode,
        'createdBy': createdBy,
        'updateBy': updateBy,
        'createdDate': createdDate,
        'updatedDate': updatedDate,
        'email': email,
        'statusName': statusName,
        'deleted': deleted,
        'remarks': remarks
      };
}
