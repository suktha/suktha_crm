class InvoiceModel {
  String? id;
  String? invoiceDate;
  String? gstNumber;
  String? invoiceNumber;
  int? invId;
  dynamic purchaseOrderDate;
  String? purchaseOrderNumber;
  dynamic purchaseOrderId;
  dynamic referenceDate;
  String? address;
  dynamic internalReferenceNumber;
  dynamic deliveryChallanDate;
  String? deliveryChallanNumber;
  int? stateId;
  String? stateName;
  String? paymentDueDate;
  dynamic eWayBillNumber;
  double? totalTaxableAmount;
  double? grandTotal;
  String? billToAddress;
  int? labourChargesOnly;
  double? subTotalAmount;
  dynamic paymentTerms;
  dynamic deliveryTerms;
  dynamic termsAndConditions;
  dynamic modeOfDispatch;
  dynamic vehicleNumber;
  dynamic numOfPackages;
  dynamic documentThrough;
  String? shipToAddress;
  double? totalDiscount;
  double? netAmount;
  dynamic transportationCharges;
  dynamic advanceAmount;
  dynamic isRoudedOff;
  double? roundOffAmount;
  String? proformaInvoiceNumber;
  dynamic proformaInvoiceDate;
  String? grnNumber;
  dynamic grnDate;
  dynamic sourceInvoiceNumber;
  dynamic sourceInvoiceDate;
  dynamic cessAmount;
  dynamic cessPercent;
  dynamic sgstTaxRate;
  double? sgstTaxAmount;
  dynamic cgstTaxRate;
  double? cgstTaxAmount;
  dynamic igstTaxRate;
  double? igstTaxAmount;
  int? companyId;
  double? discountAmount;
  double? discountPercent;
  double? dueAmount;
  int? financialYearId;
  dynamic internalReferenceDate;
  int? invoiceTypeId;
  int? isReverseCharge;
  int? partyId;
  String? partyName;
  dynamic remarks;
  dynamic email;
  dynamic pdfName;
  dynamic pdfNameWithTimeStamp;
  dynamic shippingPincode;
  List<InvoiceItems>? invoiceItems;
  dynamic taxId;
  double? taxAmount;
  dynamic timeOfInvoice;
  dynamic vendorCode;
  int? statusId;
  String? statusName;
  int? inclusiveTax;
  dynamic deliveryChallanDateString;
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
  String? partyPinCode;
  dynamic partyAreaId;
  int? partyCityId;
  int? partyStateId;
  int? partyCountryId;
  dynamic partyPrimaryTelephone;
  dynamic partySecondaryTelephone;
  dynamic partyPrimaryMobile;
  dynamic partySecondaryMobile;
  dynamic partyEmail;
  dynamic partyWebsite;
  dynamic partyContactPersonName;
  dynamic partyBillToAddress;
  dynamic partyShipAddress;
  dynamic partyDueDaysLimit;
  String? partyGstRegistrationTypeId;
  dynamic partyGstNumber;
  dynamic partyPanNumber;
  String? isIgst;
  dynamic isReused;
  dynamic reusedInvoiceId;
  String? partyCode;
  dynamic transactionStatus;
  dynamic preTdsPer;
  dynamic preTdsAmount;
  double? tcsPercentage;
  double? tcsAmount;
  String? createdBy;
  String? updateBy;
  String? createdDate;
  String? updatedDate;
  dynamic materialNoteType;
  dynamic currencyRate;
  double? totalAmountCurrency;
  dynamic finalDestination;
  dynamic vesselNumber;
  dynamic shipper;
  dynamic cityOfLoading;
  dynamic cityOfDischarge;
  dynamic countryOfOriginOfGoods;
  dynamic countryOfDestination;
  dynamic currencyName;
  int? partyCurrencyId;
  dynamic enableEmail;
  dynamic shipToAddress2;
  dynamic advanceReceiptNumber;
  dynamic advanceReceiptNumberId;
  double? totalAdvanceAmount;
  dynamic balanceAdvanceAmount;
  dynamic totalPayableAmount;
  final List<AdvanceRecieptTracking>? advanceRecieptTracking;
  dynamic internalNote;
  int? shippingLocation;
  int? shippingStateId;
  int? paymentMethodId;
  dynamic paymentDocumentNumber;
  String? paymentDocumentDate;
  dynamic paymentNote;
  double? payingAmount;
  int? isCashOnCarry;
  dynamic cardTypeId;
  dynamic classificationId;
  dynamic mobileNo;
  List<EmpRefMap>? empRefMap;
  String? shippingGstIn;
  int? isSubscriptionBasedService;
  dynamic roudedOff;

  InvoiceModel({
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
    this.shippingGstIn,
    this.isSubscriptionBasedService,
    this.roudedOff,
  });

  InvoiceModel.fromJson(Map<String, dynamic> json)
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
        deliveryChallanNumber = json['deliveryChallanNumber'] as String?,
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
        termsAndConditions = json['termsAndConditions'],
        modeOfDispatch = json['modeOfDispatch'],
        vehicleNumber = json['vehicleNumber'],
        numOfPackages = json['numOfPackages'],
        documentThrough = json['documentThrough'],
        shipToAddress = json['shipToAddress'] as String?,
        totalDiscount = json['totalDiscount'] as double?,
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
        sgstTaxRate = json['sgstTaxRate'],
        sgstTaxAmount = json['sgstTaxAmount'] as double?,
        cgstTaxRate = json['cgstTaxRate'],
        cgstTaxAmount = json['cgstTaxAmount'] as double?,
        igstTaxRate = json['igstTaxRate'],
        igstTaxAmount = json['igstTaxAmount'] as double?,
        companyId = json['companyId'] as int?,
        discountAmount = json['discountAmount'] as double?,
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
        shippingPincode = json['shippingPincode'],
        invoiceItems = (json['invoiceItems'] as List?)?.map((dynamic e) => InvoiceItems.fromJson(e as Map<String, dynamic>)).toList(),
        taxId = json['taxId'],
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
        companySecondaryTelephone = json['companySecondaryTelephone'] as String?,
        companyWebsite = json['companyWebsite'] as String?,
        companyEmail = json['companyEmail'] as String?,
        companyFaxNumber = json['companyFaxNumber'] as String?,
        companyAddress = json['companyAddress'] as String?,
        companyTagLine = json['companyTagLine'] as String?,
        companyGstNumber = json['companyGstNumber'] as String?,
        companyPanNumber = json['companyPanNumber'] as String?,
        companyPanDate = json['companyPanDate'] as String?,
        companyCeritificateImagePath = json['companyCeritificateImagePath'],
        companyLogoPath = json['companyLogoPath'] as String?,
        partyContactPersonNumber = json['partyContactPersonNumber'],
        partyPinCode = json['partyPinCode'] as String?,
        partyAreaId = json['partyAreaId'],
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
        shipToAddress2 = json['shipToAddress2'],
        advanceReceiptNumber = json['advanceReceiptNumber'],
        advanceReceiptNumberId = json['advanceReceiptNumberId'],
        totalAdvanceAmount = json['totalAdvanceAmount'] as double?,
        balanceAdvanceAmount = json['balanceAdvanceAmount'],
        totalPayableAmount = json['totalPayableAmount'],
        advanceRecieptTracking = (json['advanceRecieptTracking'] as List?)
            ?.map((dynamic e) => AdvanceRecieptTracking.fromJson(e as Map<String, dynamic>))
            .toList(),
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
        classificationId = json['classificationId'],
        mobileNo = json['mobileNo'],
        shippingGstIn = json['shippingGstIn'],
        isSubscriptionBasedService = json['isSubscriptionBasedService'],
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
        'invoiceItems': invoiceItems?.map((e) => e.toJson()).toList(),
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
        'advanceRecieptTracking': advanceRecieptTracking?.map((e) => e.toJson()).toList(),
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
        'shippingGstIn': shippingGstIn,
        'isSubscriptionBasedService': isSubscriptionBasedService,
        'empRefMap': empRefMap?.map((e) => e.toJson()).toList(),
        'roudedOff': roudedOff
        
      };
}

