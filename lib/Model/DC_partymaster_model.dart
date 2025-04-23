class DCTansactionTypeModel {
  final List<DeliveryChallanHeaders>? deliveryChallanHeaders;
  final int? totalCount;

  DCTansactionTypeModel({
    this.deliveryChallanHeaders,
    this.totalCount,
  });

  DCTansactionTypeModel.fromJson(Map<String, dynamic> json)
      : deliveryChallanHeaders = (json['deliveryChallanHeaders'] as List?)?.map((dynamic e) => DeliveryChallanHeaders.fromJson(e as Map<String, dynamic>)).toList(),
        totalCount = json['totalCount'] as int?;

  Map<String, dynamic> toJson() => {'deliveryChallanHeaders': deliveryChallanHeaders?.map((e) => e.toJson()).toList(), 'totalCount': totalCount};
}

class DeliveryChallanHeaders {
  final String? id;
  final String? deliveryChallanNumber;
  final int? deliveryChallanId;
  final String? deliveryChallanDate;
  final dynamic internalReferenceNumber;
  final dynamic internalReferenceDate;
  final dynamic purchaseOrderNumber;
  final dynamic purchaseOrderDate;
  final int? deliveryChallanTypeId;
  final int? partyId;
  final dynamic officeAddress;
  final dynamic deliveryAddress;
  final dynamic dispatchDate;
  final dynamic inspectedBy;
  final dynamic inspectionDate;
  final dynamic modeOfDispatch;
  final dynamic vehicleNumber;
  final dynamic deliveryNote;
  final double? totalQuantity;
  final int? statusId;
  final int? financialYearId;
  final int? companyId;
  final dynamic numberOfPackages;
  final dynamic deliveryTerms;
  final dynamic termsAndConditions;
  final dynamic paymentTerms;
  final dynamic dispatchTime;
  final int? taxId;
  final dynamic labourChargesOnly;
  final dynamic inDeliveryChallanNumber;
  final dynamic inDeliveryChallanDate;
  final dynamic returnableDeliveryChallan;
  final dynamic nonReturnableDeliveryChallan;
  final dynamic notForSale;
  final dynamic forSale;
  final dynamic returnForJobWork;
  final dynamic modeOfDispatchStatus;
  final dynamic vehicleNumberStatus;
  final dynamic numberOfPackagesStatus;
  final dynamic personName;
  final dynamic sgstTaxRate;
  final dynamic sgstTaxAmount;
  final dynamic cgstTaxRate;
  final dynamic cgstTaxAmount;
  final dynamic igstTaxRate;
  final dynamic igstTaxAmount;
  final double? taxAmount;
  final dynamic price;
  final dynamic amount;
  final dynamic eWayBill;
  final double? balanceQuantity;
  final List<DeliveryChallanItems>? deliveryChallanItems;
  final String? statusName;
  final String? partyName;
  final dynamic discountPercentage;
  final dynamic discountAmount;
  final dynamic amountAfterDiscount;
  final dynamic remarks;
  final String? gstNumber;
  final String? address;
  final int? inclusiveTax;
  final String? billToAddress;
  final String? shipToAddress;
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
  final dynamic companyLogoPath;
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
  final String? partyCode;
  final String? createdBy;
  final String? updateBy;
  final String? createdDate;
  final String? updatedDate;
  final dynamic jwNoteId;
  final dynamic email;
  final dynamic internalNote;

  DeliveryChallanHeaders({
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
    this.email,
    this.internalNote,
  });

