class GetPOlistModel {
  String? id;
  String? purchaseOrderNumber;
  int? purchaseOrderId;
  String? purchaseOrderDate;
  String? quotationNumber;
  String? quotationDate;
  dynamic internalReferenceNumber;
  dynamic internalReferenceDate;
  int? partyId;
  double? subTotalAmount;
  double? totalDiscount;
  double? discountPercent;
  double? totalTaxableAmount;
  int? taxId;
  double? roundOffAmount;
  double? grandTotal;
  int? statusId;
  int? financialYearId;
  int? companyId;
  int? purchaseOrderTypeId;
  dynamic paymentTerms;
  dynamic deliveryTerms;
  dynamic termsAndConditions;
  double? taxAmount;
  dynamic advanceAmount;
  double? sgstTaxRate;
  double? sgstTaxAmount;
  double? cgstTaxRate;
  double? cgstTaxAmount;
  double? igstTaxRate;
  double? igstTaxAmount;
  int? isReverseCharge;
  dynamic transportationCharges;
  List<PurchaseOrderItems>? purchaseOrderItems;
  String? partyName;
  String? statusName;
  String? address;
  String? gstNumber;
  String? shipToAddress;
  dynamic purchaseOrderEndDate;
  int? isOpenEnded;
  dynamic remarks;
  int? inclusiveTax;
  String? companyName;
  dynamic companygGstRegistrationTypeId;
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
  String? companyPanDate;
  dynamic companyCeritificateImagePath;
  String? companyLogoPath;
  dynamic partyContactPersonNumber;
  dynamic partyPinCode;
  dynamic partyAreaId;
  int? partyCityId;
  int? partyStateId;
  int? partyCountryId;
  dynamic partyPrimaryTelephone;
  dynamic partySecondaryTelephone;
  dynamic partyPrimaryMobile;
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
  int? closePo;
  int? partyCurrencyId;
  dynamic currencyName;
  String? internalNote;
  String? email;
  int? isSubscriptionBasedService;

  GetPOlistModel({
    this.id,
    this.purchaseOrderNumber,
    this.purchaseOrderId,
    this.purchaseOrderDate,
    this.quotationNumber,
    this.quotationDate,
    this.internalReferenceNumber,
    this.internalReferenceDate,
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
    this.purchaseOrderTypeId,
    this.paymentTerms,
    this.deliveryTerms,
    this.termsAndConditions,
    this.taxAmount,
    this.advanceAmount,
    this.sgstTaxRate,
    this.sgstTaxAmount,
    this.cgstTaxRate,
    this.cgstTaxAmount,
    this.igstTaxRate,
    this.igstTaxAmount,
    this.isReverseCharge,
    this.transportationCharges,
    this.purchaseOrderItems,
    this.partyName,
    this.statusName,
    this.address,
    this.gstNumber,
    this.shipToAddress,
    this.purchaseOrderEndDate,
    this.isOpenEnded,
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
    this.closePo,
    this.partyCurrencyId,
    this.internalNote,
    this.currencyName,
    this.email,
    this.isSubscriptionBasedService,
  });

  GetPOlistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    purchaseOrderNumber = json['purchaseOrderNumber'] as String?;
    purchaseOrderId = json['purchaseOrderId'] as int?;
    purchaseOrderDate = json['purchaseOrderDate'] as String?;
    quotationNumber = json['quotationNumber'] as String?;
    quotationDate = json['quotationDate'] as String?;
    internalReferenceNumber = json['internalReferenceNumber'];
    internalReferenceDate = json['internalReferenceDate'];
    partyId = json['partyId'] as int?;
    subTotalAmount = json['subTotalAmount'] as double?;
    totalDiscount = json['totalDiscount'] as double?;
    discountPercent = json['discountPercent'] as double?;
    totalTaxableAmount = json['totalTaxableAmount'] as double?;
    taxId = json['taxId'] as int?;
    roundOffAmount = json['roundOffAmount'] as double?;
    grandTotal = json['grandTotal'] as double?;
    statusId = json['statusId'] as int?;
    financialYearId = json['financialYearId'] as int?;
    companyId = json['companyId'] as int?;
    purchaseOrderTypeId = json['purchaseOrderTypeId'] as int?;
    paymentTerms = json['paymentTerms'];
    deliveryTerms = json['deliveryTerms'];
    termsAndConditions = json['termsAndConditions'];
    taxAmount = json['taxAmount'] as double?;
    advanceAmount = json['advanceAmount'];
    sgstTaxRate = json['sgstTaxRate'] as double?;
    sgstTaxAmount = json['sgstTaxAmount'] as double?;
    cgstTaxRate = json['cgstTaxRate'] as double?;
    cgstTaxAmount = json['cgstTaxAmount'] as double?;
    igstTaxRate = json['igstTaxRate'] as double?;
    igstTaxAmount = json['igstTaxAmount'] as double?;
    isReverseCharge = json['isReverseCharge'] as int?;
    transportationCharges = json['transportationCharges'];
    purchaseOrderItems = (json['purchaseOrderItems'] as List?)?.map((dynamic e) => PurchaseOrderItems.fromJson(e as Map<String,dynamic>)).toList();
    partyName = json['partyName'] as String?;
    statusName = json['statusName'] as String?;
    address = json['address'] as String?;
    gstNumber = json['gstNumber'] as String?;
    shipToAddress = json['shipToAddress'] as String?;
    purchaseOrderEndDate = json['purchaseOrderEndDate'];
    isOpenEnded = json['isOpenEnded'] as int?;
    remarks = json['remarks'];
    inclusiveTax = json['inclusiveTax'] as int?;
    companyName = json['companyName'] as String?;
    companygGstRegistrationTypeId = json['companygGstRegistrationTypeId'];
    companyPinCode = json['companyPinCode'] as String?;
    companyStateId = json['companyStateId'] as int?;
    companyStateName = json['companyStateName'] as String?;
    companyCountryId = json['companyCountryId'] as int?;
    companyPrimaryMobile = json['companyPrimaryMobile'] as String?;
    companySecondaryMobile = json['companySecondaryMobile'] as String?;
    companyContactPersonNumber = json['companyContactPersonNumber'] as String?;
    companyContactPersonName = json['companyContactPersonName'] as String?;
    companyPrimaryTelephone = json['companyPrimaryTelephone'] as String?;
    companySecondaryTelephone = json['companySecondaryTelephone'] as String?;
    companyWebsite = json['companyWebsite'] as String?;
    companyEmail = json['companyEmail'] as String?;
    companyFaxNumber = json['companyFaxNumber'] as String?;
    companyAddress = json['companyAddress'] as String?;
    companyTagLine = json['companyTagLine'] as String?;
    companyGstNumber = json['companyGstNumber'] as String?;
    companyPanNumber = json['companyPanNumber'] as String?;
    companyPanDate = json['companyPanDate'] as String?;
    companyCeritificateImagePath = json['companyCeritificateImagePath'];
    companyLogoPath = json['companyLogoPath'] as String?;
    partyContactPersonNumber = json['partyContactPersonNumber'];
    partyPinCode = json['partyPinCode'];
    partyAreaId = json['partyAreaId'];
    partyCityId = json['partyCityId'] as int?;
    partyStateId = json['partyStateId'] as int?;
    partyCountryId = json['partyCountryId'] as int?;
    partyPrimaryTelephone = json['partyPrimaryTelephone'];
    partySecondaryTelephone = json['partySecondaryTelephone'];
    partyPrimaryMobile = json['partyPrimaryMobile'];
    partySecondaryMobile = json['partySecondaryMobile'];
    partyEmail = json['partyEmail'] as String?;
    partyWebsite = json['partyWebsite'];
    partyContactPersonName = json['partyContactPersonName'];
    partyBillToAddress = json['partyBillToAddress'];
    partyShipAddress = json['partyShipAddress'];
    partyDueDaysLimit = json['partyDueDaysLimit'];
    partyGstRegistrationTypeId = json['partyGstRegistrationTypeId'] as String?;
    partyGstNumber = json['partyGstNumber'];
    partyPanNumber = json['partyPanNumber'];
    isIgst = json['isIgst'] as String?;
    partyCode = json['partyCode'] as String?;
    createdBy = json['createdBy'] as String?;
    updateBy = json['updateBy'] as String?;
    createdDate = json['createdDate'] as String?;
    updatedDate = json['updatedDate'] as String?;
    internalNote = json['internalNote'] as String?;
    closePo = json['closePo'] as int?;
    partyCurrencyId = json['partyCurrencyId'] as int?;
    currencyName = json['currencyName'];
    email = json['email'] as String?;
    isSubscriptionBasedService = json['isSubscriptionBasedService'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['purchaseOrderNumber'] = purchaseOrderNumber;
    json['purchaseOrderId'] = purchaseOrderId;
    json['purchaseOrderDate'] = purchaseOrderDate;
    json['quotationNumber'] = quotationNumber;
    json['quotationDate'] = quotationDate;
    json['internalReferenceNumber'] = internalReferenceNumber;
    json['internalReferenceDate'] = internalReferenceDate;
    json['partyId'] = partyId;
    json['subTotalAmount'] = subTotalAmount;
    json['totalDiscount'] = totalDiscount;
    json['discountPercent'] = discountPercent;
    json['totalTaxableAmount'] = totalTaxableAmount;
    json['taxId'] = taxId;
    json['roundOffAmount'] = roundOffAmount;
    json['grandTotal'] = grandTotal;
    json['statusId'] = statusId;
    json['financialYearId'] = financialYearId;
    json['companyId'] = companyId;
    json['purchaseOrderTypeId'] = purchaseOrderTypeId;
    json['paymentTerms'] = paymentTerms;
    json['deliveryTerms'] = deliveryTerms;
    json['termsAndConditions'] = termsAndConditions;
    json['taxAmount'] = taxAmount;
    json['advanceAmount'] = advanceAmount;
    json['sgstTaxRate'] = sgstTaxRate;
    json['sgstTaxAmount'] = sgstTaxAmount;
    json['cgstTaxRate'] = cgstTaxRate;
    json['cgstTaxAmount'] = cgstTaxAmount;
    json['igstTaxRate'] = igstTaxRate;
    json['igstTaxAmount'] = igstTaxAmount;
    json['isReverseCharge'] = isReverseCharge;
    json['transportationCharges'] = transportationCharges;
    json['purchaseOrderItems'] = purchaseOrderItems?.map((e) => e.toJson()).toList();
    json['partyName'] = partyName;
    json['statusName'] = statusName;
    json['address'] = address;
    json['gstNumber'] = gstNumber;
    json['shipToAddress'] = shipToAddress;
    json['purchaseOrderEndDate'] = purchaseOrderEndDate;
    json['isOpenEnded'] = isOpenEnded;
    json['remarks'] = remarks;
    json['inclusiveTax'] = inclusiveTax;
    json['companyName'] = companyName;
    json['companygGstRegistrationTypeId'] = companygGstRegistrationTypeId;
    json['companyPinCode'] = companyPinCode;
    json['companyStateId'] = companyStateId;
    json['companyStateName'] = companyStateName;
    json['companyCountryId'] = companyCountryId;
    json['companyPrimaryMobile'] = companyPrimaryMobile;
    json['companySecondaryMobile'] = companySecondaryMobile;
    json['companyContactPersonNumber'] = companyContactPersonNumber;
    json['companyContactPersonName'] = companyContactPersonName;
    json['companyPrimaryTelephone'] = companyPrimaryTelephone;
    json['companySecondaryTelephone'] = companySecondaryTelephone;
    json['companyWebsite'] = companyWebsite;
    json['companyEmail'] = companyEmail;
    json['companyFaxNumber'] = companyFaxNumber;
    json['companyAddress'] = companyAddress;
    json['companyTagLine'] = companyTagLine;
    json['companyGstNumber'] = companyGstNumber;
    json['companyPanNumber'] = companyPanNumber;
    json['companyPanDate'] = companyPanDate;
    json['companyCeritificateImagePath'] = companyCeritificateImagePath;
    json['companyLogoPath'] = companyLogoPath;
    json['partyContactPersonNumber'] = partyContactPersonNumber;
    json['partyPinCode'] = partyPinCode;
    json['partyAreaId'] = partyAreaId;
    json['partyCityId'] = partyCityId;
    json['partyStateId'] = partyStateId;
    json['partyCountryId'] = partyCountryId;
    json['partyPrimaryTelephone'] = partyPrimaryTelephone;
    json['partySecondaryTelephone'] = partySecondaryTelephone;
    json['partyPrimaryMobile'] = partyPrimaryMobile;
    json['partySecondaryMobile'] = partySecondaryMobile;
    json['partyEmail'] = partyEmail;
    json['partyWebsite'] = partyWebsite;
    json['partyContactPersonName'] = partyContactPersonName;
    json['partyBillToAddress'] = partyBillToAddress;
    json['partyShipAddress'] = partyShipAddress;
    json['partyDueDaysLimit'] = partyDueDaysLimit;
    json['partyGstRegistrationTypeId'] = partyGstRegistrationTypeId;
    json['partyGstNumber'] = partyGstNumber;
    json['partyPanNumber'] = partyPanNumber;
    json['isIgst'] = isIgst;
    json['partyCode'] = partyCode;
    json['createdBy'] = createdBy;
    json['updateBy'] = updateBy;
    json['createdDate'] = createdDate;
    json['updatedDate'] = updatedDate;
    json['closePo'] = closePo;
    json['partyCurrencyId'] = partyCurrencyId;
    json['currencyName'] = currencyName;
    json['email'] = email;
    json['internalNote'] = internalNote;
    json['isSubscriptionBasedService'] = isSubscriptionBasedService;
    return json;
  }
}

