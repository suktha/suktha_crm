class InvoiceTransactionDetailsModel {
  final List<InvoiceHeaders>? invoiceHeaders;
  final int? totalCount;

  InvoiceTransactionDetailsModel({
    this.invoiceHeaders,
    this.totalCount,
  });

  InvoiceTransactionDetailsModel.fromJson(Map<String, dynamic> json)
      : invoiceHeaders = (json['invoiceHeaders'] as List?)?.map((dynamic e) => InvoiceHeaders.fromJson(e as Map<String, dynamic>)).toList(),
        totalCount = json['totalCount'] as int?;

  Map<String, dynamic> toJson() => {'invoiceHeaders': invoiceHeaders?.map((e) => e.toJson()).toList(), 'totalCount': totalCount};
}

class InvoiceHeaders {
  final String? id;
  final String? invoiceDate;
  final String? gstNumber;
  final String? invoiceNumber;
  final int? invId;
  final dynamic purchaseOrderDate;
  final String? purchaseOrderNumber;
  final dynamic purchaseOrderId;
  final dynamic referenceDate;
  final String? address;
  final dynamic internalReferenceNumber;
  final dynamic deliveryChallanDate;
  final dynamic deliveryChallanNumber;
  final int? stateId;
  final String? stateName;
  final String? paymentDueDate;
  final dynamic eWayBillNumber;
  final double? totalTaxableAmount;
  final double? grandTotal;
  final String? billToAddress;
  final int? labourChargesOnly;
  final double? subTotalAmount;
  final dynamic paymentTerms;
  final dynamic deliveryTerms;
  final String? termsAndConditions;
  final dynamic modeOfDispatch;
  final dynamic vehicleNumber;
  final dynamic numOfPackages;
  final dynamic documentThrough;
  final String? shipToAddress;
  final dynamic totalDiscount;
  final double? netAmount;
  final dynamic transportationCharges;
  final dynamic advanceAmount;
  final dynamic isRoudedOff;
  final double? roundOffAmount;
  final String? proformaInvoiceNumber;
  final dynamic proformaInvoiceDate;
  final String? grnNumber;
  final dynamic grnDate;
  final dynamic sourceInvoiceNumber;
  final dynamic sourceInvoiceDate;
  final dynamic cessAmount;
  final dynamic cessPercent;
  final double? sgstTaxRate;
  final dynamic sgstTaxAmount;
  final double? cgstTaxRate;
  final dynamic cgstTaxAmount;
  final double? igstTaxRate;
  final double? igstTaxAmount;
  final int? companyId;
  final dynamic discountAmount;
  final dynamic discountPercent;
  final double? dueAmount;
  final int? financialYearId;
  final dynamic internalReferenceDate;
  final int? invoiceTypeId;
  final int? isReverseCharge;
  final int? partyId;
  final String? partyName;
  final dynamic remarks;
  final dynamic email;
  final dynamic pdfName;
  final dynamic pdfNameWithTimeStamp;
  final int? shippingPincode;
  final dynamic invoiceItems;
  final int? taxId;
  final double? taxAmount;
  final dynamic timeOfInvoice;
  final dynamic vendorCode;
  final int? statusId;
  final String? statusName;
  final int? inclusiveTax;
  final dynamic deliveryChallanDateString;
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
  final dynamic companyCeritificateImagePath;
  final String? companyLogoPath;
  final dynamic partyContactPersonNumber;
  final String? partyPinCode;
  final int? partyAreaId;
  final int? partyCityId;
  final int? partyStateId;
  final int? partyCountryId;
  final dynamic partyPrimaryTelephone;
  final dynamic partySecondaryTelephone;
  final dynamic partyPrimaryMobile;
  final dynamic partySecondaryMobile;
  final dynamic partyEmail;
  final dynamic partyWebsite;
  final dynamic partyContactPersonName;
  final dynamic partyBillToAddress;
  final dynamic partyShipAddress;
  final dynamic partyDueDaysLimit;
  final String? partyGstRegistrationTypeId;
  final dynamic partyGstNumber;
  final dynamic partyPanNumber;
  final String? isIgst;
  final dynamic isReused;
  final dynamic reusedInvoiceId;
  final String? partyCode;
  final dynamic transactionStatus;
  final dynamic preTdsPer;
  final dynamic preTdsAmount;
  final double? tcsPercentage;
  final double? tcsAmount;
  final String? createdBy;
  final String? updateBy;
  final String? createdDate;
  final String? updatedDate;
  final dynamic materialNoteType;
  final dynamic currencyRate;
  final double? totalAmountCurrency;
  final dynamic finalDestination;
  final dynamic vesselNumber;
  final dynamic shipper;
  final dynamic cityOfLoading;
  final dynamic cityOfDischarge;
  final dynamic countryOfOriginOfGoods;
  final dynamic countryOfDestination;
  final dynamic currencyName;
  final int? partyCurrencyId;
  final dynamic enableEmail;
  final String? shipToAddress2;
  final dynamic advanceReceiptNumber;
  final dynamic advanceReceiptNumberId;
  final double? totalAdvanceAmount;
  final dynamic balanceAdvanceAmount;
  final double? totalPayableAmount;
  final List<dynamic>? advanceRecieptTracking;
  final dynamic internalNote;
  final int? shippingLocation;
  final int? shippingStateId;
  final int? paymentMethodId;
  final dynamic paymentDocumentNumber;
  final String? paymentDocumentDate;
  final dynamic paymentNote;
  final double? payingAmount;
  final int? isCashOnCarry;
  final dynamic cardTypeId;
  final int? classificationId;
  final String? mobileNo;
  final List<EmpRefMap>? empRefMap;
  final dynamic roudedOff;