class InvoiceItems {
  String? id;
  String? headerId;
  int? slNo;
  int? materialId;
  double? quantity;
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
  dynamic purchaseOrderHeaderId;
  dynamic purchaseOrderItemId;
  dynamic grnHeaderId;
  dynamic grnItemId;
  dynamic deliveryChallanHeaderId;
  dynamic deliveryChallanItemId;
  dynamic proformaInvoiceHeaderId;
  dynamic proformaInvoiceItemId;
  dynamic sourceInvoiceHeaderId;
  dynamic sourceInvoiceItemId;
  int? unitOfMeasurementId;
  int? taxId;
  dynamic partNumber;
  dynamic hsnOrSac;
  String? partName;
  String? uom;
  int? inclusiveTax;
  double? noteBalanceQuantity;
  dynamic specification;
  String? processId;
  String? processName;
  int? isContainer;
  dynamic outName;
  dynamic outPartNumber;
     dynamic commission;
   dynamic garmentsEmployeeRating;
   dynamic nightEmployeeRating;
   int? isSubscriptionBasedService;
   String? serviceStartDate;
    String? serviceEndDate;
    int? serviceFrequencyCount;


  InvoiceItems({
    this.id,
    this.headerId,
    this.slNo,
    this.materialId,
    this.quantity,
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
    this.purchaseOrderHeaderId,
    this.purchaseOrderItemId,
    this.grnHeaderId,
    this.grnItemId,
    this.deliveryChallanHeaderId,
    this.deliveryChallanItemId,
    this.proformaInvoiceHeaderId,
    this.proformaInvoiceItemId,
    this.sourceInvoiceHeaderId,
    this.sourceInvoiceItemId,
    this.unitOfMeasurementId,
    this.taxId,
    this.partNumber,
    this.hsnOrSac,
    this.partName,
    this.uom,
    this.inclusiveTax,
    this.noteBalanceQuantity,
    this.specification,
    this.processId,
    this.processName,
    this.isContainer,
    this.outName,
    this.outPartNumber,
     this.commission,
    this.garmentsEmployeeRating,
    this.nightEmployeeRating,
    this.isSubscriptionBasedService,
    this.serviceStartDate,
    this.serviceEndDate,
    this.serviceFrequencyCount
  });

