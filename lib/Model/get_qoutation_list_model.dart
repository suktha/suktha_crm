class GetQuotationListModel {

  String? id;
  double? amount;
  String? quotationNumber;
  int? quotationId;
  String? quotationDate;
  String? enquiryNumber;
  dynamic enquiryDate;
  int? partyId;
  double? subTotalAmount;
  double? totalDiscount;
  double? discountPercent;
  double? totalTaxableAmount;
  int? taxId;
  dynamic roundOffAmount;
  double? grandTotal;
  int? statusId;
  int? financialYearId;
  int? companyId;
  dynamic paymentTerms;
  dynamic deliveryTerms;
  dynamic termsAndConditions;
  double? taxAmount;
  String? kindAttention;
  String? quotationSubject;
  dynamic quotationStatus;
  dynamic isPaymentChecked;
  double? sgstTaxRate;
  double? sgstTaxAmount;
  double? cgstTaxRate;
  double? cgstTaxAmount;
  dynamic igstTaxRate;
  dynamic igstTaxAmount;
  int? quotationTypeId;
  List<QuotationItems>? quotationItems;  
  String? statusName;
  String? partyName;
  String? address;
  String? gstNumber;
  dynamic shipToAddress;
  String? remarks;
  int? inclusiveTax;
  String? companyName;
  int? companygGstRegistrationTypeId;
  String? companyPinCode;
  int? companyStateId;
  String? companyStateName;
  int? companyCountryId;
  String? companyPrimaryMobile;
  String? companySecondaryMobile;
  String? companyContactPersonNumber;
  String? companyContactPersonName;
  String? companyPrimaryTelephone;
  String? companySecondaryTelephone;
  String? companyWebsite;
  String? companyEmail;
  String? companyFaxNumber;
  String? companyAddress;
  String? companyTagLine;
  String? companyGstNumber;
  String? companyPanNumber;
  dynamic companyPanDate;
  dynamic companyCeritificateImagePath;
  String? companyLogoPath;
  dynamic partyContactPersonNumber;
  dynamic partyPinCode;
  dynamic partyAreaId;
  dynamic partyCityId;
  int? partyStateId;
  int? partyCountryId;
  int? partyCurrencyId;
  dynamic partyPrimaryTelephone;
  dynamic partySecondaryTelephone;
  String? partyPrimaryMobile;
  dynamic partySecondaryMobile;
  String? partyEmail;
  dynamic partyWebsite;
  dynamic partyContactPersonName;
  dynamic partyBillToAddress;
  dynamic partyShipAddress;
  dynamic partyDueDaysLimit;
  String? partyGstRegistrationTypeId;
  dynamic partyGstNumber;
  dynamic partyPanNumber;
  String? isIgst;
  String? partyCode;
  String? createdBy;
  String? updateBy;
  String? createdDate;
  String? updatedDate;
  dynamic currencyName;
  String? email; 
  String? internalNote; 
  int? isSubscriptionBasedService;

  GetQuotationListModel(
      {this.id,
      this.amount,
      this.quotationNumber,
      this.quotationId,
      this.quotationDate,
      this.enquiryNumber,
      this.enquiryDate,
      this.partyId,
      this.subTotalAmount,
      this.totalDiscount,
      this.discountPercent,
      this.totalTaxableAmount,
      this.taxId,
      this.roundOffAmount,
      this.grandTotal,
      this.statusId,
      this.financialYearId,
      this.companyId,
      this.paymentTerms,
      this.deliveryTerms,
      this.termsAndConditions,
      this.taxAmount,
      this.kindAttention,
      this.quotationSubject,
      this.quotationStatus,
      this.isPaymentChecked,
      this.sgstTaxRate,
      this.sgstTaxAmount,
      this.cgstTaxRate,
      this.cgstTaxAmount,
      this.igstTaxRate,
      this.igstTaxAmount,
      this.quotationTypeId,
      this.quotationItems,
      this.statusName,
      this.partyName,
      this.address,
      this.gstNumber,
      this.shipToAddress,
      this.remarks,
      this.inclusiveTax,
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
      this.partyCurrencyId,
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
      this.currencyName,
      this.internalNote,
      this.email,
      this.isSubscriptionBasedService
      });

  GetQuotationListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    quotationNumber = json['quotationNumber'];
    quotationId = json['quotationId'];
    quotationDate = json['quotationDate'];
    enquiryNumber = json['enquiryNumber'];
    enquiryDate = json['enquiryDate'];
    partyId = json['partyId'];
    subTotalAmount = json['subTotalAmount'];
    totalDiscount = json['totalDiscount'];
    discountPercent = json['discountPercent'];
    totalTaxableAmount = json['totalTaxableAmount'];
    taxId = json['taxId'];
    roundOffAmount = json['roundOffAmount'];
    grandTotal = json['grandTotal'];
    statusId = json['statusId'];
    financialYearId = json['financialYearId'];
    companyId = json['companyId'];
    paymentTerms = json['paymentTerms'];
    deliveryTerms = json['deliveryTerms'];
    termsAndConditions = json['termsAndConditions'];
    taxAmount = json['taxAmount'];
    kindAttention = json['kindAttention'];
    quotationSubject = json['quotationSubject'];
    quotationStatus = json['quotationStatus'];
    isPaymentChecked = json['isPaymentChecked'];
    sgstTaxRate = json['sgstTaxRate'];
    sgstTaxAmount = json['sgstTaxAmount'];
    cgstTaxRate = json['cgstTaxRate'];
    cgstTaxAmount = json['cgstTaxAmount'];
    igstTaxRate = json['igstTaxRate'];
    igstTaxAmount = json['igstTaxAmount'];
    quotationTypeId = json['quotationTypeId'];
    if (json['quotationItems'] != null) {
      quotationItems = <QuotationItems>[];
      json['quotationItems'].forEach((v) {
        quotationItems!.add(QuotationItems.fromJson(v));
      });
    }
    statusName = json['statusName'];
    partyName = json['partyName'];
    address = json['address'];
    gstNumber = json['gstNumber'];
    shipToAddress = json['shipToAddress'];
    remarks = json['remarks'];
    inclusiveTax = json['inclusiveTax'];
    companyName = json['companyName'];
    companygGstRegistrationTypeId = json['companygGstRegistrationTypeId'];
    companyPinCode = json['companyPinCode'];
    companyStateId = json['companyStateId'];
    companyStateName = json['companyStateName'];
    companyCountryId = json['companyCountryId'];
    companyPrimaryMobile = json['companyPrimaryMobile'];
    companySecondaryMobile = json['companySecondaryMobile'];
    companyContactPersonNumber = json['companyContactPersonNumber'];
    companyContactPersonName = json['companyContactPersonName'];
    companyPrimaryTelephone = json['companyPrimaryTelephone'];
    companySecondaryTelephone = json['companySecondaryTelephone'];
    companyWebsite = json['companyWebsite'];
    companyEmail = json['companyEmail'];
    companyFaxNumber = json['companyFaxNumber'];
    companyAddress = json['companyAddress'];
    companyTagLine = json['companyTagLine'];
    companyGstNumber = json['companyGstNumber'];
    companyPanNumber = json['companyPanNumber'];
    companyPanDate = json['companyPanDate'];
    companyCeritificateImagePath = json['companyCeritificateImagePath'];
    companyLogoPath = json['companyLogoPath'];
    partyContactPersonNumber = json['partyContactPersonNumber'];
    partyPinCode = json['partyPinCode'];
    partyAreaId = json['partyAreaId'];
    partyCityId = json['partyCityId'];
    partyStateId = json['partyStateId'];
    partyCountryId = json['partyCountryId'];
    partyCurrencyId = json['partyCurrencyId'];
    partyPrimaryTelephone = json['partyPrimaryTelephone'];
    partySecondaryTelephone = json['partySecondaryTelephone'];
    partyPrimaryMobile = json['partyPrimaryMobile'];
    partySecondaryMobile = json['partySecondaryMobile'];
    partyEmail = json['partyEmail'];
    partyWebsite = json['partyWebsite'];
    partyContactPersonName = json['partyContactPersonName'];
    partyBillToAddress = json['partyBillToAddress'];
    partyShipAddress = json['partyShipAddress'];
    partyDueDaysLimit = json['partyDueDaysLimit'];
    partyGstRegistrationTypeId = json['partyGstRegistrationTypeId'];
    partyGstNumber = json['partyGstNumber'];
    partyPanNumber = json['partyPanNumber'];
    isIgst = json['isIgst'];
    partyCode = json['partyCode'];
    createdBy = json['createdBy'];
    updateBy = json['updateBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    currencyName = json['currencyName'];
    internalNote = json['internalNote'];
    email = json['email'];
    isSubscriptionBasedService = json['isSubscriptionBasedService'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['quotationNumber'] = quotationNumber;
    data['quotationId'] = quotationId;
    data['quotationDate'] = quotationDate;
    data['enquiryNumber'] = enquiryNumber;
    data['enquiryDate'] = enquiryDate;
    data['partyId'] = partyId;
    data['subTotalAmount'] = subTotalAmount;
    data['totalDiscount'] = totalDiscount;
    data['discountPercent'] = discountPercent;
    data['totalTaxableAmount'] = totalTaxableAmount;
    data['taxId'] = taxId;
    data['roundOffAmount'] = roundOffAmount;
    data['grandTotal'] = grandTotal;
    data['statusId'] = statusId;
    data['financialYearId'] = financialYearId;
    data['companyId'] = companyId;
    data['paymentTerms'] = paymentTerms;
    data['deliveryTerms'] = deliveryTerms;
    data['termsAndConditions'] = termsAndConditions;
    data['taxAmount'] = taxAmount;
    data['kindAttention'] = kindAttention;
    data['quotationSubject'] = quotationSubject;
    data['quotationStatus'] = quotationStatus;
    data['isPaymentChecked'] = isPaymentChecked;
    data['sgstTaxRate'] = sgstTaxRate;
    data['sgstTaxAmount'] = sgstTaxAmount;
    data['cgstTaxRate'] = cgstTaxRate;
    data['cgstTaxAmount'] = cgstTaxAmount;
    data['igstTaxRate'] = igstTaxRate;
    data['igstTaxAmount'] = igstTaxAmount;
    data['quotationTypeId'] = quotationTypeId;
    if (quotationItems != null) {
      data['quotationItems'] =
          quotationItems!.map((v) => v.toJson()).toList();
    }
    data['statusName'] = statusName;
    data['partyName'] = partyName;
    data['address'] = address;
    data['gstNumber'] = gstNumber;
    data['shipToAddress'] = shipToAddress;
    data['remarks'] = remarks;
    data['inclusiveTax'] = inclusiveTax;
    data['companyName'] = companyName;
    data['companygGstRegistrationTypeId'] = companygGstRegistrationTypeId;
    data['companyPinCode'] = companyPinCode;
    data['companyStateId'] = companyStateId;
    data['companyStateName'] = companyStateName;
    data['companyCountryId'] = companyCountryId;
    data['companyPrimaryMobile'] = companyPrimaryMobile;
    data['companySecondaryMobile'] = companySecondaryMobile;
    data['companyContactPersonNumber'] = companyContactPersonNumber;
    data['companyContactPersonName'] = companyContactPersonName;
    data['companyPrimaryTelephone'] = companyPrimaryTelephone;
    data['companySecondaryTelephone'] = companySecondaryTelephone;
    data['companyWebsite'] = companyWebsite;
    data['companyEmail'] = companyEmail;
    data['companyFaxNumber'] = companyFaxNumber;
    data['companyAddress'] = companyAddress;
    data['companyTagLine'] = companyTagLine;
    data['companyGstNumber'] = companyGstNumber;
    data['companyPanNumber'] = companyPanNumber;
    data['companyPanDate'] = companyPanDate;
    data['companyCeritificateImagePath'] = companyCeritificateImagePath;
    data['companyLogoPath'] = companyLogoPath;
    data['partyContactPersonNumber'] = partyContactPersonNumber;
    data['partyPinCode'] = partyPinCode;
    data['partyAreaId'] = partyAreaId;
    data['partyCityId'] = partyCityId;
    data['partyStateId'] = partyStateId;
    data['partyCountryId'] = partyCountryId;
    data['partyCurrencyId'] = partyCurrencyId;
    data['partyPrimaryTelephone'] = partyPrimaryTelephone;
    data['partySecondaryTelephone'] = partySecondaryTelephone;
    data['partyPrimaryMobile'] = partyPrimaryMobile;
    data['partySecondaryMobile'] = partySecondaryMobile;
    data['partyEmail'] = partyEmail;
    data['partyWebsite'] = partyWebsite;
    data['partyContactPersonName'] = partyContactPersonName;
    data['partyBillToAddress'] = partyBillToAddress;
    data['partyShipAddress'] = partyShipAddress;
    data['partyDueDaysLimit'] = partyDueDaysLimit;
    data['partyGstRegistrationTypeId'] = partyGstRegistrationTypeId;
    data['partyGstNumber'] = partyGstNumber;
    data['partyPanNumber'] = partyPanNumber;
    data['isIgst'] = isIgst;
    data['partyCode'] = partyCode;
    data['createdBy'] = createdBy;
    data['updateBy'] = updateBy;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['currencyName'] = currencyName;
    data['email'] = email;
    data['internalNote'] = internalNote;
    data['isSubscriptionBasedService'] = isSubscriptionBasedService;
    return data;
  }

}

class QuotationItems {

  String? id;
  String? quotationHeaderId;
  int? materialId;
  int? slNo;
  double? quantity;
  double? price;
  double? amount;
  dynamic status;
  double? taxPercentage;
  dynamic taxAmount;
  double? amountAfterTax;
  double? discountPercentage;
  double? discountAmount;
  double? amountAfterDiscount;
  int? unitOfMeasurementId;
  dynamic taxId;
  int? inclusiveTax;
  double? taxRate;
  String? remarks;
  double? sgstTaxPercentage;
  double? sgstTaxAmount;
  double? cgstTaxPercentage;
  double? cgstTaxAmount;
  dynamic igstTaxPercentage;
  dynamic igstTaxAmount;
  dynamic partNumber;
  dynamic hsnOrSac;
  String? partName;
  String? uom;
  String? specification;
  int? serviceFrequencyCount;

  QuotationItems(
      {this.id,
      this.quotationHeaderId,
      this.materialId,
      this.slNo,
      this.quantity,
      this.price,
      this.amount,
      this.status,
      this.taxPercentage,
      this.taxAmount,
      this.amountAfterTax,
      this.discountPercentage,
      this.discountAmount,
      this.amountAfterDiscount,
      this.unitOfMeasurementId,
      this.taxId,
      this.inclusiveTax,
      this.taxRate,
      this.remarks,
      this.sgstTaxPercentage,
      this.sgstTaxAmount,
      this.cgstTaxPercentage,
      this.cgstTaxAmount,
      this.igstTaxPercentage,
      this.igstTaxAmount,
      this.partNumber,
      this.hsnOrSac,
      this.partName,
      this.uom,
      this.specification,
      this.serviceFrequencyCount
      
      });

  QuotationItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quotationHeaderId = json['quotationHeaderId'];
    materialId = json['materialId'];
    slNo = json['slNo'];
    quantity = json['quantity'];
    price = json['price'];
    amount = json['amount'];
    status = json['status'];
    taxPercentage = json['taxPercentage'];
    taxAmount = json['taxAmount'];
    amountAfterTax = json['amountAfterTax'];
    discountPercentage = json['discountPercentage'];
    discountAmount = json['discountAmount'];
    amountAfterDiscount = json['amountAfterDiscount'];
    unitOfMeasurementId = json['unitOfMeasurementId'];
    taxId = json['taxId'];
    inclusiveTax = json['inclusiveTax'];
    taxRate = json['taxRate'];
    remarks = json['remarks'];
    sgstTaxPercentage = json['sgstTaxPercentage'];
    sgstTaxAmount = json['sgstTaxAmount'];
    cgstTaxPercentage = json['cgstTaxPercentage'];
    cgstTaxAmount = json['cgstTaxAmount'];
    igstTaxPercentage = json['igstTaxPercentage'];
    igstTaxAmount = json['igstTaxAmount'];
    partNumber = json['partNumber'];
    hsnOrSac = json['hsnOrSac'];
    partName = json['partName'];
    uom = json['uom'];
    specification = json['specification'];
    serviceFrequencyCount = json['serviceFrequencyCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quotationHeaderId'] = quotationHeaderId;
    data['materialId'] = materialId;
    data['slNo'] = slNo;
    data['quantity'] = quantity;
    data['price'] = price;
    data['amount'] = amount;
    data['status'] = status;
    data['taxPercentage'] = taxPercentage;
    data['taxAmount'] = taxAmount;
    data['amountAfterTax'] = amountAfterTax;
    data['discountPercentage'] = discountPercentage;
    data['discountAmount'] = discountAmount;
    data['amountAfterDiscount'] = amountAfterDiscount;
    data['unitOfMeasurementId'] = unitOfMeasurementId;
    data['taxId'] = taxId;
    data['inclusiveTax'] = inclusiveTax;
    data['taxRate'] = taxRate;
    data['remarks'] = remarks;
    data['sgstTaxPercentage'] = sgstTaxPercentage;
    data['sgstTaxAmount'] = sgstTaxAmount;
    data['cgstTaxPercentage'] = cgstTaxPercentage;
    data['cgstTaxAmount'] = cgstTaxAmount;
    data['igstTaxPercentage'] = igstTaxPercentage;
    data['igstTaxAmount'] = igstTaxAmount;
    data['partNumber'] = partNumber;
    data['hsnOrSac'] = hsnOrSac;
    data['partName'] = partName;
    data['uom'] = uom;
    data['specification'] = specification;
    data['serviceFrequencyCount'] = serviceFrequencyCount;
    return data;
  }
}