class GrnModel {
  final String? id;
  final int? grnId;
  final String? grnNumber;
  final String? grnDate;
  final dynamic purchaseOrderHeaderId;
  final String? purchaseOrderNumber;
  final dynamic purchaseOrderDate;
  final dynamic comments;
  final dynamic verbal;
  final int? grnStatusId;
  final int? companyId;
  final int? qualityCheckedById;
  final int? stockCheckedById;
  final int? financialYearId;
  final int? supplierId;
  final String? supplierName;
  final String? deliveryChallanHeaderId;
  final String? deliveryChallanNumber;
  final String? deliveryChallanDate;
  final dynamic termsAndConditionNote;
  final int? termsAndConditionId;
  final List<dynamic>? invoiceHeaderIds;
  final int? grnTypeId;
   List<GrnItems>? grnItems;
  final int? taxId;
  final String? statusName;
  final String? supplierAddress;
  final String? supplierGSTN;
  final String? stockCheckedByName;
  final String? qualityCheckedByName;
  final int? inclusiveTax;
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
  final String? companyTagLine;
  final String? companyGstNumber;
  final String? companyPanNumber;
  final dynamic companyPanDate;
  final dynamic companyCeritificateImagePath;
  final String? companyLogoPath;
  final String? partyName;
  final dynamic partyContactPersonNumber;
  final dynamic partyPinCode;
  final dynamic partyAreaId;
  final dynamic partyCityId;
  final int? partyStateId;
  final int? partyCountryId;
  final dynamic partyPrimaryTelephone;
  final dynamic partySecondaryTelephone;
  final String? partyPrimaryMobile;
  final dynamic partySecondaryMobile;
  final String? partyEmail;
  final dynamic partyWebsite;
  final dynamic partyContactPersonName;
  final dynamic partyBillToAddress;
  final dynamic partyShipAddress;
  final dynamic partyDueDaysLimit;
  final String? partyGstRegistrationTypeId;
  final dynamic partyGstNumber;
  final dynamic partyPanNumber;
  final dynamic isIgst;
  final String? partyCode;
  final String? createdBy;
  final String? updateBy;
  final String? createdDate;
  final String? internalNote;
  final String? updatedDate;

  GrnModel({
    this.id,
    this.grnId,
    this.grnNumber,
    this.grnDate,
    this.purchaseOrderHeaderId,
    this.purchaseOrderNumber,
    this.purchaseOrderDate,
    this.comments,
    this.verbal,
    this.grnStatusId,
    this.companyId,
    this.qualityCheckedById,
    this.stockCheckedById,
    this.financialYearId,
    this.supplierId,
    this.supplierName,
    this.deliveryChallanHeaderId,
    this.deliveryChallanNumber,
    this.deliveryChallanDate,
    this.termsAndConditionNote,
    this.termsAndConditionId,
    this.invoiceHeaderIds,
    this.grnTypeId,
    this.grnItems,
    this.taxId,
    this.statusName,
    this.supplierAddress,
    this.supplierGSTN,
    this.stockCheckedByName,
    this.qualityCheckedByName,
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
    this.partyName,
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
    this.internalNote,
    this.updatedDate,
  });

  GrnModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      grnId = json['grnId'] as int?,
      grnNumber = json['grnNumber'] as String?,
      grnDate = json['grnDate'] as String?,
      purchaseOrderHeaderId = json['purchaseOrderHeaderId'],
      purchaseOrderNumber = json['purchaseOrderNumber'] as String?,
      purchaseOrderDate = json['purchaseOrderDate'],
      comments = json['comments'],
      verbal = json['verbal'],
      grnStatusId = json['grnStatusId'] as int?,
      companyId = json['companyId'] as int?,
      qualityCheckedById = json['qualityCheckedById'] as int?,
      stockCheckedById = json['stockCheckedById'] as int?,
      financialYearId = json['financialYearId'] as int?,
      supplierId = json['supplierId'] as int?,
      supplierName = json['supplierName'] as String?,
      deliveryChallanHeaderId = json['deliveryChallanHeaderId'] as String?,
      deliveryChallanNumber = json['deliveryChallanNumber'] as String?,
      deliveryChallanDate = json['deliveryChallanDate'] as String?,
      termsAndConditionNote = json['termsAndConditionNote'],
      termsAndConditionId = json['termsAndConditionId'] as int?,
      invoiceHeaderIds = json['invoiceHeaderIds'] as List?,
      grnTypeId = json['grnTypeId'] as int?,
      grnItems = (json['grnItems'] as List?)?.map((dynamic e) => GrnItems.fromJson(e as Map<String,dynamic>)).toList(),
      taxId = json['taxId'] as int?,
      statusName = json['statusName'] as String?,
      supplierAddress = json['supplierAddress'] as String?,
      supplierGSTN = json['supplierGSTN'] as String?,
      stockCheckedByName = json['stockCheckedByName'] as String?,
      qualityCheckedByName = json['qualityCheckedByName'] as String?,
      inclusiveTax = json['inclusiveTax'] as int?,
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
      companyTagLine = json['companyTagLine'] as String?,
      companyGstNumber = json['companyGstNumber'] as String?,
      companyPanNumber = json['companyPanNumber'] as String?,
      companyPanDate = json['companyPanDate'],
      companyCeritificateImagePath = json['companyCeritificateImagePath'],
      companyLogoPath = json['companyLogoPath'] as String?,
      partyName = json['partyName'] as String?,
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
      partyBillToAddress = json['partyBillToAddress'],
      partyShipAddress = json['partyShipAddress'],
      partyDueDaysLimit = json['partyDueDaysLimit'],
      partyGstRegistrationTypeId = json['partyGstRegistrationTypeId'] as String?,
      partyGstNumber = json['partyGstNumber'],
      partyPanNumber = json['partyPanNumber'],
      isIgst = json['isIgst'],
      partyCode = json['partyCode'] as String?,
      createdBy = json['createdBy'] as String?,
      updateBy = json['updateBy'] as String?,
      createdDate = json['createdDate'] as String?,
      internalNote = json['internalNote'] as String?,
      updatedDate = json['updatedDate'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'grnId' : grnId,
    'grnNumber' : grnNumber,
    'grnDate' : grnDate,
    'purchaseOrderHeaderId' : purchaseOrderHeaderId,
    'purchaseOrderNumber' : purchaseOrderNumber,
    'purchaseOrderDate' : purchaseOrderDate,
    'comments' : comments,
    'verbal' : verbal,
    'grnStatusId' : grnStatusId,
    'companyId' : companyId,
    'qualityCheckedById' : qualityCheckedById,
    'stockCheckedById' : stockCheckedById,
    'financialYearId' : financialYearId,
    'supplierId' : supplierId,
    'supplierName' : supplierName,
    'deliveryChallanHeaderId' : deliveryChallanHeaderId,
    'deliveryChallanNumber' : deliveryChallanNumber,
    'deliveryChallanDate' : deliveryChallanDate,
    'termsAndConditionNote' : termsAndConditionNote,
    'termsAndConditionId' : termsAndConditionId,
    'invoiceHeaderIds' : invoiceHeaderIds,
    'grnTypeId' : grnTypeId,
    'grnItems' : grnItems?.map((e) => e.toJson()).toList(),
    'taxId' : taxId,
    'statusName' : statusName,
    'supplierAddress' : supplierAddress,
    'supplierGSTN' : supplierGSTN,
    'stockCheckedByName' : stockCheckedByName,
    'qualityCheckedByName' : qualityCheckedByName,
    'inclusiveTax' : inclusiveTax,
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
    'companyTagLine' : companyTagLine,
    'companyGstNumber' : companyGstNumber,
    'companyPanNumber' : companyPanNumber,
    'companyPanDate' : companyPanDate,
    'companyCeritificateImagePath' : companyCeritificateImagePath,
    'companyLogoPath' : companyLogoPath,
    'partyName' : partyName,
    'partyContactPersonNumber' : partyContactPersonNumber,
    'partyPinCode' : partyPinCode,
    'partyAreaId' : partyAreaId,
    'partyCityId' : partyCityId,
    'partyStateId' : partyStateId,
    'partyCountryId' : partyCountryId,
    'partyPrimaryTelephone' : partyPrimaryTelephone,
    'partySecondaryTelephone' : partySecondaryTelephone,
    'partyPrimaryMobile' : partyPrimaryMobile,
    'partySecondaryMobile' : partySecondaryMobile,
    'partyEmail' : partyEmail,
    'partyWebsite' : partyWebsite,
    'partyContactPersonName' : partyContactPersonName,
    'partyBillToAddress' : partyBillToAddress,
    'partyShipAddress' : partyShipAddress,
    'partyDueDaysLimit' : partyDueDaysLimit,
    'partyGstRegistrationTypeId' : partyGstRegistrationTypeId,
    'partyGstNumber' : partyGstNumber,
    'partyPanNumber' : partyPanNumber,
    'isIgst' : isIgst,
    'partyCode' : partyCode,
    'createdBy' : createdBy,
    'updateBy' : updateBy,
    'createdDate' : createdDate,
    'internalNote' : internalNote,
    'updatedDate' : updatedDate
  };
}

class GrnItems {
  final String? id;
  final String? grnHeaderId;
  final int? materialId;
  final int? slNo;
  final String? materialName;
  final double? deliveryChallanQuantity;
   double? acceptedQuantity;
  final double? rejectedQuantity;
  final dynamic purchaseOrderHeaderId;
  final double? invoiceBalanceQuantity;
  final dynamic remarks;
  final dynamic amount;
  final String? deliveryChallanHeaderId;
  final String? deliveryChallanItemId;
  final int? unitOfMeasurementId;
  final double? unitPrice;
  final String? materialSpecification;
  final int? taxId;
  final double? discountPercentage;
  final double? discountAmount;
  final double? amountAfterDiscount;
  final double? sgstTaxPercentage;
  final double? sgstTaxAmount;
  final double? cgstTaxPercentage;
  final double? cgstTaxAmount;
  final double? igstTaxPercentage;
  final double? igstTaxAmount;
  final dynamic taxAmount;
  final dynamic partNumber;
  final dynamic hsnOrSac;
  final dynamic partName;
  final String? uom;
  final int? inclusiveTax;
  final dynamic status;
  final dynamic grnItemStatus;

