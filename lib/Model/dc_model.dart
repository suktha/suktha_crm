class DCModel {
  String? id;
  String? deliveryChallanNumber;
  int? deliveryChallanId;
  String? deliveryChallanDate;
  dynamic internalReferenceNumber;
  dynamic internalReferenceDate;
  String? purchaseOrderNumber;
  String? purchaseOrderDate;
  int? deliveryChallanTypeId;
  int? partyId;
  dynamic officeAddress;
  dynamic deliveryAddress;
  dynamic dispatchDate;
  dynamic inspectedBy;
  dynamic inspectionDate;
  dynamic modeOfDispatch;
  dynamic vehicleNumber;
  dynamic deliveryNote;
  double? totalQuantity;
  int? statusId;
  int? financialYearId;
  int? companyId;
  dynamic numberOfPackages;
  dynamic deliveryTerms;
  dynamic termsAndConditions;
  dynamic paymentTerms;
  dynamic dispatchTime;
  int? taxId;
  dynamic labourChargesOnly;
  dynamic inDeliveryChallanNumber;
  dynamic inDeliveryChallanDate;
  dynamic returnableDeliveryChallan;
  dynamic nonReturnableDeliveryChallan;
  dynamic notForSale;
  dynamic forSale;
  dynamic returnForJobWork;
  dynamic modeOfDispatchStatus;
  dynamic vehicleNumberStatus;
  dynamic numberOfPackagesStatus;
  dynamic personName;
  double? sgstTaxRate;
  double? sgstTaxAmount;
  double? cgstTaxRate;
  double? cgstTaxAmount;
  double? igstTaxRate;
  double? igstTaxAmount;
  double? taxAmount;
  dynamic price;
  double? amount;
  dynamic eWayBill;
  double? balanceQuantity;
  List<DcItems>? deliveryChallanItems;
  String? statusName;
  String? partyName;
  dynamic discountPercentage;
  dynamic discountAmount;
  dynamic amountAfterDiscount;
  dynamic remarks;
  String? gstNumber;
  String? address;
  int? inclusiveTax;
  String? billToAddress;
  dynamic shipToAddress;
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
  dynamic partyCityId;
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
  dynamic isIgst;
  String? partyCode;
  String? createdBy;
  String? updateBy;
  String? createdDate;
  String? updatedDate;
  String? internalNote;
  dynamic jwNoteId;
  dynamic email;

  DCModel({
    this.id,
    this.deliveryChallanNumber,
    this.deliveryChallanId,
    this.deliveryChallanDate,
    this.internalReferenceNumber,
    this.internalReferenceDate,
    this.purchaseOrderNumber,
    this.purchaseOrderDate,
    this.deliveryChallanTypeId,
    this.partyId,
    this.officeAddress,
    this.deliveryAddress,
    this.dispatchDate,
    this.inspectedBy,
    this.inspectionDate,
    this.modeOfDispatch,
    this.vehicleNumber,
    this.deliveryNote,
    this.totalQuantity,
    this.statusId,
    this.financialYearId,
    this.companyId,
    this.numberOfPackages,
    this.deliveryTerms,
    this.termsAndConditions,
    this.paymentTerms,
    this.dispatchTime,
    this.taxId,
    this.labourChargesOnly,
    this.inDeliveryChallanNumber,
    this.inDeliveryChallanDate,
    this.returnableDeliveryChallan,
    this.nonReturnableDeliveryChallan,
    this.notForSale,
    this.forSale,
    this.returnForJobWork,
    this.modeOfDispatchStatus,
    this.vehicleNumberStatus,
    this.numberOfPackagesStatus,
    this.personName,
    this.sgstTaxRate,
    this.sgstTaxAmount,
    this.cgstTaxRate,
    this.cgstTaxAmount,
    this.igstTaxRate,
    this.igstTaxAmount,
    this.taxAmount,
    this.price,
    this.amount,
    this.eWayBill,
    this.balanceQuantity,
    this.deliveryChallanItems,
    this.statusName,
    this.partyName,
    this.discountPercentage,
    this.discountAmount,
    this.amountAfterDiscount,
    this.remarks,
    this.gstNumber,
    this.address,
    this.inclusiveTax,
    this.billToAddress,
    this.shipToAddress,
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
    this.jwNoteId,
    this.internalNote,
    this.email,
  });

  DCModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    deliveryChallanNumber = json['deliveryChallanNumber'] as String?;
    deliveryChallanId = json['deliveryChallanId'] as int?;
    deliveryChallanDate = json['deliveryChallanDate'] as String?;
    internalReferenceNumber = json['internalReferenceNumber'];
    internalReferenceDate = json['internalReferenceDate'];
    purchaseOrderNumber = json['purchaseOrderNumber'] as String?;
    purchaseOrderDate = json['purchaseOrderDate'] as String?;
    deliveryChallanTypeId = json['deliveryChallanTypeId'] as int?;
    partyId = json['partyId'] as int?;
    officeAddress = json['officeAddress'];
    deliveryAddress = json['deliveryAddress'];
    dispatchDate = json['dispatchDate'];
    inspectedBy = json['inspectedBy'];
    inspectionDate = json['inspectionDate'];
    modeOfDispatch = json['modeOfDispatch'];
    vehicleNumber = json['vehicleNumber'];
    deliveryNote = json['deliveryNote'];
    totalQuantity = json['totalQuantity'] as dynamic;
    statusId = json['statusId'] as int?;
    financialYearId = json['financialYearId'] as int?;
    companyId = json['companyId'] as int?;
    numberOfPackages = json['numberOfPackages'];
    deliveryTerms = json['deliveryTerms'];
    termsAndConditions = json['termsAndConditions'];
    paymentTerms = json['paymentTerms'];
    dispatchTime = json['dispatchTime'];
    taxId = json['taxId'] as int?;
    labourChargesOnly = json['labourChargesOnly'];
    inDeliveryChallanNumber = json['inDeliveryChallanNumber'];
    inDeliveryChallanDate = json['inDeliveryChallanDate'];
    returnableDeliveryChallan = json['returnableDeliveryChallan'];
    nonReturnableDeliveryChallan = json['nonReturnableDeliveryChallan'];
    notForSale = json['notForSale'];
    forSale = json['forSale'];
    returnForJobWork = json['returnForJobWork'];
    modeOfDispatchStatus = json['modeOfDispatchStatus'];
    vehicleNumberStatus = json['vehicleNumberStatus'];
    numberOfPackagesStatus = json['numberOfPackagesStatus'];
    personName = json['personName'];
    sgstTaxRate = json['sgstTaxRate'];
    sgstTaxAmount = json['sgstTaxAmount'];
    cgstTaxRate = json['cgstTaxRate'];
    cgstTaxAmount = json['cgstTaxAmount'];
    igstTaxRate = json['igstTaxRate'];
    igstTaxAmount = json['igstTaxAmount'];
    taxAmount = json['taxAmount'] as double?;
    price = json['price'];
    amount = json['amount'];
    eWayBill = json['eWayBill'];
    balanceQuantity = json['balanceQuantity'] as double?;
    deliveryChallanItems = (json['deliveryChallanItems'] as List?)?.map((dynamic e) => DcItems.fromJson(e as Map<String, dynamic>)).toList();
    statusName = json['statusName'] as String?;
    partyName = json['partyName'] as String?;
    discountPercentage = json['discountPercentage'];
    discountAmount = json['discountAmount'];
    amountAfterDiscount = json['amountAfterDiscount'];
    remarks = json['remarks'];
    gstNumber = json['gstNumber'] as String?;
    address = json['address'] as String?;
    inclusiveTax = json['inclusiveTax'] as int?;
    billToAddress = json['billToAddress'] as String?;
    shipToAddress = json['shipToAddress'];
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
    partyCityId = json['partyCityId'];
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
    isIgst = json['isIgst'];
    partyCode = json['partyCode'] as String?;
    createdBy = json['createdBy'] as String?;
    updateBy = json['updateBy'] as String?;
    createdDate = json['createdDate'] as String?;
    updatedDate = json['updatedDate'] as String?;
    internalNote = json['internalNote'] as String?;
    jwNoteId = json['jwNoteId'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['deliveryChallanNumber'] = deliveryChallanNumber;
    json['deliveryChallanId'] = deliveryChallanId;
    json['deliveryChallanDate'] = deliveryChallanDate;
    json['internalReferenceNumber'] = internalReferenceNumber;
    json['internalReferenceDate'] = internalReferenceDate;
    json['purchaseOrderNumber'] = purchaseOrderNumber;
    json['purchaseOrderDate'] = purchaseOrderDate;
    json['deliveryChallanTypeId'] = deliveryChallanTypeId;
    json['partyId'] = partyId;
    json['officeAddress'] = officeAddress;
    json['deliveryAddress'] = deliveryAddress;
    json['dispatchDate'] = dispatchDate;
    json['inspectedBy'] = inspectedBy;
    json['inspectionDate'] = inspectionDate;
    json['modeOfDispatch'] = modeOfDispatch;
    json['vehicleNumber'] = vehicleNumber;
    json['deliveryNote'] = deliveryNote;
    json['totalQuantity'] = totalQuantity;
    json['statusId'] = statusId;
    json['financialYearId'] = financialYearId;
    json['companyId'] = companyId;
    json['numberOfPackages'] = numberOfPackages;
    json['deliveryTerms'] = deliveryTerms;
    json['termsAndConditions'] = termsAndConditions;
    json['paymentTerms'] = paymentTerms;
    json['dispatchTime'] = dispatchTime;
    json['taxId'] = taxId;
    json['labourChargesOnly'] = labourChargesOnly;
    json['inDeliveryChallanNumber'] = inDeliveryChallanNumber;
    json['inDeliveryChallanDate'] = inDeliveryChallanDate;
    json['returnableDeliveryChallan'] = returnableDeliveryChallan;
    json['nonReturnableDeliveryChallan'] = nonReturnableDeliveryChallan;
    json['notForSale'] = notForSale;
    json['forSale'] = forSale;
    json['returnForJobWork'] = returnForJobWork;
    json['modeOfDispatchStatus'] = modeOfDispatchStatus;
    json['vehicleNumberStatus'] = vehicleNumberStatus;
    json['numberOfPackagesStatus'] = numberOfPackagesStatus;
    json['personName'] = personName;
    json['sgstTaxRate'] = sgstTaxRate;
    json['sgstTaxAmount'] = sgstTaxAmount;
    json['cgstTaxRate'] = cgstTaxRate;
    json['cgstTaxAmount'] = cgstTaxAmount;
    json['igstTaxRate'] = igstTaxRate;
    json['igstTaxAmount'] = igstTaxAmount;
    json['taxAmount'] = taxAmount;
    json['price'] = price;
    json['amount'] = amount;
    json['eWayBill'] = eWayBill;
    json['balanceQuantity'] = balanceQuantity;
    json['deliveryChallanItems'] = deliveryChallanItems?.map((e) => e.toJson()).toList();
    json['statusName'] = statusName;
    json['partyName'] = partyName;
    json['discountPercentage'] = discountPercentage;
    json['discountAmount'] = discountAmount;
    json['amountAfterDiscount'] = amountAfterDiscount;
    json['remarks'] = remarks;
    json['gstNumber'] = gstNumber;
    json['address'] = address;
    json['inclusiveTax'] = inclusiveTax;
    json['billToAddress'] = billToAddress;
    json['shipToAddress'] = shipToAddress;
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
    json['jwNoteId'] = jwNoteId;
    json['email'] = email;
    json['internalNote'] = internalNote;
    return json;
  }
}

