import 'package:suktha_crm/Model/customer_model.dart';

class InputedCustomerModel {
  String? purchaseOrderNumber;
  String? proformaInvoiceNumber;

  String? kindAttention;
  String? quotationSubject;

  String? creditNoteNumber;
  String? creditNoteDate;

  String? inDcNumber;
  String? inDcDate;

  String? grnNumber;
  String? grnDate;

  String? proformaInvoiceDate;
  String? invoiceDate;
  String? invoiceNumber;
  String? purchaseOrderDate;
  String? quotationNumber;
  String? quotationDate;
  String? dcNumber;
  String? customerName;

  String? qualityCheckedBy;
  String? stockCheckedBy;
  String? termsAndCondition;
  String? comments;

  String? dcDate;
  int? isOpenEnded;
  String? purchaseOrderEndDate;
  String? mobileNumber;
  String? email;
  String? internalRefNum;
  String? refDate;
  String? shipToAddress;
  String? remarks;
  String? internalNote;
  CustomerModel? customermodel;

  InputedCustomerModel({
    this.proformaInvoiceNumber,
    this.proformaInvoiceDate,
    this.invoiceNumber,
    this.invoiceDate,
    this.creditNoteDate,
    this.creditNoteNumber,
    this.purchaseOrderNumber,
    this.purchaseOrderDate,
    this.quotationDate,
    this.qualityCheckedBy,
    this.stockCheckedBy,
    this.termsAndCondition,
    this.comments,
    this.grnNumber,
    this.grnDate,
    this.inDcNumber,
    this.inDcDate,
    this.quotationSubject,
    this.kindAttention,
    this.quotationNumber,
    this.dcDate,
    this.isOpenEnded,
    this.customerName,
    this.purchaseOrderEndDate,
    this.dcNumber,
    this.mobileNumber,
    this.email,
    this.internalRefNum,
    this.refDate,
    this.shipToAddress,
    this.remarks,
    this.internalNote,
    this.customermodel,
  });

  InputedCustomerModel.fromJson(Map<String, dynamic> json) {
    proformaInvoiceNumber = json['proformaInvoiceNumber'] as String?;
    proformaInvoiceDate = json['proformaInvoiceDate'] as String?;
    invoiceNumber = json['invoiceNumber'] as String?;
    invoiceDate = json['invoiceDate'] as String?;
    grnDate = json['grnDate'] as String?;
    grnNumber = json['grnNumber'] as String?;
    inDcNumber = json['inDcNumber'] as String?;
    inDcDate = json['inDcDate'] as String?;
    creditNoteDate = json['creditNoteDate'] as String?;
    creditNoteNumber = json['creditNoteNumber'] as String?;
    purchaseOrderNumber = json['purchaseOrderNumber'] as String?;
    purchaseOrderDate = json['purchaseOrderDate'] as String?;
    quotationNumber = json['quotationNumber'] as String?;
    quotationDate = json['quotationDate'] as String?;
    dcNumber = json['dcNumber'] as String?;
    customerName = json['customerName'] as String?;
    dcDate = json['dcDate'] as String?;
    isOpenEnded = json['isOpenEnded'] as int?;
    purchaseOrderEndDate = json['purchaseOrderEndDate'] as String?;
    mobileNumber = json['mobileNumber'] as String?;
    email = json['email'] as String?;
    internalRefNum = json['internalRefNum'] as String?;
    refDate = json['refDate'] as String?;
    shipToAddress = json['shipToAddress'] as String?;

    qualityCheckedBy = json['qualityCheckedBy'] as String?;
    stockCheckedBy = json['stockCheckedBy'] as String?;
    termsAndCondition = json['termsAndCondition'] as String?;
    comments = json['comments'] as String?;
    internalNote = json['internalNote'] as String?;

    customermodel = json['customermodel'] as CustomerModel?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['proformaInvoiceNumber'] = proformaInvoiceNumber;
    json['proformaInvoiceDate'] = proformaInvoiceDate;
    json['invoiceNumber'] = invoiceNumber;
    json['invoiceDate'] = invoiceDate;
    json['creditNoteDate'] = creditNoteDate;
    json['creditNoteNumber'] = creditNoteNumber;
    json['purchaseOrderNumber'] = purchaseOrderNumber;
    json['grnDate'] = grnDate;
    json['grnNumber'] = grnNumber;

    json['purchaseOrderDate'] = purchaseOrderDate;
    json['quotationDate'] = quotationDate;
    json['quotationNumber'] = quotationNumber;
    json['dcDate'] = dcDate;
    json['inDcNumber'] = inDcNumber;
    json['inDcDate'] = inDcDate;
    json['isOpenEnded'] = isOpenEnded;
    json['customerName'] = customerName;
    json['purchaseOrderEndDate'] = purchaseOrderEndDate;
    json['dcNumber'] = dcNumber;
    json['mobileNumber'] = mobileNumber;
    json['email'] = email;
    json['internalRefNum'] = internalRefNum;
    json['refDate'] = refDate;
    json['shipToAddress'] = shipToAddress;
    json['remarks'] = remarks;

    json['qualityCheckedBy'] = qualityCheckedBy;
    json['stockCheckedBy'] = stockCheckedBy;
    json['termsAndCondition'] = termsAndCondition;
    json['comments'] = comments;
    json['internalNote'] = internalNote;

    json['customermodel'] = customermodel;
    return json;
  }
}