  InvoiceHeaders({
    this.id,
    this.invoiceDate,
    this.gstNumber,
    this.invoiceNumber,
    this.invId,
    this.purchaseOrderDate,
    this.purchaseOrderNumber,
    this.purchaseOrderId,
    this.referenceDate,
    this.address,
    this.internalReferenceNumber,
    this.deliveryChallanDate,
    this.deliveryChallanNumber,
    this.stateId,
    this.stateName,
    this.paymentDueDate,
    this.eWayBillNumber,
    this.totalTaxableAmount,
    this.grandTotal,
    this.billToAddress,
    this.labourChargesOnly,
    this.subTotalAmount,
    this.paymentTerms,
    this.deliveryTerms,
    this.termsAndConditions,
    this.modeOfDispatch,
    this.vehicleNumber,
    this.numOfPackages,
    this.documentThrough,
    this.shipToAddress,
    this.totalDiscount,
    this.netAmount,
    this.transportationCharges,
    this.advanceAmount,
    this.isRoudedOff,
    this.roundOffAmount,
    this.proformaInvoiceNumber,
    this.proformaInvoiceDate,
    this.grnNumber,
    this.grnDate,
    this.sourceInvoiceNumber,
    this.sourceInvoiceDate,
    this.cessAmount,
    this.cessPercent,
    this.sgstTaxRate,
    this.sgstTaxAmount,
    this.cgstTaxRate,
    this.cgstTaxAmount,
    this.igstTaxRate,
    this.igstTaxAmount,
    this.companyId,
    this.discountAmount,
    this.discountPercent,
    this.dueAmount,
    this.financialYearId,
    this.internalReferenceDate,
    this.invoiceTypeId,
    this.isReverseCharge,
    this.partyId,
    this.partyName,
    this.remarks,
    this.email,
    this.pdfName,
    this.pdfNameWithTimeStamp,
    this.shippingPincode,
    this.invoiceItems,
    this.taxId,
    this.taxAmount,
    this.timeOfInvoice,
    this.vendorCode,
    this.statusId,
    this.statusName,
    this.inclusiveTax,
    this.deliveryChallanDateString,
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
    this.isReused,
    this.reusedInvoiceId,
    this.partyCode,
    this.transactionStatus,
    this.preTdsPer,
    this.preTdsAmount,
    this.tcsPercentage,
    this.tcsAmount,
    this.createdBy,
    this.updateBy,
    this.createdDate,
    this.updatedDate,
    this.materialNoteType,
    this.currencyRate,
    this.totalAmountCurrency,
    this.finalDestination,
    this.vesselNumber,
    this.shipper,
    this.cityOfLoading,
    this.cityOfDischarge,
    this.countryOfOriginOfGoods,
    this.countryOfDestination,
    this.currencyName,
    this.partyCurrencyId,
    this.enableEmail,
    this.shipToAddress2,
    this.advanceReceiptNumber,
    this.advanceReceiptNumberId,
    this.totalAdvanceAmount,
    this.balanceAdvanceAmount,
    this.totalPayableAmount,
    this.advanceRecieptTracking,
    this.internalNote,
    this.shippingLocation,
    this.shippingStateId,
    this.paymentMethodId,
    this.paymentDocumentNumber,
    this.paymentDocumentDate,
    this.paymentNote,
    this.payingAmount,
    this.isCashOnCarry,
    this.cardTypeId,
    this.classificationId,
    this.mobileNo,
    this.empRefMap,
    this.roudedOff,
  });