class DcItems {
  String? id;
  String? headerId;
  int? materialId;
  int? slNo;
  String? materialName;
  double? quantity;
  String? remarks;
  dynamic status;
  String? purchaseOrderHeaderId;
  String? purchaseOrderItemId;
  double? price;
  double? amount;
  int? unitOfMeasurementId;
  int? taxId;
  dynamic taxRate;
  dynamic deliveryChallanType;
  dynamic deliveryChallanItemStatus;
  String? processId;
  double? invoiceBalanceQuantity;
  dynamic batchCode;
  dynamic purchaseOrderNumber;
  dynamic batchCodeId;
  dynamic inDeliveryChallanNumber;
  dynamic inDeliveryChallanDate;
  double? sgstTaxPercentage;
  double? sgstTaxAmount;
  double? cgstTaxPercentage;
  double? cgstTaxAmount;
  double? igstTaxPercentage;
  double? igstTaxAmount;
  dynamic taxAmount;
  dynamic partNumber;
  String? hsnOrSac;
  String? partName;
  String? uom;
  int? inclusiveTax;
  double? discountPercentage;
  double? discountAmount;
  double? amountAfterDiscount;
  double? grnBalanceQuantity;
  dynamic sourceDeliveryChallanHeaderId;
  dynamic sourceDeliveryChallanItemId;
  dynamic receivedQuantity;
  double? incomingQuantity;
  double? dcBalanceQuantity;
  String? processName;
  String? specification;
  dynamic sourceDeliveryChallanNumber;
  dynamic sourceDeliveryChallanDate;
  int? isContainer;
  dynamic outName;
  dynamic outPartNumber;
  dynamic jwNoteItemId;