  DeliveryChallanHeaders.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        deliveryChallanNumber = json['deliveryChallanNumber'] as String?,
        deliveryChallanId = json['deliveryChallanId'] as int?,
        deliveryChallanDate = json['deliveryChallanDate'] as String?,
        internalReferenceNumber = json['internalReferenceNumber'],
        internalReferenceDate = json['internalReferenceDate'],
        purchaseOrderNumber = json['purchaseOrderNumber'],
        purchaseOrderDate = json['purchaseOrderDate'],
        deliveryChallanTypeId = json['deliveryChallanTypeId'] as int?,
        partyId = json['partyId'] as int?,
        officeAddress = json['officeAddress'],
        deliveryAddress = json['deliveryAddress'],
        dispatchDate = json['dispatchDate'],
        inspectedBy = json['inspectedBy'],
        inspectionDate = json['inspectionDate'],
        modeOfDispatch = json['modeOfDispatch'],
        vehicleNumber = json['vehicleNumber'],
        deliveryNote = json['deliveryNote'],
        totalQuantity = json['totalQuantity'] as double?,
        statusId = json['statusId'] as int?,
        financialYearId = json['financialYearId'] as int?,
        companyId = json['companyId'] as int?,
        numberOfPackages = json['numberOfPackages'],
        deliveryTerms = json['deliveryTerms'],
        termsAndConditions = json['termsAndConditions'],
        paymentTerms = json['paymentTerms'],
        dispatchTime = json['dispatchTime'],
        taxId = json['taxId'] as int?,
        labourChargesOnly = json['labourChargesOnly'],
        inDeliveryChallanNumber = json['inDeliveryChallanNumber'],
        inDeliveryChallanDate = json['inDeliveryChallanDate'],
        returnableDeliveryChallan = json['returnableDeliveryChallan'],
        nonReturnableDeliveryChallan = json['nonReturnableDeliveryChallan'],
        notForSale = json['notForSale'],
        forSale = json['forSale'],
        returnForJobWork = json['returnForJobWork'],
        modeOfDispatchStatus = json['modeOfDispatchStatus'],
        vehicleNumberStatus = json['vehicleNumberStatus'],
        numberOfPackagesStatus = json['numberOfPackagesStatus'],
        personName = json['personName'],
        sgstTaxRate = json['sgstTaxRate'],
        sgstTaxAmount = json['sgstTaxAmount'],
        cgstTaxRate = json['cgstTaxRate'],
        cgstTaxAmount = json['cgstTaxAmount'],
        igstTaxRate = json['igstTaxRate'],
        igstTaxAmount = json['igstTaxAmount'],
        taxAmount = json['taxAmount'] as double?,
        price = json['price'],
        amount = json['amount'],
        eWayBill = json['eWayBill'],
        balanceQuantity = json['balanceQuantity'] as double?,
        deliveryChallanItems = (json['deliveryChallanItems'] as List?)?.map((dynamic e) => DeliveryChallanItems.fromJson(e as Map<String, dynamic>)).toList(),
        statusName = json['statusName'] as String?,
        partyName = json['partyName'] as String?,
        discountPercentage = json['discountPercentage'],
        discountAmount = json['discountAmount'],
        amountAfterDiscount = json['amountAfterDiscount'],
        remarks = json['remarks'],
        gstNumber = json['gstNumber'] as String?,
        address = json['address'] as String?,
        inclusiveTax = json['inclusiveTax'] as int?,
        billToAddress = json['billToAddress'] as String?,
        shipToAddress = json['shipToAddress'] as String?,
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
        companyLogoPath = json['companyLogoPath'],
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
        partyCode = json['partyCode'] as String?,
        createdBy = json['createdBy'] as String?,
        updateBy = json['updateBy'] as String?,
        createdDate = json['createdDate'] as String?,
        updatedDate = json['updatedDate'] as String?,
        jwNoteId = json['jwNoteId'],
        email = json['email'],
        internalNote = json['internalNote'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'deliveryChallanNumber': deliveryChallanNumber,
        'deliveryChallanId': deliveryChallanId,
        'deliveryChallanDate': deliveryChallanDate,
        'internalReferenceNumber': internalReferenceNumber,
        'internalReferenceDate': internalReferenceDate,
        'purchaseOrderNumber': purchaseOrderNumber,
        'purchaseOrderDate': purchaseOrderDate,
        'deliveryChallanTypeId': deliveryChallanTypeId,
        'partyId': partyId,
        'officeAddress': officeAddress,
        'deliveryAddress': deliveryAddress,
        'dispatchDate': dispatchDate,
        'inspectedBy': inspectedBy,
        'inspectionDate': inspectionDate,
        'modeOfDispatch': modeOfDispatch,
        'vehicleNumber': vehicleNumber,
        'deliveryNote': deliveryNote,
        'totalQuantity': totalQuantity,
        'statusId': statusId,
        'financialYearId': financialYearId,
        'companyId': companyId,
        'numberOfPackages': numberOfPackages,
        'deliveryTerms': deliveryTerms,
        'termsAndConditions': termsAndConditions,
        'paymentTerms': paymentTerms,
        'dispatchTime': dispatchTime,
        'taxId': taxId,
        'labourChargesOnly': labourChargesOnly,
        'inDeliveryChallanNumber': inDeliveryChallanNumber,
        'inDeliveryChallanDate': inDeliveryChallanDate,
        'returnableDeliveryChallan': returnableDeliveryChallan,
        'nonReturnableDeliveryChallan': nonReturnableDeliveryChallan,
        'notForSale': notForSale,
        'forSale': forSale,
        'returnForJobWork': returnForJobWork,
        'modeOfDispatchStatus': modeOfDispatchStatus,
        'vehicleNumberStatus': vehicleNumberStatus,
        'numberOfPackagesStatus': numberOfPackagesStatus,
        'personName': personName,
        'sgstTaxRate': sgstTaxRate,
        'sgstTaxAmount': sgstTaxAmount,
        'cgstTaxRate': cgstTaxRate,
        'cgstTaxAmount': cgstTaxAmount,
        'igstTaxRate': igstTaxRate,
        'igstTaxAmount': igstTaxAmount,
        'taxAmount': taxAmount,
        'price': price,
        'amount': amount,
        'eWayBill': eWayBill,
        'balanceQuantity': balanceQuantity,
        'deliveryChallanItems': deliveryChallanItems?.map((e) => e.toJson()).toList(),
        'statusName': statusName,
        'partyName': partyName,
        'discountPercentage': discountPercentage,
        'discountAmount': discountAmount,
        'amountAfterDiscount': amountAfterDiscount,
        'remarks': remarks,
        'gstNumber': gstNumber,
        'address': address,
        'inclusiveTax': inclusiveTax,
        'billToAddress': billToAddress,
        'shipToAddress': shipToAddress,
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
        'jwNoteId': jwNoteId,
        'email': email,
        'internalNote': internalNote
      };
}