  InvoiceItems.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        headerId = json['headerId'] as String?,
        slNo = json['slNo'] as int?,
        materialId = json['materialId'] as int?,
        quantity = json['quantity'] as double?,
        price = json['price'] as double?,
        amount = json['amount'] as double?,
        discountPercentage = json['discountPercentage'] as double?,
        discountAmount = json['discountAmount'] as double?,
        amountAfterDiscount = json['amountAfterDiscount'] as double?,
        transportationAmount = json['transportationAmount'],
        cessPercentage = json['cessPercentage'],
        cessAmount = json['cessAmount'],
        igstTaxPercentage = json['igstTaxPercentage'] as double?,
        igstTaxAmount = json['igstTaxAmount'] as double?,
        sgstTaxPercentage = json['sgstTaxPercentage'] as double?,
        sgstTaxAmount = json['sgstTaxAmount'] as double?,
        cgstTaxPercentage = json['cgstTaxPercentage'] as double?,
        cgstTaxAmount = json['cgstTaxAmount'] as double?,
        amountAfterTax = json['amountAfterTax'] as double?,
        remarks = json['remarks'] as String?,
        purchaseOrderHeaderId = json['purchaseOrderHeaderId'],
        purchaseOrderItemId = json['purchaseOrderItemId'],
        grnHeaderId = json['grnHeaderId'],
        grnItemId = json['grnItemId'],
        deliveryChallanHeaderId = json['deliveryChallanHeaderId'],
        deliveryChallanItemId = json['deliveryChallanItemId'],
        proformaInvoiceHeaderId = json['proformaInvoiceHeaderId'],
        proformaInvoiceItemId = json['proformaInvoiceItemId'],
        sourceInvoiceHeaderId = json['sourceInvoiceHeaderId'],
        sourceInvoiceItemId = json['sourceInvoiceItemId'],
        unitOfMeasurementId = json['unitOfMeasurementId'] as int?,
        taxId = json['taxId'] as int?,
        partNumber = json['partNumber'],
        hsnOrSac = json['hsnOrSac'],
        partName = json['partName'] as String?,
        uom = json['uom'] as String?,
        inclusiveTax = json['inclusiveTax'] as int?,
        noteBalanceQuantity = json['noteBalanceQuantity'] as double?,
        specification = json['specification'],
        processId = json['processId'] as String?,
        processName = json['processName'] as String?,
        isContainer = json['isContainer'] as int?,
        outName = json['outName'],
        outPartNumber = json['outPartNumber'],
           commission = json['commission'],
        garmentsEmployeeRating = json['garmentsEmployeeRating'],
        nightEmployeeRating = json['nightEmployeeRating'],
        isSubscriptionBasedService = json['isSubscriptionBasedService'],
        serviceStartDate = json['serviceStartDate'],
        serviceEndDate = json['serviceEndDate'],
        serviceFrequencyCount = json['serviceFrequencyCount'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'headerId': headerId,
        'slNo': slNo,
        'materialId': materialId,
        'quantity': quantity,
        'price': price,
        'amount': amount,
        'discountPercentage': discountPercentage,
        'discountAmount': discountAmount,
        'amountAfterDiscount': amountAfterDiscount,
        'transportationAmount': transportationAmount,
        'cessPercentage': cessPercentage,
        'cessAmount': cessAmount,
        'igstTaxPercentage': igstTaxPercentage,
        'igstTaxAmount': igstTaxAmount,
        'sgstTaxPercentage': sgstTaxPercentage,
        'sgstTaxAmount': sgstTaxAmount,
        'cgstTaxPercentage': cgstTaxPercentage,
        'cgstTaxAmount': cgstTaxAmount,
        'amountAfterTax': amountAfterTax,
        'remarks': remarks,
        'purchaseOrderHeaderId': purchaseOrderHeaderId,
        'purchaseOrderItemId': purchaseOrderItemId,
        'grnHeaderId': grnHeaderId,
        'grnItemId': grnItemId,
        'deliveryChallanHeaderId': deliveryChallanHeaderId,
        'deliveryChallanItemId': deliveryChallanItemId,
        'proformaInvoiceHeaderId': proformaInvoiceHeaderId,
        'proformaInvoiceItemId': proformaInvoiceItemId,
        'sourceInvoiceHeaderId': sourceInvoiceHeaderId,
        'sourceInvoiceItemId': sourceInvoiceItemId,
        'unitOfMeasurementId': unitOfMeasurementId,
        'taxId': taxId,
        'partNumber': partNumber,
        'hsnOrSac': hsnOrSac,
        'partName': partName,
        'uom': uom,
        'inclusiveTax': inclusiveTax,
        'noteBalanceQuantity': noteBalanceQuantity,
        'specification': specification,
        'processId': processId,
        'processName': processName,
        'isContainer': isContainer,
        'outName': outName,
        'outPartNumber': outPartNumber,
           'commission': commission,
        'garmentsEmployeeRating': garmentsEmployeeRating,
        'nightEmployeeRating': nightEmployeeRating,
        'isSubscriptionBasedService': isSubscriptionBasedService,
        'serviceStartDate': serviceStartDate,
        'serviceEndDate': serviceEndDate,
        'serviceFrequencyCount': serviceFrequencyCount
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
      : internalReferralScheme = (json['internalReferralScheme'] as Map<String, dynamic>?) != null
            ? InternalReferralScheme.fromJson(json['internalReferralScheme'] as Map<String, dynamic>)
            : null,
        employeeId = json['employeeId'],
        employeeRating = json['employeeRating'] as int?;

  Map<String, dynamic> toJson() =>
      {'internalReferralScheme': internalReferralScheme?.toJson(), 'employeeId': employeeId, 'employeeRating': employeeRating};
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

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'attributeId': attributeId, 'attributeValueIds': attributeValueIds, 'deleted': deleted};
}


