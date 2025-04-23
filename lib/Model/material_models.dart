class MaterialModel {
  int? id;
  dynamic deleted;
  String? name;
  dynamic partNumber;
  int? supplyTypeId;
  dynamic materialTypeId;
  dynamic unitOfMeasurementId;
  dynamic unitOfMeasurementName;
  dynamic categoryId;
  dynamic categoryName;
  List<dynamic>? attributeAndValues;
  double? price;
  dynamic specification;
  double? stock;
  int? companyId;
  double? buyingPrice;
  dynamic taxId;
  double? mrp;
  double? discountPercentage;
  int? partyId;
  dynamic hsnCode;
  dynamic cessPercentage;
  dynamic imagePath;
  double? openingStock;
  dynamic minimumStock;
  int? isContainer;
  dynamic outName;
  dynamic outPartNumber;
  dynamic materialTypeName;
  String? materialImagePath;
  dynamic aliasName;
  double? commission;
  dynamic isBomExists;
  dynamic serviceExecutionModeId;
  int? serviceType;
  List<dynamic>? qualifiedTeamMembers;
  int? serviceAvailability;
  dynamic serviceStartDate;
  dynamic serviceEndDate;
  int? serviceStatus;
  List<SubscriptionBasedServices>? subscriptionBasedServices;
  dynamic materialCategoryName;

  MaterialModel({
    this.id,
    this.deleted,
    this.name,
    this.partNumber,
    this.supplyTypeId,
    this.materialTypeId,
    this.unitOfMeasurementId,
    this.unitOfMeasurementName,
    this.categoryId,
    this.categoryName,
    this.attributeAndValues,
    this.price,
    this.specification,
    this.stock,
    this.companyId,
    this.buyingPrice,
    this.taxId,
    this.mrp,
    this.discountPercentage,
    this.partyId,
    this.hsnCode,
    this.cessPercentage,
    this.imagePath,
    this.openingStock,
    this.minimumStock,
    this.isContainer,
    this.outName,
    this.outPartNumber,
    this.materialTypeName,
    this.materialImagePath,
    this.aliasName,
    this.commission,
    this.isBomExists,
    this.serviceExecutionModeId,
    this.serviceType,
    this.qualifiedTeamMembers,
    this.serviceAvailability,
    this.serviceStartDate,
    this.serviceEndDate,
    this.serviceStatus,
    this.subscriptionBasedServices,
    this.materialCategoryName,
  });

  MaterialModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        deleted = json['deleted'],
        name = json['name'] as String?,
        partNumber = json['partNumber'],
        supplyTypeId = json['supplyTypeId'] as int?,
        materialTypeId = json['materialTypeId'],
        unitOfMeasurementId = json['unitOfMeasurementId'],
        unitOfMeasurementName = json['unitOfMeasurementName'],
        categoryId = json['categoryId'],
        categoryName = json['categoryName'],
        attributeAndValues = json['attributeAndValues'] as List?,
        price = json['price'],
        specification = json['specification'],
        stock = json['stock'] as double?,
        companyId = json['companyId'] as int?,
        buyingPrice = json['buyingPrice'],
        taxId = json['taxId'],
        mrp = json['mrp'],
        discountPercentage = json['discountPercentage'],
        partyId = json['partyId'],
        hsnCode = json['hsnCode'],
        cessPercentage = json['cessPercentage'],
        imagePath = json['imagePath'],
        openingStock = json['openingStock'] as double?,
        minimumStock = json['minimumStock'],
        isContainer = json['isContainer'] as int?,
        outName = json['outName'],
        outPartNumber = json['outPartNumber'],
        materialTypeName = json['materialTypeName'],
        materialImagePath = json['materialImagePath'] as String?,
        aliasName = json['aliasName'],
        commission = json['commission'] as double?,
        isBomExists = json['isBomExists'],
        serviceExecutionModeId = json['serviceExecutionModeId'],
        serviceType = json['serviceType'] as int?,
        qualifiedTeamMembers = json['qualifiedTeamMembers'] as List?,
        serviceAvailability = json['serviceAvailability'] as int?,
        serviceStartDate = json['serviceStartDate'],
        serviceEndDate = json['serviceEndDate'],
        serviceStatus = json['serviceStatus'] as int?,
        subscriptionBasedServices = (json['subscriptionBasedServices'] as List?)
            ?.map((dynamic e) => SubscriptionBasedServices.fromJson(e as Map<String, dynamic>))
            .toList(),
        materialCategoryName = json['materialCategoryName'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'deleted': deleted,
        'name': name,
        'partNumber': partNumber,
        'supplyTypeId': supplyTypeId,
        'materialTypeId': materialTypeId,
        'unitOfMeasurementId': unitOfMeasurementId,
        'unitOfMeasurementName': unitOfMeasurementName,
        'categoryId': categoryId,
        'categoryName': categoryName,
        'attributeAndValues': attributeAndValues,
        'price': price,
        'specification': specification,
        'stock': stock,
        'companyId': companyId,
        'buyingPrice': buyingPrice,
        'taxId': taxId,
        'mrp': mrp,
        'discountPercentage': discountPercentage,
        'partyId': partyId,
        'hsnCode': hsnCode,
        'cessPercentage': cessPercentage,
        'imagePath': imagePath,
        'openingStock': openingStock,
        'minimumStock': minimumStock,
        'isContainer': isContainer,
        'outName': outName,
        'outPartNumber': outPartNumber,
        'materialTypeName': materialTypeName,
        'materialImagePath': materialImagePath,
        'aliasName': aliasName,
        'commission': commission,
        'isBomExists': isBomExists,
        'serviceExecutionModeId': serviceExecutionModeId,
        'serviceType': serviceType,
        'qualifiedTeamMembers': qualifiedTeamMembers,
        'serviceAvailability': serviceAvailability,
        'serviceStartDate': serviceStartDate,
        'serviceEndDate': serviceEndDate,
        'serviceStatus': serviceStatus,
        'subscriptionBasedServices': subscriptionBasedServices?.map((e) => e.toJson()).toList(),
        'materialCategoryName': materialCategoryName
      };
}

