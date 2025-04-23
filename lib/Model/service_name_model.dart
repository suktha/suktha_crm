class ServiceNameModel {
  final int? id;
  final dynamic deleted;
  final String? name;
  final dynamic partNumber;
  final int? supplyTypeId;
  final dynamic materialTypeId;
  final dynamic unitOfMeasurementId;
  final dynamic unitOfMeasurementName;
  final dynamic categoryId;
  final dynamic categoryName;
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
  final String? hsnCode;
  final dynamic cessPercentage;
  final dynamic imagePath;
  final double? openingStock;
  final dynamic minimumStock;
  final int? isContainer;
  final dynamic outName;
  final dynamic outPartNumber;
  final dynamic materialTypeName;
  final String? materialImagePath;
  final dynamic aliasName;
  final dynamic commission;
  final dynamic isBomExists;
  final dynamic serviceExecutionModeId;
  final int? serviceType;
  final List<dynamic>? qualifiedTeamMembers;
  final int? serviceAvailability;
  final dynamic serviceStartDate;
  final dynamic serviceEndDate;
  final int? serviceStatus;
  final List<dynamic>? subscriptionBasedServices;
  final dynamic materialCategoryName;

  ServiceNameModel({
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

  ServiceNameModel.fromJson(Map<String, dynamic> json)
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
        specification = json['specification'] as String?,
        stock = json['stock'] as double?,
        companyId = json['companyId'] as int?,
        buyingPrice = json['buyingPrice'],
        taxId = json['taxId'] as int?,
        mrp = json['mrp'],
        discountPercentage = json['discountPercentage'],
        partyId = json['partyId'],
        hsnCode = json['hsnCode'] as String?,
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
        commission = json['commission'],
        isBomExists = json['isBomExists'],
        serviceExecutionModeId = json['serviceExecutionModeId'],
        serviceType = json['serviceType'] as int?,
        qualifiedTeamMembers = json['qualifiedTeamMembers'] as List?,
        serviceAvailability = json['serviceAvailability'] as int?,
        serviceStartDate = json['serviceStartDate'],
        serviceEndDate = json['serviceEndDate'],
        serviceStatus = json['serviceStatus'] as int?,
        subscriptionBasedServices = json['subscriptionBasedServices'] as List?,
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
        'subscriptionBasedServices': subscriptionBasedServices,
        'materialCategoryName': materialCategoryName
      };
}
