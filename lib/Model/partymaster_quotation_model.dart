class QuotationTansactionTypeModel {
  final List<QuotationHeaders>? quotationHeaders;
  final int? totalCount;

  QuotationTansactionTypeModel({
    this.quotationHeaders,
    this.totalCount,
  });

  QuotationTansactionTypeModel.fromJson(Map<String, dynamic> json)
      : quotationHeaders = (json['quotationHeaders'] as List?)?.map((dynamic e) => QuotationHeaders.fromJson(e as Map<String, dynamic>)).toList(),
        totalCount = json['totalCount'] as int?;

  Map<String, dynamic> toJson() => {'quotationHeaders': quotationHeaders?.map((e) => e.toJson()).toList(), 'totalCount': totalCount};
}

class QuotationHeaders {
  final String? id;
  final dynamic amount;
  final String? quotationNumber;
  final int? quotationId;
  final String? quotationDate;
  final dynamic enquiryNumber;
  final dynamic enquiryDate;
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
  final dynamic paymentTerms;
  final dynamic deliveryTerms;
  final dynamic termsAndConditions;
  final double? taxAmount;
  final dynamic kindAttention;
  final dynamic quotationSubject;
  final dynamic quotationStatus;
  final dynamic isPaymentChecked;
  final dynamic sgstTaxRate;
  final double? sgstTaxAmount;
  final dynamic cgstTaxRate;
  final double? cgstTaxAmount;
  final dynamic igstTaxRate;
  final double? igstTaxAmount;
  final int? quotationTypeId;
  final List<QuotationItems>? quotationItems;
  final String? statusName;
  final String? partyName;
  final String? address;
  final String? gstNumber;
  final String? shipToAddress;
  final dynamic remarks;
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
  final int? partyCurrencyId;
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
  final dynamic isIgst;
  final String? partyCode;
  final String? createdBy;
  final String? updateBy;
  final String? createdDate;
  final String? updatedDate;
  final dynamic currencyName;
  final dynamic email;
  final dynamic internalNote;

  QuotationHeaders({
    this.id,
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
    this.email,
    this.internalNote,
  });

  QuotationHeaders.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        amount = json['amount'],
        quotationNumber = json['quotationNumber'] as String?,
        quotationId = json['quotationId'] as int?,
        quotationDate = json['quotationDate'] as String?,
        enquiryNumber = json['enquiryNumber'],
        enquiryDate = json['enquiryDate'],
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
        paymentTerms = json['paymentTerms'],
        deliveryTerms = json['deliveryTerms'],
        termsAndConditions = json['termsAndConditions'],
        taxAmount = json['taxAmount'] as double?,
        kindAttention = json['kindAttention'],
        quotationSubject = json['quotationSubject'],
        quotationStatus = json['quotationStatus'],
        isPaymentChecked = json['isPaymentChecked'],
        sgstTaxRate = json['sgstTaxRate'],
        sgstTaxAmount = json['sgstTaxAmount'] as double?,
        cgstTaxRate = json['cgstTaxRate'],
        cgstTaxAmount = json['cgstTaxAmount'] as double?,
        igstTaxRate = json['igstTaxRate'],
        igstTaxAmount = json['igstTaxAmount'] as double?,
        quotationTypeId = json['quotationTypeId'] as int?,
        quotationItems = (json['quotationItems'] as List?)?.map((dynamic e) => QuotationItems.fromJson(e as Map<String, dynamic>)).toList(),
        statusName = json['statusName'] as String?,
        partyName = json['partyName'] as String?,
        address = json['address'] as String?,
        gstNumber = json['gstNumber'] as String?,
        shipToAddress = json['shipToAddress'] as String?,
        remarks = json['remarks'],
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
        partyCurrencyId = json['partyCurrencyId'] as int?,
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
        isIgst = json['isIgst'],
        partyCode = json['partyCode'] as String?,
        createdBy = json['createdBy'] as String?,
        updateBy = json['updateBy'] as String?,
        createdDate = json['createdDate'] as String?,
        updatedDate = json['updatedDate'] as String?,
        currencyName = json['currencyName'],
        email = json['email'],
        internalNote = json['internalNote'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'quotationNumber': quotationNumber,
        'quotationId': quotationId,
        'quotationDate': quotationDate,
        'enquiryNumber': enquiryNumber,
        'enquiryDate': enquiryDate,
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
        'paymentTerms': paymentTerms,
        'deliveryTerms': deliveryTerms,
        'termsAndConditions': termsAndConditions,
        'taxAmount': taxAmount,
        'kindAttention': kindAttention,
        'quotationSubject': quotationSubject,
        'quotationStatus': quotationStatus,
        'isPaymentChecked': isPaymentChecked,
        'sgstTaxRate': sgstTaxRate,
        'sgstTaxAmount': sgstTaxAmount,
        'cgstTaxRate': cgstTaxRate,
        'cgstTaxAmount': cgstTaxAmount,
        'igstTaxRate': igstTaxRate,
        'igstTaxAmount': igstTaxAmount,
        'quotationTypeId': quotationTypeId,
        'quotationItems': quotationItems?.map((e) => e.toJson()).toList(),
        'statusName': statusName,
        'partyName': partyName,
        'address': address,
        'gstNumber': gstNumber,
        'shipToAddress': shipToAddress,
        'remarks': remarks,
        'inclusiveTax': inclusiveTax,
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
        'partyCurrencyId': partyCurrencyId,
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
        'currencyName': currencyName,
        'email': email,
        'internalNote': internalNote
      };
}