  DcItems({
    this.id,
    this.headerId,
    this.materialId,
    this.slNo,
    this.materialName,
    this.quantity,
    this.remarks,
    this.status,
    this.purchaseOrderHeaderId,
    this.purchaseOrderItemId,
    this.price,
    this.amount,
    this.unitOfMeasurementId,
    this.taxId,
    this.taxRate,
    this.deliveryChallanType,
    this.deliveryChallanItemStatus,
    this.processId,
    this.invoiceBalanceQuantity,
    this.batchCode,
    this.purchaseOrderNumber,
    this.batchCodeId,
    this.inDeliveryChallanNumber,
    this.inDeliveryChallanDate,
    this.sgstTaxPercentage,
    this.sgstTaxAmount,
    this.cgstTaxPercentage,
    this.cgstTaxAmount,
    this.igstTaxPercentage,
    this.igstTaxAmount,
    this.taxAmount,
    this.partNumber,
    this.hsnOrSac,
    this.partName,
    this.uom,
    this.inclusiveTax,
    this.discountPercentage,
    this.discountAmount,
    this.amountAfterDiscount,
    this.grnBalanceQuantity,
    this.sourceDeliveryChallanHeaderId,
    this.sourceDeliveryChallanItemId,
    this.receivedQuantity,
    this.incomingQuantity,
    this.dcBalanceQuantity,
    this.processName,
    this.specification,
    this.sourceDeliveryChallanNumber,
    this.sourceDeliveryChallanDate,
    this.isContainer,
    this.outName,
    this.outPartNumber,
    this.jwNoteItemId,
  });