class DeliveryChallanItems {
  final String? id;
  final String? headerId;
  final int? materialId;
  final int? slNo;
  final String? materialName;
  final double? quantity;
  final String? remarks;
  final dynamic status;
  final dynamic purchaseOrderHeaderId;
  final dynamic purchaseOrderItemId;
  final dynamic price;
  final double? amount;
  final int? unitOfMeasurementId;
  final int? taxId;
  final dynamic taxRate;
  final dynamic deliveryChallanType;
  final dynamic deliveryChallanItemStatus;
  final dynamic processId;
  final double? invoiceBalanceQuantity;
  final dynamic batchCode;
  final dynamic purchaseOrderNumber;
  final dynamic batchCodeId;
  final dynamic inDeliveryChallanNumber;
  final dynamic inDeliveryChallanDate;
  final double? sgstTaxPercentage;
  final double? sgstTaxAmount;
  final double? cgstTaxPercentage;
  final double? cgstTaxAmount;
  final double? igstTaxPercentage;
  final double? igstTaxAmount;
  final dynamic taxAmount;
  final dynamic partNumber;
  final String? hsnOrSac;
  final String? partName;
  final String? uom;
  final int? inclusiveTax;
  final double? discountPercentage;
  final double? discountAmount;
  final double? amountAfterDiscount;
  final double? grnBalanceQuantity;
  final dynamic sourceDeliveryChallanHeaderId;
  final dynamic sourceDeliveryChallanItemId;
  final dynamic receivedQuantity;
  final double? incomingQuantity;
  final double? dcBalanceQuantity;
  final dynamic processName;
  final String? specification;
  final dynamic sourceDeliveryChallanNumber;
  final dynamic sourceDeliveryChallanDate;
  final dynamic isContainer;
  final dynamic outName;
  final dynamic outPartNumber;
  final dynamic jwNoteItemId;