  InvoiceHeaders.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        invoiceDate = json['invoiceDate'] as String?,
        gstNumber = json['gstNumber'] as String?,
        invoiceNumber = json['invoiceNumber'] as String?,
        invId = json['invId'] as int?,
        purchaseOrderDate = json['purchaseOrderDate'],
        purchaseOrderNumber = json['purchaseOrderNumber'] as String?,
        purchaseOrderId = json['purchaseOrderId'],
        referenceDate = json['referenceDate'],
        address = json['address'] as String?,
        internalReferenceNumber = json['internalReferenceNumber'],
        deliveryChallanDate = json['deliveryChallanDate'],
        deliveryChallanNumber = json['deliveryChallanNumber'],
        stateId = json['stateId'] as int?,
        stateName = json['stateName'] as String?,
        paymentDueDate = json['paymentDueDate'] as String?,
        eWayBillNumber = json['eWayBillNumber'],
        totalTaxableAmount = json['totalTaxableAmount'] as double?,
        grandTotal = json['grandTotal'] as double?,
        billToAddress = json['billToAddress'] as String?,
        labourChargesOnly = json['labourChargesOnly'] as int?,
        subTotalAmount = json['subTotalAmount'] as double?,
        paymentTerms = json['paymentTerms'],
        deliveryTerms = json['deliveryTerms'],
        termsAndConditions = json['termsAndConditions'] as String?,
        modeOfDispatch = json['modeOfDispatch'],
        vehicleNumber = json['vehicleNumber'],
        numOfPackages = json['numOfPackages'],
        documentThrough = json['documentThrough'],
        shipToAddress = json['shipToAddress'] as String?,
        totalDiscount = json['totalDiscount'],
        netAmount = json['netAmount'] as double?,
        transportationCharges = json['transportationCharges'],
        advanceAmount = json['advanceAmount'],
        isRoudedOff = json['isRoudedOff'],
        roundOffAmount = json['roundOffAmount'] as double?,
        proformaInvoiceNumber = json['proformaInvoiceNumber'] as String?,
        proformaInvoiceDate = json['proformaInvoiceDate'],
        grnNumber = json['grnNumber'] as String?,
        grnDate = json['grnDate'],
        sourceInvoiceNumber = json['sourceInvoiceNumber'],
        sourceInvoiceDate = json['sourceInvoiceDate'],
        cessAmount = json['cessAmount'],
        cessPercent = json['cessPercent'],
        sgstTaxRate = json['sgstTaxRate'] as double?,
        sgstTaxAmount = json['sgstTaxAmount'],
        cgstTaxRate = json['cgstTaxRate'] as double?,
        cgstTaxAmount = json['cgstTaxAmount'],
        igstTaxRate = json['igstTaxRate'] as double?,
        igstTaxAmount = json['igstTaxAmount'] as double?,
        companyId = json['companyId'] as int?,
        discountAmount = json['discountAmount'],
        discountPercent = json['discountPercent'],
        dueAmount = json['dueAmount'] as double?,
        financialYearId = json['financialYearId'] as int?,
        internalReferenceDate = json['internalReferenceDate'],
        invoiceTypeId = json['invoiceTypeId'] as int?,
        isReverseCharge = json['isReverseCharge'] as int?,
        partyId = json['partyId'] as int?,
        partyName = json['partyName'] as String?,
        remarks = json['remarks'],
        email = json['email'],
        pdfName = json['pdfName'],
        pdfNameWithTimeStamp = json['pdfNameWithTimeStamp'],
        shippingPincode = json['shippingPincode'] as int?,
        invoiceItems = json['invoiceItems'],
        taxId = json['taxId'] as int?,
        taxAmount = json['taxAmount'] as double?,
        timeOfInvoice = json['timeOfInvoice'],
        vendorCode = json['vendorCode'],
        statusId = json['statusId'] as int?,
        statusName = json['statusName'] as String?,
        inclusiveTax = json['inclusiveTax'] as int?,
        deliveryChallanDateString = json['deliveryChallanDateString'],
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
        companyCeritificateImagePath = json['companyCeritificateImagePath'],
        companyLogoPath = json['companyLogoPath'] as String?,
        partyContactPersonNumber = json['partyContactPersonNumber'],
        partyPinCode = json['partyPinCode'] as String?,
        partyAreaId = json['partyAreaId'] as int?,
        partyCityId = json['partyCityId'] as int?,
        partyStateId = json['partyStateId'] as int?,
        partyCountryId = json['partyCountryId'] as int?,
        partyPrimaryTelephone = json['partyPrimaryTelephone'],
        partySecondaryTelephone = json['partySecondaryTelephone'],
        partyPrimaryMobile = json['partyPrimaryMobile'],
        partySecondaryMobile = json['partySecondaryMobile'],
        partyEmail = json['partyEmail'],
        partyWebsite = json['partyWebsite'],
        partyContactPersonName = json['partyContactPersonName'],
        partyBillToAddress = json['partyBillToAddress'],
        partyShipAddress = json['partyShipAddress'],
        partyDueDaysLimit = json['partyDueDaysLimit'],
        partyGstRegistrationTypeId = json['partyGstRegistrationTypeId'] as String?,
        partyGstNumber = json['partyGstNumber'],
        partyPanNumber = json['partyPanNumber'],
        isIgst = json['isIgst'] as String?,
        isReused = json['isReused'],
        reusedInvoiceId = json['reusedInvoiceId'],
        partyCode = json['partyCode'] as String?,
        transactionStatus = json['transactionStatus'],
        preTdsPer = json['preTdsPer'],
        preTdsAmount = json['preTdsAmount'],
        tcsPercentage = json['tcsPercentage'] as double?,
        tcsAmount = json['tcsAmount'] as double?,
        createdBy = json['createdBy'] as String?,
        updateBy = json['updateBy'] as String?,
        createdDate = json['createdDate'] as String?,
        updatedDate = json['updatedDate'] as String?,
        materialNoteType = json['materialNoteType'],
        currencyRate = json['currencyRate'],
        totalAmountCurrency = json['totalAmountCurrency'] as double?,
        finalDestination = json['finalDestination'],
        vesselNumber = json['vesselNumber'],
        shipper = json['shipper'],
        cityOfLoading = json['cityOfLoading'],
        cityOfDischarge = json['cityOfDischarge'],
        countryOfOriginOfGoods = json['countryOfOriginOfGoods'],
        countryOfDestination = json['countryOfDestination'],
        currencyName = json['currencyName'],
        partyCurrencyId = json['partyCurrencyId'] as int?,
        enableEmail = json['enableEmail'],
        shipToAddress2 = json['shipToAddress2'] as String?,
        advanceReceiptNumber = json['advanceReceiptNumber'],
        advanceReceiptNumberId = json['advanceReceiptNumberId'],
        totalAdvanceAmount = json['totalAdvanceAmount'] as double?,
        balanceAdvanceAmount = json['balanceAdvanceAmount'],
        totalPayableAmount = json['totalPayableAmount'] as double?,
        advanceRecieptTracking = json['advanceRecieptTracking'] as List?,
        internalNote = json['internalNote'],
        shippingLocation = json['shippingLocation'] as int?,
        shippingStateId = json['shippingStateId'] as int?,
        paymentMethodId = json['paymentMethodId'] as int?,
        paymentDocumentNumber = json['paymentDocumentNumber'],
        paymentDocumentDate = json['paymentDocumentDate'] as String?,
        paymentNote = json['paymentNote'],
        payingAmount = json['payingAmount'] as double?,
        isCashOnCarry = json['isCashOnCarry'] as int?,
        cardTypeId = json['cardTypeId'],
        classificationId = json['classificationId'] as int?,
        mobileNo = json['mobileNo'] as String?,
        empRefMap = (json['empRefMap'] as List?)?.map((dynamic e) => EmpRefMap.fromJson(e as Map<String, dynamic>)).toList(),
        roudedOff = json['roudedOff'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'invoiceDate': invoiceDate,
        'gstNumber': gstNumber,
        'invoiceNumber': invoiceNumber,
        'invId': invId,
        'purchaseOrderDate': purchaseOrderDate,
        'purchaseOrderNumber': purchaseOrderNumber,
        'purchaseOrderId': purchaseOrderId,
        'referenceDate': referenceDate,
        'address': address,
        'internalReferenceNumber': internalReferenceNumber,
        'deliveryChallanDate': deliveryChallanDate,
        'deliveryChallanNumber': deliveryChallanNumber,
        'stateId': stateId,
        'stateName': stateName,
        'paymentDueDate': paymentDueDate,
        'eWayBillNumber': eWayBillNumber,
        'totalTaxableAmount': totalTaxableAmount,
        'grandTotal': grandTotal,
        'billToAddress': billToAddress,
        'labourChargesOnly': labourChargesOnly,
        'subTotalAmount': subTotalAmount,
        'paymentTerms': paymentTerms,
        'deliveryTerms': deliveryTerms,
        'termsAndConditions': termsAndConditions,
        'modeOfDispatch': modeOfDispatch,
        'vehicleNumber': vehicleNumber,
        'numOfPackages': numOfPackages,
        'documentThrough': documentThrough,
        'shipToAddress': shipToAddress,
        'totalDiscount': totalDiscount,
        'netAmount': netAmount,
        'transportationCharges': transportationCharges,
        'advanceAmount': advanceAmount,
        'isRoudedOff': isRoudedOff,
        'roundOffAmount': roundOffAmount,
        'proformaInvoiceNumber': proformaInvoiceNumber,
        'proformaInvoiceDate': proformaInvoiceDate,
        'grnNumber': grnNumber,
        'grnDate': grnDate,
        'sourceInvoiceNumber': sourceInvoiceNumber,
        'sourceInvoiceDate': sourceInvoiceDate,
        'cessAmount': cessAmount,
        'cessPercent': cessPercent,
        'sgstTaxRate': sgstTaxRate,
        'sgstTaxAmount': sgstTaxAmount,
        'cgstTaxRate': cgstTaxRate,
        'cgstTaxAmount': cgstTaxAmount,
        'igstTaxRate': igstTaxRate,
        'igstTaxAmount': igstTaxAmount,
        'companyId': companyId,
        'discountAmount': discountAmount,
        'discountPercent': discountPercent,
        'dueAmount': dueAmount,
        'financialYearId': financialYearId,
        'internalReferenceDate': internalReferenceDate,
        'invoiceTypeId': invoiceTypeId,
        'isReverseCharge': isReverseCharge,
        'partyId': partyId,
        'partyName': partyName,
        'remarks': remarks,
        'email': email,
        'pdfName': pdfName,
        'pdfNameWithTimeStamp': pdfNameWithTimeStamp,
        'shippingPincode': shippingPincode,
        'invoiceItems': invoiceItems,
        'taxId': taxId,
        'taxAmount': taxAmount,
        'timeOfInvoice': timeOfInvoice,
        'vendorCode': vendorCode,
        'statusId': statusId,
        'statusName': statusName,
        'inclusiveTax': inclusiveTax,
        'deliveryChallanDateString': deliveryChallanDateString,
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
        'isReused': isReused,
        'reusedInvoiceId': reusedInvoiceId,
        'partyCode': partyCode,
        'transactionStatus': transactionStatus,
        'preTdsPer': preTdsPer,
        'preTdsAmount': preTdsAmount,
        'tcsPercentage': tcsPercentage,
        'tcsAmount': tcsAmount,
        'createdBy': createdBy,
        'updateBy': updateBy,
        'createdDate': createdDate,
        'updatedDate': updatedDate,
        'materialNoteType': materialNoteType,
        'currencyRate': currencyRate,
        'totalAmountCurrency': totalAmountCurrency,
        'finalDestination': finalDestination,
        'vesselNumber': vesselNumber,
        'shipper': shipper,
        'cityOfLoading': cityOfLoading,
        'cityOfDischarge': cityOfDischarge,
        'countryOfOriginOfGoods': countryOfOriginOfGoods,
        'countryOfDestination': countryOfDestination,
        'currencyName': currencyName,
        'partyCurrencyId': partyCurrencyId,
        'enableEmail': enableEmail,
        'shipToAddress2': shipToAddress2,
        'advanceReceiptNumber': advanceReceiptNumber,
        'advanceReceiptNumberId': advanceReceiptNumberId,
        'totalAdvanceAmount': totalAdvanceAmount,
        'balanceAdvanceAmount': balanceAdvanceAmount,
        'totalPayableAmount': totalPayableAmount,
        'advanceRecieptTracking': advanceRecieptTracking,
        'internalNote': internalNote,
        'shippingLocation': shippingLocation,
        'shippingStateId': shippingStateId,
        'paymentMethodId': paymentMethodId,
        'paymentDocumentNumber': paymentDocumentNumber,
        'paymentDocumentDate': paymentDocumentDate,
        'paymentNote': paymentNote,
        'payingAmount': payingAmount,
        'isCashOnCarry': isCashOnCarry,
        'cardTypeId': cardTypeId,
        'classificationId': classificationId,
        'mobileNo': mobileNo,
        'empRefMap': empRefMap?.map((e) => e.toJson()).toList(),
        'roudedOff': roudedOff
      };
}