class AdvanceRecieptTracking {
  final String? advanceReceiptNumber;
  final int? advanceReceiptId;
  final double? advanceAmountUsed;
  final double? totalBalanceAdvanceAmount;
  final double? balanceAdvanceAmt;
  final String? deleted;
  final dynamic invoiceHeader;
  AdvanceRecieptTracking({
    this.advanceReceiptNumber,
    this.advanceReceiptId,
    this.advanceAmountUsed,
    this.totalBalanceAdvanceAmount,
    this.balanceAdvanceAmt,
    this.deleted,
    this.invoiceHeader,
  });
  AdvanceRecieptTracking.fromJson(Map<String, dynamic> json)
      : advanceReceiptNumber = json['advanceReceiptNumber'] as String?,
        advanceReceiptId = json['advanceReceiptId'] as int?,
        advanceAmountUsed = json['advanceAmountUsed'] as double?,
        totalBalanceAdvanceAmount = json['totalBalanceAdvanceAmount'] as double?,
        balanceAdvanceAmt = json['balanceAdvanceAmt'] as double?,
        deleted = json['deleted'] as String?,
        invoiceHeader = json['invoiceHeader'];
  Map<String, dynamic> toJson() => {
        'advanceReceiptNumber': advanceReceiptNumber,
        'advanceReceiptId': advanceReceiptId,
        'advanceAmountUsed': advanceAmountUsed,
        'totalBalanceAdvanceAmount': totalBalanceAdvanceAmount,
        'balanceAdvanceAmt': balanceAdvanceAmt,
        'deleted': deleted,
        'invoiceHeader': invoiceHeader
      };
}
