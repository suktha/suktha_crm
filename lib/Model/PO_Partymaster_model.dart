class POTansactionTypeModel {
  final List<PurchaseOrderHeaders>? purchaseOrderHeaders;
  final int? totalCount;

  POTansactionTypeModel({
    this.purchaseOrderHeaders,
    this.totalCount,
  });

  POTansactionTypeModel.fromJson(Map<String, dynamic> json)
      : purchaseOrderHeaders = (json['purchaseOrderHeaders'] as List?)?.map((dynamic e) => PurchaseOrderHeaders.fromJson(e as Map<String, dynamic>)).toList(),
        totalCount = json['totalCount'] as int?;

  Map<String, dynamic> toJson() => {'purchaseOrderHeaders': purchaseOrderHeaders?.map((e) => e.toJson()).toList(), 'totalCount': totalCount};
}

class PurchaseOrderHeaders {
  final String? id;
  final String? purchaseOrderNumber;
  final int? purchaseOrderId;
  final String? purchaseOrderDate;
  final dynamic quotationNumber;
  final dynamic quotationDate;
  final dynamic internalReferenceNumber;
  final dynamic internalReferenceDate;
  final int? partyId;
  final double? subTotalAmount;
  final double? totalDiscount;
  final dynamic discountPercent;
  final double? totalTaxableAmount;
  final int? taxId;
  final double? roundOffAmount;
  final double? grandTotal;
  final int? statusId;
  final int? financialYearId;
  final int? companyId;
  final int? purchaseOrderTypeId;
  final dynamic paymentTerms;
  final dynamic deliveryTerms;
  final dynamic termsAndConditions;
  final double? taxAmount;
  final dynamic advanceAmount;
  final dynamic sgstTaxRate;
  final double? sgstTaxAmount;
  final dynamic cgstTaxRate;
  final double? cgstTaxAmount;
  final dynamic igstTaxRate;
  final double? igstTaxAmount;
  final int? isReverseCharge;
  final dynamic transportationCharges;
  final dynamic purchaseOrderItems;
  final String? partyName;
  final String? statusName;
  final String? address;
  final String? gstNumber;
  final String? shipToAddress;
  final dynamic purchaseOrderEndDate;
  final int? isOpenEnded;
  final dynamic remarks;
  final int? inclusiveTax;
  final dynamic internalNote;
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
  final dynamic partyBillToAddress;
  final dynamic partyShipAddress;
  final dynamic partyDueDaysLimit;
  final String? partyGstRegistrationTypeId;
  final dynamic partyGstNumber;
  final String? partyPanNumber;
  final String? isIgst;
  final String? partyCode;
  final String? createdBy;
  final String? updateBy;
  final String? createdDate;
  final String? updatedDate;
  final int? closePo;
  final int? partyCurrencyId;
  final dynamic currencyName;
  final dynamic email;

  PurchaseOrderHeaders({
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
    this.internalNote,
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
    this.currencyName,
    this.email,
  });