class PoInputedCalculationsModel {
  double? discountPercent;
  double? discountAmount;
  double? sumAmount;
  double? cgstTaxAmount;

  double? sgstTaxAmount;
  double? cgstTaxRate;
  double? sgstTaxRate;

  double? igstTaxRate;
  double? igstTaxAmount;

  double? tcsAmount;
  double? tcsPercentage;

  double? totalTaxableAmount;
  double? finalamount;
  double? taxrate;
  int? taxId;

  String? termsAndCondition;

  PoInputedCalculationsModel({
    this.cgstTaxAmount,
    this.cgstTaxRate,
    this.discountAmount,
    this.discountPercent,
    this.finalamount,
    this.sgstTaxAmount,
    this.sgstTaxRate,
    this.igstTaxAmount,
    this.igstTaxRate,
    this.tcsAmount,
    this.tcsPercentage,
    this.sumAmount,
    this.taxrate,
    this.taxId,
    this.totalTaxableAmount,
    this.termsAndCondition,
  });

  PoInputedCalculationsModel.fromJson(Map<String, dynamic> json) {
    discountPercent = json['discountPercent'] as double?;
    discountAmount = json['discountAmount'] as double?;
    cgstTaxAmount = json['cgstTaxAmount'] as double?;
    cgstTaxRate = json['cgstTaxRAte'] as double?;
    sgstTaxAmount = json['sgstTaxAmount'] as double?;
    igstTaxAmount = json['igstTaxAmount'] as double?;
    igstTaxRate = json['igstTaxRate'] as double?;
    sgstTaxRate = json['sgstTaxRate'] as double?;
    tcsAmount = json['tcsAmount'] as double?;
    tcsPercentage = json['tcsPercentage'] as double?;
    totalTaxableAmount = json['totalTaxableAmount'] as double?;
    finalamount = json['finalAmount'] as double?;
    taxrate = json['taxRate'] as double?;
    taxId = json['taxId'] as int?;

    sumAmount = json['sumAmount'] as double?;
    termsAndCondition = json['termsAndCondition'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['discountPercent'] = discountPercent;
    json['discountAmount'] = discountAmount;
    json['cgstTaxAmount'] = cgstTaxAmount;
    json['cgstTaxRAte'] = cgstTaxRate;
    json['sgstTaxAmount'] = sgstTaxAmount;
    json['tcsAmount'] = tcsAmount;
    json['tcsPercentage'] = tcsPercentage;
    json['sgstTaxRate'] = sgstTaxRate;
    json['igstTaxRate'] = igstTaxRate;
    json['igstTaxAmount'] = igstTaxAmount;
    json['totalTaxableAmount'] = totalTaxableAmount;
    json['finalAmount'] = finalamount;
    json['taxRate'] = taxrate;
    json['taxId'] = taxId;

    json['sumAmount'] = sumAmount;
    json['termsAndCondition'] = termsAndCondition;

    return json;
  }
}