class PurchaseOrderItems {
  String? id;
  String? headerId;
  int? slNo;
  int? materialId;
  double? quantity;
  double? dcBalanceQuantity;
  double? price;
  double? amount;
  double? discountPercentage;
  double? discountAmount;
  double? amountAfterDiscount;
  dynamic transportationAmount;
  dynamic cessPercentage;
  dynamic cessAmount;
  double? igstTaxPercentage;
  double? igstTaxAmount;
  double? sgstTaxPercentage;
  double? sgstTaxAmount;
  double? cgstTaxPercentage;
  double? cgstTaxAmount;
  double? amountAfterTax;
  String? remarks;
  String? quotationHeaderId;
  String? quotationItemId;
  int? unitOfMeasurementId;
  int? taxId;
  dynamic partNumber;
  String? hsnOrSac;
  String? partName;
  String? uom;
  int? inclusiveTax;
  double? invoiceBalanceQuantity;
  dynamic processId;
  dynamic processName;
  String? specification;
  int? isContainer;
int?  serviceFrequencyCount;

  PurchaseOrderItems({
    this.id,
    this.headerId,
    this.slNo,
    this.materialId,
    this.quantity,
    this.dcBalanceQuantity,
    this.price,
    this.amount,
    this.discountPercentage,
    this.discountAmount,
    this.amountAfterDiscount,
    this.transportationAmount,
    this.cessPercentage,
    this.cessAmount,
    this.igstTaxPercentage,
    this.igstTaxAmount,
    this.sgstTaxPercentage,
    this.sgstTaxAmount,
    this.cgstTaxPercentage,
    this.cgstTaxAmount,
    this.amountAfterTax,
    this.remarks,
    this.quotationHeaderId,
    this.quotationItemId,
    this.unitOfMeasurementId,
    this.taxId,
    this.partNumber,
    this.hsnOrSac,
    this.partName,
    this.uom,
    this.inclusiveTax,
    this.invoiceBalanceQuantity,
    this.processId,
    this.processName,
    this.specification,
    this.isContainer,
    this.serviceFrequencyCount,
  });

  PurchaseOrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    headerId = json['headerId'] as String?;
    slNo = json['slNo'] as int?;
    materialId = json['materialId'] as int?;
    quantity = json['quantity'] as double?;
    dcBalanceQuantity = json['dcBalanceQuantity'] as double?;
    price = json['price'] as double?;
    amount = json['amount'] as double?;
    discountPercentage = json['discountPercentage'] as double?;
    discountAmount = json['discountAmount'] as double?;
    amountAfterDiscount = json['amountAfterDiscount'] as double?;
    transportationAmount = json['transportationAmount'];
    cessPercentage = json['cessPercentage'];
    cessAmount = json['cessAmount'];
    igstTaxPercentage = json['igstTaxPercentage'] as double?;
    igstTaxAmount = json['igstTaxAmount'] as double?;
    sgstTaxPercentage = json['sgstTaxPercentage'] as double?;
    sgstTaxAmount = json['sgstTaxAmount'] as double?;
    cgstTaxPercentage = json['cgstTaxPercentage'] as double?;
    cgstTaxAmount = json['cgstTaxAmount'] as double?;
    amountAfterTax = json['amountAfterTax'] as double?;
    remarks = json['remarks'] as String?;
    quotationHeaderId = json['quotationHeaderId'] as String?;
    quotationItemId = json['quotationItemId'] as String?;
    unitOfMeasurementId = json['unitOfMeasurementId'] as int?;
    taxId = json['taxId'] as int?;
    partNumber = json['partNumber'];
    hsnOrSac = json['hsnOrSac'] as String?;
    partName = json['partName'] as String?;
    uom = json['uom'] as String?;
    inclusiveTax = json['inclusiveTax'] as int?;
    invoiceBalanceQuantity = json['invoiceBalanceQuantity'] as double?;
    processId = json['processId'];
    processName = json['processName'];
    specification = json['specification'] as String?;
    isContainer = json['isContainer'] as int?;
    serviceFrequencyCount = json['serviceFrequencyCount'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['headerId'] = headerId;
    json['slNo'] = slNo;
    json['materialId'] = materialId;
    json['quantity'] = quantity;
    json['dcBalanceQuantity'] = dcBalanceQuantity;
    json['price'] = price;
    json['amount'] = amount;
    json['discountPercentage'] = discountPercentage;
    json['discountAmount'] = discountAmount;
    json['amountAfterDiscount'] = amountAfterDiscount;
    json['transportationAmount'] = transportationAmount;
    json['cessPercentage'] = cessPercentage;
    json['cessAmount'] = cessAmount;
    json['igstTaxPercentage'] = igstTaxPercentage;
    json['igstTaxAmount'] = igstTaxAmount;
    json['sgstTaxPercentage'] = sgstTaxPercentage;
    json['sgstTaxAmount'] = sgstTaxAmount;
    json['cgstTaxPercentage'] = cgstTaxPercentage;
    json['cgstTaxAmount'] = cgstTaxAmount;
    json['amountAfterTax'] = amountAfterTax;
    json['remarks'] = remarks;
    json['quotationHeaderId'] = quotationHeaderId;
    json['quotationItemId'] = quotationItemId;
    json['unitOfMeasurementId'] = unitOfMeasurementId;
    json['taxId'] = taxId;
    json['partNumber'] = partNumber;
    json['hsnOrSac'] = hsnOrSac;
    json['partName'] = partName;
    json['uom'] = uom;
    json['inclusiveTax'] = inclusiveTax;
    json['invoiceBalanceQuantity'] = invoiceBalanceQuantity;
    json['processId'] = processId;
    json['processName'] = processName;
    json['specification'] = specification;
    json['isContainer'] = isContainer;
    json['serviceFrequencyCount'] = serviceFrequencyCount;
    return json;
  }
}