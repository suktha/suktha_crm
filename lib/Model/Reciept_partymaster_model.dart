class ReceiptTansactionTypeModel {
  final List<PayableReceivableHeaders>? payableReceivableHeaders;
  final int? totalCount;

  ReceiptTansactionTypeModel({
    this.payableReceivableHeaders,
    this.totalCount,
  });

  ReceiptTansactionTypeModel.fromJson(Map<String, dynamic> json)
      : payableReceivableHeaders = (json['payableReceivableHeaders'] as List?)?.map((dynamic e) => PayableReceivableHeaders.fromJson(e as Map<String, dynamic>)).toList(),
        totalCount = json['totalCount'] as int?;

  Map<String, dynamic> toJson() => {'payableReceivableHeaders': payableReceivableHeaders?.map((e) => e.toJson()).toList(), 'totalCount': totalCount};
}

class PayableReceivableHeaders {
  final String? id;
  final String? payReferenceNumber;
  final int? payReferenceId;
  final String? payReferenceDate;
  final int? partyId;
  final int? paymentMethodId;
  final dynamic cardTypeId;
  final dynamic paymentDocumentNumber;
  final dynamic bankName;
  final dynamic paymentDocumentDate;
  final dynamic paymentNote;
  final String? clearingMode;
  final dynamic paymentStatus;
  final int? statusId;
  final int? financialYearId;
  final int? companyId;
  final int? transactionTypeId;
  final double? paymentAmount;
  final dynamic isPost;
  final String? statusName;
  final String? partyName;
  final List<PayableReceivableItems>? payableReceivableItems;
  final List<String>? creditDebitNumber;
  final List<String>? creditDebitId;
  final String? paymentMode;
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
  final dynamic companySecondaryTelephone;
  final String? companyWebsite;
  final String? companyEmail;
  final dynamic companyFaxNumber;
  final String? companyAddress;
  final dynamic companyTagLine;
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
  final String? partyShipAddress;
  final dynamic partyDueDaysLimit;
  final String? partyGstRegistrationTypeId;
  final dynamic partyGstNumber;
  final String? partyPanNumber;
  final dynamic isIgst;
  final String? partyCode;
  final String? createdBy;
  final String? updateBy;
  final String? createdDate;
  final String? updatedDate;
  final dynamic email;

  PayableReceivableHeaders({
    this.id,
    this.payReferenceNumber,
    this.payReferenceId,
    this.payReferenceDate,
    this.partyId,
    this.paymentMethodId,
    this.cardTypeId,
    this.paymentDocumentNumber,
    this.bankName,
    this.paymentDocumentDate,
    this.paymentNote,
    this.clearingMode,
    this.paymentStatus,
    this.statusId,
    this.financialYearId,
    this.companyId,
    this.transactionTypeId,
    this.paymentAmount,
    this.isPost,
    this.statusName,
    this.partyName,
    this.payableReceivableItems,
    this.creditDebitNumber,
    this.creditDebitId,
    this.paymentMode,
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
  });

  PayableReceivableHeaders.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        payReferenceNumber = json['payReferenceNumber'] as String?,
        payReferenceId = json['payReferenceId'] as int?,
        payReferenceDate = json['payReferenceDate'] as String?,
        partyId = json['partyId'] as int?,
        paymentMethodId = json['paymentMethodId'] as int?,
        cardTypeId = json['cardTypeId'],
        paymentDocumentNumber = json['paymentDocumentNumber'],
        bankName = json['bankName'],
        paymentDocumentDate = json['paymentDocumentDate'],
        paymentNote = json['paymentNote'],
        clearingMode = json['clearingMode'] as String?,
        paymentStatus = json['paymentStatus'],
        statusId = json['statusId'] as int?,
        financialYearId = json['financialYearId'] as int?,
        companyId = json['companyId'] as int?,
        transactionTypeId = json['transactionTypeId'] as int?,
        paymentAmount = json['paymentAmount'] as double?,
        isPost = json['isPost'],
        statusName = json['statusName'] as String?,
        partyName = json['partyName'] as String?,
        payableReceivableItems = (json['payableReceivableItems'] as List?)?.map((dynamic e) => PayableReceivableItems.fromJson(e as Map<String, dynamic>)).toList(),
        creditDebitNumber = (json['creditDebitNumber'] as List?)?.map((dynamic e) => e as String).toList(),
        creditDebitId = (json['creditDebitId'] as List?)?.map((dynamic e) => e as String).toList(),
        paymentMode = json['paymentMode'] as String?,
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
        companySecondaryTelephone = json['companySecondaryTelephone'],
        companyWebsite = json['companyWebsite'] as String?,
        companyEmail = json['companyEmail'] as String?,
        companyFaxNumber = json['companyFaxNumber'],
        companyAddress = json['companyAddress'] as String?,
        companyTagLine = json['companyTagLine'],
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
        partyShipAddress = json['partyShipAddress'] as String?,
        partyDueDaysLimit = json['partyDueDaysLimit'],
        partyGstRegistrationTypeId = json['partyGstRegistrationTypeId'] as String?,
        partyGstNumber = json['partyGstNumber'],
        partyPanNumber = json['partyPanNumber'] as String?,
        isIgst = json['isIgst'],
        partyCode = json['partyCode'] as String?,
        createdBy = json['createdBy'] as String?,
        updateBy = json['updateBy'] as String?,
        createdDate = json['createdDate'] as String?,
        updatedDate = json['updatedDate'] as String?,
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'payReferenceNumber': payReferenceNumber,
        'payReferenceId': payReferenceId,
        'payReferenceDate': payReferenceDate,
        'partyId': partyId,
        'paymentMethodId': paymentMethodId,
        'cardTypeId': cardTypeId,
        'paymentDocumentNumber': paymentDocumentNumber,
        'bankName': bankName,
        'paymentDocumentDate': paymentDocumentDate,
        'paymentNote': paymentNote,
        'clearingMode': clearingMode,
        'paymentStatus': paymentStatus,
        'statusId': statusId,
        'financialYearId': financialYearId,
        'companyId': companyId,
        'transactionTypeId': transactionTypeId,
        'paymentAmount': paymentAmount,
        'isPost': isPost,
        'statusName': statusName,
        'partyName': partyName,
        'payableReceivableItems': payableReceivableItems?.map((e) => e.toJson()).toList(),
        'creditDebitNumber': creditDebitNumber,
        'creditDebitId': creditDebitId,
        'paymentMode': paymentMode,
        'companyName': companyName,
        'companygGstRegistrationTypeId': companygGstRegistrationTypeId,
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
        'email': email
      };
}