  GrnItems({
    this.id,
    this.grnHeaderId,
    this.materialId,
    this.slNo,
    this.materialName,
    this.deliveryChallanQuantity,
    this.acceptedQuantity,
    this.rejectedQuantity,
    this.purchaseOrderHeaderId,
    this.invoiceBalanceQuantity,
    this.remarks,
    this.amount,
    this.deliveryChallanHeaderId,
    this.deliveryChallanItemId,
    this.unitOfMeasurementId,
    this.unitPrice,
    this.materialSpecification,
    this.taxId,
    this.discountPercentage,
    this.discountAmount,
    this.amountAfterDiscount,
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
    this.status,
    this.grnItemStatus,
  });

  GrnItems.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      grnHeaderId = json['grnHeaderId'] as String?,
      materialId = json['materialId'] as int?,
      slNo = json['slNo'] as int?,
      materialName = json['materialName'] as String?,
      deliveryChallanQuantity = json['deliveryChallanQuantity'] as double?,
      acceptedQuantity = json['acceptedQuantity'] as double?,
      rejectedQuantity = json['rejectedQuantity'] as double?,
      purchaseOrderHeaderId = json['purchaseOrderHeaderId'],
      invoiceBalanceQuantity = json['invoiceBalanceQuantity'] as double?,
      remarks = json['remarks'],
      amount = json['amount'],
      deliveryChallanHeaderId = json['deliveryChallanHeaderId'] as String?,
      deliveryChallanItemId = json['deliveryChallanItemId'] as String?,
      unitOfMeasurementId = json['unitOfMeasurementId'] as int?,
      unitPrice = json['unitPrice'] as double?,
      materialSpecification = json['materialSpecification'] as String?,
      taxId = json['taxId'] as int?,
      discountPercentage = json['discountPercentage'] as double?,
      discountAmount = json['discountAmount'] as double?,
      amountAfterDiscount = json['amountAfterDiscount'] as double?,
      sgstTaxPercentage = json['sgstTaxPercentage'] as double?,
      sgstTaxAmount = json['sgstTaxAmount'] as double?,
      cgstTaxPercentage = json['cgstTaxPercentage'] as double?,
      cgstTaxAmount = json['cgstTaxAmount'] as double?,
      igstTaxPercentage = json['igstTaxPercentage'] as double?,
      igstTaxAmount = json['igstTaxAmount'] as double?,
      taxAmount = json['taxAmount'],
      partNumber = json['partNumber'],
      hsnOrSac = json['hsnOrSac'],
      partName = json['partName'],
      uom = json['uom'] as String?,
      inclusiveTax = json['inclusiveTax'] as int?,
      status = json['status'],
      grnItemStatus = json['grnItemStatus'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'grnHeaderId' : grnHeaderId,
    'materialId' : materialId,
    'slNo' : slNo,
    'materialName' : materialName,
    'deliveryChallanQuantity' : deliveryChallanQuantity,
    'acceptedQuantity' : acceptedQuantity,
    'rejectedQuantity' : rejectedQuantity,
    'purchaseOrderHeaderId' : purchaseOrderHeaderId,
    'invoiceBalanceQuantity' : invoiceBalanceQuantity,
    'remarks' : remarks,
    'amount' : amount,
    'deliveryChallanHeaderId' : deliveryChallanHeaderId,
    'deliveryChallanItemId' : deliveryChallanItemId,
    'unitOfMeasurementId' : unitOfMeasurementId,
    'unitPrice' : unitPrice,
    'materialSpecification' : materialSpecification,
    'taxId' : taxId,
    'discountPercentage' : discountPercentage,
    'discountAmount' : discountAmount,
    'amountAfterDiscount' : amountAfterDiscount,
    'sgstTaxPercentage' : sgstTaxPercentage,
    'sgstTaxAmount' : sgstTaxAmount,
    'cgstTaxPercentage' : cgstTaxPercentage,
    'cgstTaxAmount' : cgstTaxAmount,
    'igstTaxPercentage' : igstTaxPercentage,
    'igstTaxAmount' : igstTaxAmount,
    'taxAmount' : taxAmount,
    'partNumber' : partNumber,
    'hsnOrSac' : hsnOrSac,
    'partName' : partName,
    'uom' : uom,
    'inclusiveTax' : inclusiveTax,
    'status' : status,
    'grnItemStatus' : grnItemStatus
  };
}