class SubscriptionBasedServices {
  int? serviceFrequencyCount;
  int? serviceFrequencyUom;
  dynamic timeRequiredCount;
  dynamic timeRequired;
  double? serviceCharge;
  double? commission;
  int? isDefault;
  int? taxId;
  dynamic taxName;
  String? comments;

  SubscriptionBasedServices({
    this.serviceFrequencyCount,
    this.serviceFrequencyUom,
    this.timeRequiredCount,
    this.timeRequired,
    this.serviceCharge,
    this.commission,
    this.isDefault,
    this.taxId,
    this.taxName,
    this.comments,
  });

  SubscriptionBasedServices.fromJson(Map<String, dynamic> json)
      : serviceFrequencyCount = json['serviceFrequencyCount'] as int?,
        serviceFrequencyUom = json['serviceFrequencyUom'] as int?,
        timeRequiredCount = json['timeRequiredCount'],
        timeRequired = json['timeRequired'],
        serviceCharge = json['serviceCharge'] as double?,
        commission = json['commission'] as double?,
        isDefault = json['isDefault'] as int?,
        taxId = json['taxId'] as int?,
        taxName = json['taxName'],
        comments = json['comments'] as String?;

  Map<String, dynamic> toJson() => {
        'serviceFrequencyCount': serviceFrequencyCount,
        'serviceFrequencyUom': serviceFrequencyUom,
        'timeRequiredCount': timeRequiredCount,
        'timeRequired': timeRequired,
        'serviceCharge': serviceCharge,
        'commission': commission,
        'isDefault': isDefault,
        'taxId': taxId,
        'taxName': taxName,
        'comments': comments
      };
}

class MaterialInputed {
  int? slno;
  int? unit;
  double? quantity;
  dynamic desciption;
  double? price;
  double? amount;
  String? remarks;

  MaterialInputed({
    this.amount,
    this.desciption,
    this.price,
    this.quantity,
    this.remarks,
    this.slno,
  });

  MaterialInputed.fromJson(Map<String, dynamic> json) {
    slno = json['slno'] as int?;
    desciption = json['description'] as dynamic;
    quantity = json['quantity'] as double?;
    price = json['price'] as double?;
    amount = json['amount'] as double?;
    remarks = json['remarks'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['slno'] = slno;

    json['description'] = desciption;
    json['quantity'] = quantity;
    json['price'] = price;
    json['amount'] = amount;
    json['remarks'] = remarks;
    return json;
  }
}

class MaterialPaymentModel {
  double? discountPercent;
  double? discountAmount;
  double? sumAmount;
  double? cgstTaxAmount;

  double? sgstTaxAmount;
  double? cgstTaxRate;
  double? sgstTaxRate;
  double? igstTaxAmount;
  double? igstTaxPercent;

  double? totalTaxableAmount;
  double? finalamount;
  double? taxrate;
  int? taxId;

  String? termsAndCondition;

  MaterialPaymentModel({
    this.cgstTaxAmount,
    this.cgstTaxRate,
    this.discountAmount,
    this.discountPercent,
    this.finalamount,
    this.sgstTaxAmount,
    this.sgstTaxRate,
    this.igstTaxAmount,
    this.igstTaxPercent,
    this.sumAmount,
    this.taxrate,
    this.taxId,
    this.totalTaxableAmount,
    this.termsAndCondition,
  });

  MaterialPaymentModel.fromJson(Map<String, dynamic> json) {
    discountPercent = json['discountPercent'] as double?;
    discountAmount = json['discountAmount'] as double?;
    cgstTaxAmount = json['cgstTaxAmount'] as double?;
    cgstTaxRate = json['cgstTaxRAte'] as double?;
    sgstTaxAmount = json['sgstTaxAmount'] as double?;
    sgstTaxRate = json['sgstTaxRate'] as double?;
    igstTaxAmount = json['igstTaxAmount'] as double?;
    igstTaxPercent = json['igstTaxPercent'] as double?;
    totalTaxableAmount = json['totalTaxableAmount'] as double?;
    finalamount = json['finalAmount'] as double?;
    taxrate = json['taxRate'] as double?;
    taxId = json['taxId'] as int?;
    sumAmount = json['sumAmount'] as double?;
    termsAndCondition = json['termsAndCondition'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['discountPercent'] = discountPercent;
    json['discountAmount'] = discountAmount;
    json['cgstTaxAmount'] = cgstTaxAmount;
    json['cgstTaxRAte'] = cgstTaxRate;
    json['sgstTaxAmount'] = sgstTaxAmount;
    json['sgstTaxRate'] = sgstTaxRate;
    json['igstTaxAmount'] = igstTaxAmount;
    json['igstTaxPercent'] = igstTaxPercent;
    json['totalTaxableAmount'] = totalTaxableAmount;
    json['finalAmount'] = finalamount;
    json['taxRate'] = taxrate;
    json['taxId'] = taxId;
    json['sumAmount'] = sumAmount;
    json['termsAndCondition'] = termsAndCondition;

    return json;
  }
}