  DcItems.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    headerId = json['headerId'] as String?;
    materialId = json['materialId'] as int?;
    slNo = json['slNo'] as int?;
    materialName = json['materialName'] as String?;
    quantity = json['quantity'] as double?;
    remarks = json['remarks'] as String?;
    status = json['status'];
    purchaseOrderHeaderId = json['purchaseOrderHeaderId'] as String?;
    purchaseOrderItemId = json['purchaseOrderItemId'] as String?;
    price = json['price'] as double?;
    amount = json['amount'] as double?;
    unitOfMeasurementId = json['unitOfMeasurementId'] as int?;
    taxId = json['taxId'] as int?;
    taxRate = json['taxRate'];
    deliveryChallanType = json['deliveryChallanType'];
    deliveryChallanItemStatus = json['deliveryChallanItemStatus'];
    processId = json['processId'] as String?;
    invoiceBalanceQuantity = json['invoiceBalanceQuantity'] as double?;
    batchCode = json['batchCode'];
    purchaseOrderNumber = json['purchaseOrderNumber'];
    batchCodeId = json['batchCodeId'];
    inDeliveryChallanNumber = json['inDeliveryChallanNumber'];
    inDeliveryChallanDate = json['inDeliveryChallanDate'];
    sgstTaxPercentage = json['sgstTaxPercentage'] as double?;
    sgstTaxAmount = json['sgstTaxAmount'] as double?;
    cgstTaxPercentage = json['cgstTaxPercentage'] as double?;
    cgstTaxAmount = json['cgstTaxAmount'] as double?;
    igstTaxPercentage = json['igstTaxPercentage'] as double?;
    igstTaxAmount = json['igstTaxAmount'] as double?;
    taxAmount = json['taxAmount'];
    partNumber = json['partNumber'];
    hsnOrSac = json['hsnOrSac'] as String?;
    partName = json['partName'] as String?;
    uom = json['uom'] as String?;
    inclusiveTax = json['inclusiveTax'] as int?;
    discountPercentage = json['discountPercentage'] as double?;
    discountAmount = json['discountAmount'] as double?;
    amountAfterDiscount = json['amountAfterDiscount'] as double?;
    grnBalanceQuantity = json['grnBalanceQuantity'] as double?;
    sourceDeliveryChallanHeaderId = json['sourceDeliveryChallanHeaderId'];
    sourceDeliveryChallanItemId = json['sourceDeliveryChallanItemId'];
    receivedQuantity = json['receivedQuantity'];
    incomingQuantity = json['incomingQuantity'] as double?;
    dcBalanceQuantity = json['dcBalanceQuantity'] as double?;
    processName = json['processName'] as String?;
    specification = json['specification'] as String?;
    sourceDeliveryChallanNumber = json['sourceDeliveryChallanNumber'];
    sourceDeliveryChallanDate = json['sourceDeliveryChallanDate'];
    isContainer = json['isContainer'] as int?;
    outName = json['outName'];
    outPartNumber = json['outPartNumber'];
    jwNoteItemId = json['jwNoteItemId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['headerId'] = headerId;
    json['materialId'] = materialId;
    json['slNo'] = slNo;
    json['materialName'] = materialName;
    json['quantity'] = quantity;
    json['remarks'] = remarks;
    json['status'] = status;
    json['purchaseOrderHeaderId'] = purchaseOrderHeaderId;
    json['purchaseOrderItemId'] = purchaseOrderItemId;
    json['price'] = price;
    json['amount'] = amount;
    json['unitOfMeasurementId'] = unitOfMeasurementId;
    json['taxId'] = taxId;
    json['taxRate'] = taxRate;
    json['deliveryChallanType'] = deliveryChallanType;
    json['deliveryChallanItemStatus'] = deliveryChallanItemStatus;
    json['processId'] = processId;
    json['invoiceBalanceQuantity'] = invoiceBalanceQuantity;
    json['batchCode'] = batchCode;
    json['purchaseOrderNumber'] = purchaseOrderNumber;
    json['batchCodeId'] = batchCodeId;
    json['inDeliveryChallanNumber'] = inDeliveryChallanNumber;
    json['inDeliveryChallanDate'] = inDeliveryChallanDate;
    json['sgstTaxPercentage'] = sgstTaxPercentage;
    json['sgstTaxAmount'] = sgstTaxAmount;
    json['cgstTaxPercentage'] = cgstTaxPercentage;
    json['cgstTaxAmount'] = cgstTaxAmount;
    json['igstTaxPercentage'] = igstTaxPercentage;
    json['igstTaxAmount'] = igstTaxAmount;
    json['taxAmount'] = taxAmount;
    json['partNumber'] = partNumber;
    json['hsnOrSac'] = hsnOrSac;
    json['partName'] = partName;
    json['uom'] = uom;
    json['inclusiveTax'] = inclusiveTax;
    json['discountPercentage'] = discountPercentage;
    json['discountAmount'] = discountAmount;
    json['amountAfterDiscount'] = amountAfterDiscount;
    json['grnBalanceQuantity'] = grnBalanceQuantity;
    json['sourceDeliveryChallanHeaderId'] = sourceDeliveryChallanHeaderId;
    json['sourceDeliveryChallanItemId'] = sourceDeliveryChallanItemId;
    json['receivedQuantity'] = receivedQuantity;
    json['incomingQuantity'] = incomingQuantity;
    json['dcBalanceQuantity'] = dcBalanceQuantity;
    json['processName'] = processName;
    json['specification'] = specification;
    json['sourceDeliveryChallanNumber'] = sourceDeliveryChallanNumber;
    json['sourceDeliveryChallanDate'] = sourceDeliveryChallanDate;
    json['isContainer'] = isContainer;
    json['outName'] = outName;
    json['outPartNumber'] = outPartNumber;
    json['jwNoteItemId'] = jwNoteItemId;
    return json;
  }
}