  PurchaseOrderHeaders.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        purchaseOrderNumber = json['purchaseOrderNumber'] as String?,
        purchaseOrderId = json['purchaseOrderId'] as int?,
        purchaseOrderDate = json['purchaseOrderDate'] as String?,
        quotationNumber = json['quotationNumber'],
        quotationDate = json['quotationDate'],
        internalReferenceNumber = json['internalReferenceNumber'],
        internalReferenceDate = json['internalReferenceDate'],
        partyId = json['partyId'] as int?,
        subTotalAmount = json['subTotalAmount'] as double?,
        totalDiscount = json['totalDiscount'] as double?,
        discountPercent = json['discountPercent'],
        totalTaxableAmount = json['totalTaxableAmount'] as double?,
        taxId = json['taxId'] as int?,
        roundOffAmount = json['roundOffAmount'] as double?,
        grandTotal = json['grandTotal'] as double?,
        statusId = json['statusId'] as int?,
        financialYearId = json['financialYearId'] as int?,
        companyId = json['companyId'] as int?,
        purchaseOrderTypeId = json['purchaseOrderTypeId'] as int?,
        paymentTerms = json['paymentTerms'],
        deliveryTerms = json['deliveryTerms'],
        termsAndConditions = json['termsAndConditions'],
        taxAmount = json['taxAmount'] as double?,
        advanceAmount = json['advanceAmount'],
        sgstTaxRate = json['sgstTaxRate'],
        sgstTaxAmount = json['sgstTaxAmount'] as double?,
        cgstTaxRate = json['cgstTaxRate'],
        cgstTaxAmount = json['cgstTaxAmount'] as double?,
        igstTaxRate = json['igstTaxRate'],
        igstTaxAmount = json['igstTaxAmount'] as double?,
        isReverseCharge = json['isReverseCharge'] as int?,
        transportationCharges = json['transportationCharges'],
        purchaseOrderItems = json['purchaseOrderItems'],
        partyName = json['partyName'] as String?,
        statusName = json['statusName'] as String?,
        address = json['address'] as String?,
        gstNumber = json['gstNumber'] as String?,
        shipToAddress = json['shipToAddress'] as String?,
        purchaseOrderEndDate = json['purchaseOrderEndDate'],
        isOpenEnded = json['isOpenEnded'] as int?,
        remarks = json['remarks'],
        inclusiveTax = json['inclusiveTax'] as int?,
        internalNote = json['internalNote'],
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
        partyBillToAddress = json['partyBillToAddress'],
        partyShipAddress = json['partyShipAddress'],
        partyDueDaysLimit = json['partyDueDaysLimit'],
        partyGstRegistrationTypeId = json['partyGstRegistrationTypeId'] as String?,
        partyGstNumber = json['partyGstNumber'],
        partyPanNumber = json['partyPanNumber'] as String?,
        isIgst = json['isIgst'] as String?,
        partyCode = json['partyCode'] as String?,
        createdBy = json['createdBy'] as String?,
        updateBy = json['updateBy'] as String?,
        createdDate = json['createdDate'] as String?,
        updatedDate = json['updatedDate'] as String?,
        closePo = json['closePo'] as int?,
        partyCurrencyId = json['partyCurrencyId'] as int?,
        currencyName = json['currencyName'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'purchaseOrderNumber': purchaseOrderNumber,
        'purchaseOrderId': purchaseOrderId,
        'purchaseOrderDate': purchaseOrderDate,
        'quotationNumber': quotationNumber,
        'quotationDate': quotationDate,
        'internalReferenceNumber': internalReferenceNumber,
        'internalReferenceDate': internalReferenceDate,
        'partyId': partyId,
        'subTotalAmount': subTotalAmount,
        'totalDiscount': totalDiscount,
        'discountPercent': discountPercent,
        'totalTaxableAmount': totalTaxableAmount,
        'taxId': taxId,
        'roundOffAmount': roundOffAmount,
        'grandTotal': grandTotal,
        'statusId': statusId,
        'financialYearId': financialYearId,
        'companyId': companyId,
        'purchaseOrderTypeId': purchaseOrderTypeId,
        'paymentTerms': paymentTerms,
        'deliveryTerms': deliveryTerms,
        'termsAndConditions': termsAndConditions,
        'taxAmount': taxAmount,
        'advanceAmount': advanceAmount,
        'sgstTaxRate': sgstTaxRate,
        'sgstTaxAmount': sgstTaxAmount,
        'cgstTaxRate': cgstTaxRate,
        'cgstTaxAmount': cgstTaxAmount,
        'igstTaxRate': igstTaxRate,
        'igstTaxAmount': igstTaxAmount,
        'isReverseCharge': isReverseCharge,
        'transportationCharges': transportationCharges,
        'purchaseOrderItems': purchaseOrderItems,
        'partyName': partyName,
        'statusName': statusName,
        'address': address,
        'gstNumber': gstNumber,
        'shipToAddress': shipToAddress,
        'purchaseOrderEndDate': purchaseOrderEndDate,
        'isOpenEnded': isOpenEnded,
        'remarks': remarks,
        'inclusiveTax': inclusiveTax,
        'internalNote': internalNote,
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
        'closePo': closePo,
        'partyCurrencyId': partyCurrencyId,
        'currencyName': currencyName,
        'email': email
      };
}