  DeliveryChallanItems({
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

  DeliveryChallanItems.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        headerId = json['headerId'] as String?,
        materialId = json['materialId'] as int?,
        slNo = json['slNo'] as int?,
        materialName = json['materialName'] as String?,
        quantity = json['quantity'] as double?,
        remarks = json['remarks'] as String?,
        status = json['status'],
        purchaseOrderHeaderId = json['purchaseOrderHeaderId'],
        purchaseOrderItemId = json['purchaseOrderItemId'],
        price = json['price'],
        amount = json['amount'] as double?,
        unitOfMeasurementId = json['unitOfMeasurementId'] as int?,
        taxId = json['taxId'] as int?,
        taxRate = json['taxRate'],
        deliveryChallanType = json['deliveryChallanType'],
        deliveryChallanItemStatus = json['deliveryChallanItemStatus'],
        processId = json['processId'],
        invoiceBalanceQuantity = json['invoiceBalanceQuantity'] as double?,
        batchCode = json['batchCode'],
        purchaseOrderNumber = json['purchaseOrderNumber'],
        batchCodeId = json['batchCodeId'],
        inDeliveryChallanNumber = json['inDeliveryChallanNumber'],
        inDeliveryChallanDate = json['inDeliveryChallanDate'],
        sgstTaxPercentage = json['sgstTaxPercentage'] as double?,
        sgstTaxAmount = json['sgstTaxAmount'] as double?,
        cgstTaxPercentage = json['cgstTaxPercentage'] as double?,
        cgstTaxAmount = json['cgstTaxAmount'] as double?,
        igstTaxPercentage = json['igstTaxPercentage'] as double?,
        igstTaxAmount = json['igstTaxAmount'] as double?,
        taxAmount = json['taxAmount'],
        partNumber = json['partNumber'],
        hsnOrSac = json['hsnOrSac'] as String?,
        partName = json['partName'] as String?,
        uom = json['uom'] as String?,
        inclusiveTax = json['inclusiveTax'] as int?,
        discountPercentage = json['discountPercentage'] as double?,
        discountAmount = json['discountAmount'] as double?,
        amountAfterDiscount = json['amountAfterDiscount'] as double?,
        grnBalanceQuantity = json['grnBalanceQuantity'] as double?,
        sourceDeliveryChallanHeaderId = json['sourceDeliveryChallanHeaderId'],
        sourceDeliveryChallanItemId = json['sourceDeliveryChallanItemId'],
        receivedQuantity = json['receivedQuantity'],
        incomingQuantity = json['incomingQuantity'] as double?,
        dcBalanceQuantity = json['dcBalanceQuantity'] as double?,
        processName = json['processName'],
        specification = json['specification'] as String?,
        sourceDeliveryChallanNumber = json['sourceDeliveryChallanNumber'],
        sourceDeliveryChallanDate = json['sourceDeliveryChallanDate'],
        isContainer = json['isContainer'],
        outName = json['outName'],
        outPartNumber = json['outPartNumber'],
        jwNoteItemId = json['jwNoteItemId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'headerId': headerId,
        'materialId': materialId,
        'slNo': slNo,
        'materialName': materialName,
        'quantity': quantity,
        'remarks': remarks,
        'status': status,
        'purchaseOrderHeaderId': purchaseOrderHeaderId,
        'purchaseOrderItemId': purchaseOrderItemId,
        'price': price,
        'amount': amount,
        'unitOfMeasurementId': unitOfMeasurementId,
        'taxId': taxId,
        'taxRate': taxRate,
        'deliveryChallanType': deliveryChallanType,
        'deliveryChallanItemStatus': deliveryChallanItemStatus,
        'processId': processId,
        'invoiceBalanceQuantity': invoiceBalanceQuantity,
        'batchCode': batchCode,
        'purchaseOrderNumber': purchaseOrderNumber,
        'batchCodeId': batchCodeId,
        'inDeliveryChallanNumber': inDeliveryChallanNumber,
        'inDeliveryChallanDate': inDeliveryChallanDate,
        'sgstTaxPercentage': sgstTaxPercentage,
        'sgstTaxAmount': sgstTaxAmount,
        'cgstTaxPercentage': cgstTaxPercentage,
        'cgstTaxAmount': cgstTaxAmount,
        'igstTaxPercentage': igstTaxPercentage,
        'igstTaxAmount': igstTaxAmount,
        'taxAmount': taxAmount,
        'partNumber': partNumber,
        'hsnOrSac': hsnOrSac,
        'partName': partName,
        'uom': uom,
        'inclusiveTax': inclusiveTax,
        'discountPercentage': discountPercentage,
        'discountAmount': discountAmount,
        'amountAfterDiscount': amountAfterDiscount,
        'grnBalanceQuantity': grnBalanceQuantity,
        'sourceDeliveryChallanHeaderId': sourceDeliveryChallanHeaderId,
        'sourceDeliveryChallanItemId': sourceDeliveryChallanItemId,
        'receivedQuantity': receivedQuantity,
        'incomingQuantity': incomingQuantity,
        'dcBalanceQuantity': dcBalanceQuantity,
        'processName': processName,
        'specification': specification,
        'sourceDeliveryChallanNumber': sourceDeliveryChallanNumber,
        'sourceDeliveryChallanDate': sourceDeliveryChallanDate,
        'isContainer': isContainer,
        'outName': outName,
        'outPartNumber': outPartNumber,
        'jwNoteItemId': jwNoteItemId
      };
}