class QuotationItems {
  final String? id;
  final String? quotationHeaderId;
  final int? materialId;
  final int? slNo;
  final double? quantity;
  final double? price;
  final double? amount;
  final dynamic status;
  final dynamic taxPercentage;
  final dynamic taxAmount;
  final double? amountAfterTax;
  final double? discountPercentage;
  final double? discountAmount;
  final double? amountAfterDiscount;
  final int? unitOfMeasurementId;
  final int? taxId;
  final int? inclusiveTax;
  final dynamic taxRate;
  final String? remarks;
  final double? sgstTaxPercentage;
  final double? sgstTaxAmount;
  final double? cgstTaxPercentage;
  final double? cgstTaxAmount;
  final double? igstTaxPercentage;
  final double? igstTaxAmount;
  final String? partNumber;
  final dynamic hsnOrSac;
  final String? partName;
  final String? uom;
  final dynamic specification;

  QuotationItems({
    this.id,
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
  });

  QuotationItems.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        quotationHeaderId = json['quotationHeaderId'] as String?,
        materialId = json['materialId'] as int?,
        slNo = json['slNo'] as int?,
        quantity = json['quantity'] as double?,
        price = json['price'] as double?,
        amount = json['amount'] as double?,
        status = json['status'],
        taxPercentage = json['taxPercentage'],
        taxAmount = json['taxAmount'],
        amountAfterTax = json['amountAfterTax'] as double?,
        discountPercentage = json['discountPercentage'] as double?,
        discountAmount = json['discountAmount'] as double?,
        amountAfterDiscount = json['amountAfterDiscount'] as double?,
        unitOfMeasurementId = json['unitOfMeasurementId'] as int?,
        taxId = json['taxId'] as int?,
        inclusiveTax = json['inclusiveTax'] as int?,
        taxRate = json['taxRate'],
        remarks = json['remarks'] as String?,
        sgstTaxPercentage = json['sgstTaxPercentage'] as double?,
        sgstTaxAmount = json['sgstTaxAmount'] as double?,
        cgstTaxPercentage = json['cgstTaxPercentage'] as double?,
        cgstTaxAmount = json['cgstTaxAmount'] as double?,
        igstTaxPercentage = json['igstTaxPercentage'] as double?,
        igstTaxAmount = json['igstTaxAmount'] as double?,
        partNumber = json['partNumber'] as String?,
        hsnOrSac = json['hsnOrSac'],
        partName = json['partName'] as String?,
        uom = json['uom'] as String?,
        specification = json['specification'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'quotationHeaderId': quotationHeaderId,
        'materialId': materialId,
        'slNo': slNo,
        'quantity': quantity,
        'price': price,
        'amount': amount,
        'status': status,
        'taxPercentage': taxPercentage,
        'taxAmount': taxAmount,
        'amountAfterTax': amountAfterTax,
        'discountPercentage': discountPercentage,
        'discountAmount': discountAmount,
        'amountAfterDiscount': amountAfterDiscount,
        'unitOfMeasurementId': unitOfMeasurementId,
        'taxId': taxId,
        'inclusiveTax': inclusiveTax,
        'taxRate': taxRate,
        'remarks': remarks,
        'sgstTaxPercentage': sgstTaxPercentage,
        'sgstTaxAmount': sgstTaxAmount,
        'cgstTaxPercentage': cgstTaxPercentage,
        'cgstTaxAmount': cgstTaxAmount,
        'igstTaxPercentage': igstTaxPercentage,
        'igstTaxAmount': igstTaxAmount,
        'partNumber': partNumber,
        'hsnOrSac': hsnOrSac,
        'partName': partName,
        'uom': uom,
        'specification': specification
      };
}
