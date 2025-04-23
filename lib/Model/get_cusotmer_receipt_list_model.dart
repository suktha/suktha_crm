import 'package:suktha_crm/Model/payment_method_model.dart';

import 'card-type_model.dart';
import 'customer_model.dart';

class PayReceiveModel {
  String? id;
  String? payReferenceNumber;
  int? payReferenceId;
  String? payReferenceDate;
  int? partyId;
  int? paymentMethodId;
  int? cardTypeId;
  String? paymentDocumentNumber;
  String? bankName;
  String? paymentDocumentDate;
  dynamic paymentNote;
  String? clearingMode;
  dynamic paymentStatus;
  int? statusId;
  int? financialYearId;
  int? companyId;
  int? transactionTypeId;
  double? paymentAmount;
  dynamic isPost;
  String? statusName;
  String? partyName;
  List<PayableReceivableItems>? payableReceivableItems;
  List<String>? creditDebitNumber;
  List<String>? creditDebitId;
  String? paymentMode;
  String? companyName;
  dynamic companygGstRegistrationTypeId;
  dynamic companyPinCode;
  int? companyStateId;
  String? companyStateName;
  int? companyCountryId;
  dynamic companyPrimaryMobile;
  dynamic companySecondaryMobile;
  dynamic companyContactPersonNumber;
  dynamic companyContactPersonName;
  dynamic companyPrimaryTelephone;
  dynamic companySecondaryTelephone;
  dynamic companyWebsite;
  dynamic companyEmail;
  dynamic companyFaxNumber;
  String? companyAddress;
  dynamic companyTagLine;
  String? companyGstNumber;
  dynamic companyPanNumber;
  dynamic companyPanDate;
  dynamic companyCeritificateImagePath;
  dynamic companyLogoPath;
  dynamic partyContactPersonNumber;
  dynamic partyPinCode;
  dynamic partyAreaId;
  dynamic partyCityId;
  int? partyStateId;
  int? partyCountryId;
  dynamic partyPrimaryTelephone;
  dynamic partySecondaryTelephone;
  String? partyPrimaryMobile;
  dynamic partySecondaryMobile;
  String? partyEmail;
  dynamic partyWebsite;
  dynamic partyContactPersonName;
  String? partyBillToAddress;
  String? partyShipAddress;
  dynamic partyDueDaysLimit;
  String? partyGstRegistrationTypeId;
  dynamic partyGstNumber;
  dynamic partyPanNumber;
  dynamic isIgst;
  String? partyCode;
  String? createdBy;
  String? updateBy;
  String? createdDate;
  String? updatedDate;
  String? email;

