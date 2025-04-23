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
        quotationItems!.add(new QuotationItems.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['quotationNumber'] = this.quotationNumber;
    data['quotationId'] = this.quotationId;
    data['quotationDate'] = this.quotationDate;
    data['enquiryNumber'] = this.enquiryNumber;
    data['enquiryDate'] = this.enquiryDate;
    data['partyId'] = this.partyId;
    data['subTotalAmount'] = this.subTotalAmount;
    data['totalDiscount'] = this.totalDiscount;
    data['discountPercent'] = this.discountPercent;
    data['totalTaxableAmount'] = this.totalTaxableAmount;
    data['taxId'] = this.taxId;
    data['roundOffAmount'] = this.roundOffAmount;
    data['grandTotal'] = this.grandTotal;
    data['statusId'] = this.statusId;
    data['financialYearId'] = this.financialYearId;
    data['companyId'] = this.companyId;
    data['paymentTerms'] = this.paymentTerms;
    data['deliveryTerms'] = this.deliveryTerms;
    data['termsAndConditions'] = this.termsAndConditions;
    data['taxAmount'] = this.taxAmount;
    data['kindAttention'] = this.kindAttention;
    data['quotationSubject'] = this.quotationSubject;
    data['quotationStatus'] = this.quotationStatus;
    data['isPaymentChecked'] = this.isPaymentChecked;
    data['sgstTaxRate'] = this.sgstTaxRate;
    data['sgstTaxAmount'] = this.sgstTaxAmount;
    data['cgstTaxRate'] = this.cgstTaxRate;
    data['cgstTaxAmount'] = this.cgstTaxAmount;
    data['igstTaxRate'] = this.igstTaxRate;
    data['igstTaxAmount'] = this.igstTaxAmount;
    data['quotationTypeId'] = this.quotationTypeId;
    if (this.quotationItems != null) {
      data['quotationItems'] =
          this.quotationItems!.map((v) => v.toJson()).toList();
    }
    data['statusName'] = this.statusName;
    data['partyName'] = this.partyName;
    data['address'] = this.address;
    data['gstNumber'] = this.gstNumber;
    data['shipToAddress'] = this.shipToAddress;
    data['remarks'] = this.remarks;
    data['inclusiveTax'] = this.inclusiveTax;
    data['companyName'] = this.companyName;
    data['companygGstRegistrationTypeId'] = this.companygGstRegistrationTypeId;
    data['companyPinCode'] = this.companyPinCode;
    data['companyStateId'] = this.companyStateId;
    data['companyStateName'] = this.companyStateName;
    data['companyCountryId'] = this.companyCountryId;
    data['companyPrimaryMobile'] = this.companyPrimaryMobile;
    data['companySecondaryMobile'] = this.companySecondaryMobile;
    data['companyContactPersonNumber'] = this.companyContactPersonNumber;
    data['companyContactPersonName'] = this.companyContactPersonName;
    data['companyPrimaryTelephone'] = this.companyPrimaryTelephone;
    data['companySecondaryTelephone'] = this.companySecondaryTelephone;
    data['companyWebsite'] = this.companyWebsite;
    data['companyEmail'] = this.companyEmail;
    data['companyFaxNumber'] = this.companyFaxNumber;
    data['companyAddress'] = this.companyAddress;
    data['companyTagLine'] = this.companyTagLine;
    data['companyGstNumber'] = this.companyGstNumber;
    data['companyPanNumber'] = this.companyPanNumber;
    data['companyPanDate'] = this.companyPanDate;
    data['companyCeritificateImagePath'] = this.companyCeritificateImagePath;
    data['companyLogoPath'] = this.companyLogoPath;
    data['partyContactPersonNumber'] = this.partyContactPersonNumber;
    data['partyPinCode'] = this.partyPinCode;
    data['partyAreaId'] = this.partyAreaId;
    data['partyCityId'] = this.partyCityId;
    data['partyStateId'] = this.partyStateId;
    data['partyCountryId'] = this.partyCountryId;
    data['partyCurrencyId'] = this.partyCurrencyId;
    data['partyPrimaryTelephone'] = this.partyPrimaryTelephone;
    data['partySecondaryTelephone'] = this.partySecondaryTelephone;
    data['partyPrimaryMobile'] = this.partyPrimaryMobile;
    data['partySecondaryMobile'] = this.partySecondaryMobile;
    data['partyEmail'] = this.partyEmail;
    data['partyWebsite'] = this.partyWebsite;
    data['partyContactPersonName'] = this.partyContactPersonName;
    data['partyBillToAddress'] = this.partyBillToAddress;
    data['partyShipAddress'] = this.partyShipAddress;
    data['partyDueDaysLimit'] = this.partyDueDaysLimit;
    data['partyGstRegistrationTypeId'] = this.partyGstRegistrationTypeId;
    data['partyGstNumber'] = this.partyGstNumber;
    data['partyPanNumber'] = this.partyPanNumber;
    data['isIgst'] = this.isIgst;
    data['partyCode'] = this.partyCode;
    data['createdBy'] = this.createdBy;
    data['updateBy'] = this.updateBy;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    data['currencyName'] = this.currencyName;
    data['email'] = this.email;
    data['internalNote'] = this.internalNote;
    data['isSubscriptionBasedService'] = this.isSubscriptionBasedService;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quotationHeaderId'] = this.quotationHeaderId;
    data['materialId'] = this.materialId;
    data['slNo'] = this.slNo;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['taxPercentage'] = this.taxPercentage;
    data['taxAmount'] = this.taxAmount;
    data['amountAfterTax'] = this.amountAfterTax;
    data['discountPercentage'] = this.discountPercentage;
    data['discountAmount'] = this.discountAmount;
    data['amountAfterDiscount'] = this.amountAfterDiscount;
    data['unitOfMeasurementId'] = this.unitOfMeasurementId;
    data['taxId'] = this.taxId;
    data['inclusiveTax'] = this.inclusiveTax;
    data['taxRate'] = this.taxRate;
    data['remarks'] = this.remarks;
    data['sgstTaxPercentage'] = this.sgstTaxPercentage;
    data['sgstTaxAmount'] = this.sgstTaxAmount;
    data['cgstTaxPercentage'] = this.cgstTaxPercentage;
    data['cgstTaxAmount'] = cgstTaxAmount;
    data['igstTaxPercentage'] = this.igstTaxPercentage;
    data['igstTaxAmount'] = this.igstTaxAmount;
    data['partNumber'] = this.partNumber;
    data['hsnOrSac'] = this.hsnOrSac;
    data['partName'] = this.partName;
    data['uom'] = this.uom;
    data['specification'] = this.specification;
    data['serviceFrequencyCount'] = this.serviceFrequencyCount;
    return data;
  }
}