class EmpRefMap {
  final InternalReferralScheme? internalReferralScheme;
  final dynamic employeeId;
  final int? employeeRating;

  EmpRefMap({
    this.internalReferralScheme,
    this.employeeId,
    this.employeeRating,
  });

  EmpRefMap.fromJson(Map<String, dynamic> json)
      : internalReferralScheme = (json['internalReferralScheme'] as Map<String, dynamic>?) != null ? InternalReferralScheme.fromJson(json['internalReferralScheme'] as Map<String, dynamic>) : null,
        employeeId = json['employeeId'],
        employeeRating = json['employeeRating'] as int?;

  Map<String, dynamic> toJson() => {'internalReferralScheme': internalReferralScheme?.toJson(), 'employeeId': employeeId, 'employeeRating': employeeRating};
}

class InternalReferralScheme {
  final int? id;
  final String? name;
  final int? attributeId;
  final List<String>? attributeValueIds;
  final String? deleted;

  InternalReferralScheme({
    this.id,
    this.name,
    this.attributeId,
    this.attributeValueIds,
    this.deleted,
  });

  InternalReferralScheme.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        attributeId = json['attributeId'] as int?,
        attributeValueIds = (json['attributeValueIds'] as List?)?.map((dynamic e) => e as String).toList(),
        deleted = json['deleted'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'attributeId': attributeId, 'attributeValueIds': attributeValueIds, 'deleted': deleted};
}