  PayReceiveModel({
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

  PayReceiveModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        payReferenceNumber = json['payReferenceNumber'] as String?,
        payReferenceId = json['payReferenceId'] as int?,
        payReferenceDate = json['payReferenceDate'] as String?,
        partyId = json['partyId'] as int?,
        paymentMethodId = json['paymentMethodId'] as int?,
        cardTypeId = json['cardTypeId'] as int?,
        paymentDocumentNumber = json['paymentDocumentNumber'] as String?,
        bankName = json['bankName'] as String?,
        paymentDocumentDate = json['paymentDocumentDate'] as String?,
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
        companyPinCode = json['companyPinCode'],
        companyStateId = json['companyStateId'] as int?,
        companyStateName = json['companyStateName'] as String?,
        companyCountryId = json['companyCountryId'] as int?,
        companyPrimaryMobile = json['companyPrimaryMobile'],
        companySecondaryMobile = json['companySecondaryMobile'],
        companyContactPersonNumber = json['companyContactPersonNumber'],
        companyContactPersonName = json['companyContactPersonName'],
        companyPrimaryTelephone = json['companyPrimaryTelephone'],
        companySecondaryTelephone = json['companySecondaryTelephone'],
        companyWebsite = json['companyWebsite'],
        companyEmail = json['companyEmail'],
        companyFaxNumber = json['companyFaxNumber'],
        companyAddress = json['companyAddress'] as String?,
        companyTagLine = json['companyTagLine'],
        companyGstNumber = json['companyGstNumber'] as String?,
        companyPanNumber = json['companyPanNumber'],
        companyPanDate = json['companyPanDate'],
        companyCeritificateImagePath = json['companyCeritificateImagePath'],
        companyLogoPath = json['companyLogoPath'],
        partyContactPersonNumber = json['partyContactPersonNumber'],
        partyPinCode = json['partyPinCode'],
        partyAreaId = json['partyAreaId'],
        partyCityId = json['partyCityId'],
        partyStateId = json['partyStateId'] as int?,
        partyCountryId = json['partyCountryId'] as int?,
        partyPrimaryTelephone = json['partyPrimaryTelephone'],
        partySecondaryTelephone = json['partySecondaryTelephone'],
        partyPrimaryMobile = json['partyPrimaryMobile'] as String?,
        partySecondaryMobile = json['partySecondaryMobile'],
        partyEmail = json['partyEmail'] as String?,
        partyWebsite = json['partyWebsite'],
        partyContactPersonName = json['partyContactPersonName'],
        partyBillToAddress = json['partyBillToAddress'] as String?,
        partyShipAddress = json['partyShipAddress'] as String?,
        partyDueDaysLimit = json['partyDueDaysLimit'],
        partyGstRegistrationTypeId = json['partyGstRegistrationTypeId'] as String?,
        partyGstNumber = json['partyGstNumber'],
        partyPanNumber = json['partyPanNumber'],
        isIgst = json['isIgst'],
        partyCode = json['partyCode'] as String?,
        createdBy = json['createdBy'] as String?,
        updateBy = json['updateBy'] as String?,
        createdDate = json['createdDate'] as String?,
        updatedDate = json['updatedDate'] as String?,
        email = json['email'] as String?;

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
  String? id;
  String? payableReceivableHeaderId;
  String? invoiceHeaderId;
  String? invoiceNumber;
  String? invoiceDate;
  String? paymentDueDate;
  double? invoiceAmount;
  double? paidAmount;
  double? dueAmount;
  double? payingAmount;
  dynamic invoiceStatus;
  dynamic paymentItemStatus;
  double? tdsPercentage;
  double? tdsAmount;
  double? amountAfterTds;
  double? debitAmount;
  dynamic creditDebitHeaderId;
  int? slNo;
  double? taxableAmount;
  double? taxAmount;
  dynamic preTdsPer;
  dynamic preTdsAmount;
  double? roundOff;

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
        paymentDueDate = json['paymentDueDate'] as String?,
        invoiceAmount = json['invoiceAmount'] as double?,
        paidAmount = json['paidAmount'] as double?,
        dueAmount = json['dueAmount'] as double?,
        payingAmount = json['payingAmount'] as double?,
        invoiceStatus = json['invoiceStatus'],
        paymentItemStatus = json['paymentItemStatus'],
        tdsPercentage = json['tdsPercentage'] as double?,
        tdsAmount = json['tdsAmount'] as double?,
        amountAfterTds = json['amountAfterTds'] as double?,
        debitAmount = json['debitAmount'] as double?,
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

class payReceiveInputedModel {
  String? partyName;
  String? payRecDate;
  String? paymentRef;
  String? email;
  CustomerModel? customerModel;
  int? paymentMethodId;
  double? paymentAmount;
  PaymentMethodModel? paymentMode;
  String? paymentDocumentDate;
  String? paymentDocumentNumber;
  CardTypeModel? cardType;
  String? bankName;
  String? paymentNote;
  String? remarks;

  payReceiveInputedModel({
    this.partyName,
    this.payRecDate,
    this.paymentRef,
    this.email,
    this.customerModel,
    this.paymentMethodId,
    this.paymentAmount,
    this.paymentMode,
    this.paymentDocumentDate,
    this.paymentDocumentNumber,
    this.cardType,
    this.bankName,
    this.paymentNote,
    this.remarks,
  });

  payReceiveInputedModel.fromJson(Map<String, dynamic> json) {
    partyName = json['partyName'] as String?;
    payRecDate = json['payRecDate'] as String?;
    paymentRef = json['paymentRef'] as String?;
    email = json['email'] as String?;
    customerModel = json['customerModel'] as CustomerModel?;
    paymentMethodId = json['paymentMethodId'] as int?;
    paymentAmount = json['paymentAmount'] as double?;
    paymentMode = json['paymentMode'] as PaymentMethodModel?;
    paymentDocumentDate = json['paymentDocumentDate'] as String?;
    paymentDocumentNumber = json['paymentDocumentNumber'] as String?;
    cardType = json['cardType'] as CardTypeModel?;
    bankName = json['bankName'] as String?;
    paymentNote = json['paymentNote'] as String?;
    remarks = json['remarks'] as String?;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json['partyName'] = partyName;

    json['payRecDate'] = payRecDate;
    json['paymentRef'] = paymentRef;
    json['email'] = email;
    json['customerModel'] = customerModel;
    json['paymentMethodId'] = paymentMethodId;
    json['paymentAmount'] = paymentAmount;
    json['paymentMode'] = paymentMode;
    json['paymentDocumentDate'] = paymentDocumentDate;
    json['paymentDocumentNumber'] = paymentDocumentNumber;
    json['cardType'] = cardType;
    json['bankName'] = bankName;
    json['paymentNote'] = paymentNote;
    json['remarks'] = remarks;
    json['bankName'] = bankName;
    return json;
  }
}