class PayableReceivableItems {
  final String? id;
  final String? payableReceivableHeaderId;
  final String? invoiceHeaderId;
  final String? invoiceNumber;
  final String? invoiceDate;
  final dynamic paymentDueDate;
  final double? invoiceAmount;
  final double? paidAmount;
  final double? dueAmount;
  final double? payingAmount;
  final dynamic invoiceStatus;
  final dynamic paymentItemStatus;
  final double? tdsPercentage;
  final double? tdsAmount;
  final double? amountAfterTds;
  final dynamic debitAmount;
  final dynamic creditDebitHeaderId;
  final int? slNo;
  final double? taxableAmount;
  final double? taxAmount;
  final dynamic preTdsPer;
  final dynamic preTdsAmount;
  final double? roundOff;

  PayableReceivableItems({
    this.id,
    this.payableReceivableHeaderId,
    this.invoiceHeaderId,
    this.invoiceNumber,
    this.invoiceDate,
    this.paymentDueDate,
    this.invoiceAmount,
    this.paidAmount,
    this.dueAmount,
    this.payingAmount,
    this.invoiceStatus,
    this.paymentItemStatus,
    this.tdsPercentage,
    this.tdsAmount,
    this.amountAfterTds,
    this.debitAmount,
    this.creditDebitHeaderId,
    this.slNo,
    this.taxableAmount,
    this.taxAmount,
    this.preTdsPer,
    this.preTdsAmount,
    this.roundOff,
  });

  PayableReceivableItems.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        payableReceivableHeaderId = json['payableReceivableHeaderId'] as String?,
        invoiceHeaderId = json['invoiceHeaderId'] as String?,
        invoiceNumber = json['invoiceNumber'] as String?,
        invoiceDate = json['invoiceDate'] as String?,
        paymentDueDate = json['paymentDueDate'],
        invoiceAmount = json['invoiceAmount'] as double?,
        paidAmount = json['paidAmount'] as double?,
        dueAmount = json['dueAmount'] as double?,
        payingAmount = json['payingAmount'] as double?,
        invoiceStatus = json['invoiceStatus'],
        paymentItemStatus = json['paymentItemStatus'],
        tdsPercentage = json['tdsPercentage'] as double?,
        tdsAmount = json['tdsAmount'] as double?,
        amountAfterTds = json['amountAfterTds'] as double?,
        debitAmount = json['debitAmount'],
        creditDebitHeaderId = json['creditDebitHeaderId'],
        slNo = json['slNo'] as int?,
        taxableAmount = json['taxableAmount'] as double?,
        taxAmount = json['taxAmount'] as double?,
        preTdsPer = json['preTdsPer'],
        preTdsAmount = json['preTdsAmount'],
        roundOff = json['roundOff'] as double?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'payableReceivableHeaderId': payableReceivableHeaderId,
        'invoiceHeaderId': invoiceHeaderId,
        'invoiceNumber': invoiceNumber,
        'invoiceDate': invoiceDate,
        'paymentDueDate': paymentDueDate,
        'invoiceAmount': invoiceAmount,
        'paidAmount': paidAmount,
        'dueAmount': dueAmount,
        'payingAmount': payingAmount,
        'invoiceStatus': invoiceStatus,
        'paymentItemStatus': paymentItemStatus,
        'tdsPercentage': tdsPercentage,
        'tdsAmount': tdsAmount,
        'amountAfterTds': amountAfterTds,
        'debitAmount': debitAmount,
        'creditDebitHeaderId': creditDebitHeaderId,
        'slNo': slNo,
        'taxableAmount': taxableAmount,
        'taxAmount': taxAmount,
        'preTdsPer': preTdsPer,
        'preTdsAmount': preTdsAmount,
        'roundOff': roundOff
      };
}
