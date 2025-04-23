class ServiceMaterialListModel {
  final dynamic id;
  final dynamic deleted;
  final String? name;
  final dynamic partNumber;
  final int? supplyTypeId;
  final dynamic materialTypeId;
  final dynamic unitOfMeasurementId;
  final dynamic unitOfMeasurementName;
  final int? categoryId;
  final List<dynamic>? attributeAndValues;
  final dynamic price;
  final String? specification;
  final double? stock;
  final int? companyId;
  final dynamic buyingPrice;
  final int? taxId;
  final dynamic mrp;
  final dynamic discountPercentage;
  final dynamic partyId;
  final dynamic hsnCode;
  final dynamic cessPercentage;
  final dynamic openingStock;
  final dynamic minimumStock;
  final int? isContainer;
  final dynamic outName;
  final dynamic outPartNumber;
  final dynamic materialTypeName;
  final dynamic materialImagePath;
  final dynamic aliasName;
  final dynamic commission;
  final dynamic isBomExists;
  final int? serviceExecutionModeId;
  final int? serviceType;
  final List<int>? qualifiedTeamMembers;
  final int? serviceAvailability;
  final dynamic serviceStartDate;
  final dynamic serviceEndDate;
  final int? serviceStatus;
  final List<SubscriptionBasedServices>? subscriptionBasedServices;

  ServiceMaterialListModel({
    this.id,
    this.deleted,
    this.name,
    this.partNumber,
    this.supplyTypeId,
    this.materialTypeId,
    this.unitOfMeasurementId,
    this.unitOfMeasurementName,
    this.categoryId,
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
  });

  ServiceMaterialListModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        deleted = json['deleted'],
        name = json['name'] as String?,
        partNumber = json['partNumber'],
        supplyTypeId = json['supplyTypeId'] as int?,
        materialTypeId = json['materialTypeId'],
        unitOfMeasurementId = json['unitOfMeasurementId'],
        unitOfMeasurementName = json['unitOfMeasurementName'],
        categoryId = json['categoryId'] as int?,
        attributeAndValues = json['attributeAndValues'] as List?,
        price = json['price'],
        specification = json['specification'] as String?,
        stock = json['stock'] as double?,
        companyId = json['companyId'] as int?,
        buyingPrice = json['buyingPrice'],
        taxId = json['taxId'] as int?,
        mrp = json['mrp'],
        discountPercentage = json['discountPercentage'],
        partyId = json['partyId'],
        hsnCode = json['hsnCode'],
        cessPercentage = json['cessPercentage'],
        openingStock = json['openingStock'],
        minimumStock = json['minimumStock'],
        isContainer = json['isContainer'] as int?,
        outName = json['outName'],
        outPartNumber = json['outPartNumber'],
        materialTypeName = json['materialTypeName'],
        materialImagePath = json['materialImagePath'],
        aliasName = json['aliasName'],
        commission = json['commission'],
        isBomExists = json['isBomExists'],
        serviceExecutionModeId = json['serviceExecutionModeId'] as int?,
        serviceType = json['serviceType'] as int?,
        qualifiedTeamMembers = (json['qualifiedTeamMembers'] as List?)?.map((dynamic e) => e as int).toList(),
        serviceAvailability = json['serviceAvailability'] as int?,
        serviceStartDate = json['serviceStartDate'],
        serviceEndDate = json['serviceEndDate'],
        serviceStatus = json['serviceStatus'] as int?,
        subscriptionBasedServices = (json['subscriptionBasedServices'] as List?)?.map((dynamic e) => SubscriptionBasedServices.fromJson(e as Map<String, dynamic>)).toList();

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
        'subscriptionBasedServices': subscriptionBasedServices?.map((e) => e.toJson()).toList()
      };
}

class SubscriptionBasedServices {
  final dynamic id;
  final int? serviceFrequencyCount;
  final int? serviceFrequencyUom;
  final dynamic timeRequiredCount;
  final dynamic timeRequired;
  final dynamic serviceCharge;
  final dynamic commission;
  int? isDefault;
  final int? taxId;
  final String? comments;

  SubscriptionBasedServices({
    this.id,
    this.serviceFrequencyCount,
    this.serviceFrequencyUom,
    this.timeRequiredCount,
    this.timeRequired,
    this.serviceCharge,
    this.commission,
    this.isDefault,
    this.taxId,
    this.comments,
  });

  SubscriptionBasedServices.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        serviceFrequencyCount = json['serviceFrequencyCount'] as int?,
        serviceFrequencyUom = json['serviceFrequencyUom'] as int?,
        timeRequiredCount = json['timeRequiredCount'],
        timeRequired = json['timeRequired'],
        serviceCharge = json['serviceCharge'],
        commission = json['commission'],
        isDefault = json['isDefault'] as int?,
        taxId = json['taxId'] as int?,
        comments = json['comments'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'serviceFrequencyCount': serviceFrequencyCount,
        'serviceFrequencyUom': serviceFrequencyUom,
        'timeRequiredCount': timeRequiredCount,
        'timeRequired': timeRequired,
        'serviceCharge': serviceCharge,
        'commission': commission,
        'isDefault': isDefault,
        'taxId': taxId,
        'comments': comments
      };
}
