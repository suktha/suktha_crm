class MaterialListModel {
  final int? id;
  final dynamic deleted;
  final String? name;
  final String? partNumber;
  final int? supplyTypeId;
  final int? materialTypeId;
  final int? unitOfMeasurementId;
  final String? unitOfMeasurementName;
  final double? price;
  final dynamic specification;
  final double? stock;
  final int? companyId;
  final double? buyingPrice;
  final int? taxId;
  final double? mrp;
  final dynamic discountPercentage;
  final dynamic partyId;
  final dynamic hsnCode;
  final dynamic cessPercentage;
  final dynamic imagePath;
  final double? openingStock;
  final double? minimumStock;
  final int? isContainer;
  final dynamic outName;
  final dynamic outPartNumber;
  final String? materialTypeName;
  final String? materialImagePath;
  final String? aliasName;
  final double? commission;
  final dynamic isBomExists;
  final dynamic serviceExecutionModeId;
  final dynamic serviceType;
  final dynamic qualifiedTeamMembers;
  final dynamic serviceAvailability;
  final dynamic serviceStartDate;
  final dynamic serviceEndDate;
  final dynamic serviceStatus;
  final dynamic serviceTypeName;
  final dynamic subscriptionBasedServices;
  final dynamic materialCategoryName;




  //  "commission": 0.0,
  //   "isBomExists": null,
  //   "serviceExecutionModeId": null,
  //   "serviceType": null,
  //   "qualifiedTeamMembers": [],
  //   "serviceAvailability": null,
  //   "serviceStartDate": null,
  //   "serviceEndDate": null,
  //   "serviceStatus": null,
  //   "serviceTypeName": null,
  //   "subscriptionBasedServices": [],
  //   "materialCategoryName": null

  MaterialListModel({
    
    this.id,
    this.deleted,
    this.name,
    this.partNumber,
    this.supplyTypeId,
    this.materialTypeId,
    this.unitOfMeasurementId,
    this.unitOfMeasurementName,
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
    this.serviceTypeName,
    this.subscriptionBasedServices,
    this.materialCategoryName

  });

  MaterialListModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      deleted = json['deleted'],
      name = json['name'] as String?,
      partNumber = json['partNumber'] as String?,
      supplyTypeId = json['supplyTypeId'] as int?,
      materialTypeId = json['materialTypeId'] as int?,
      unitOfMeasurementId = json['unitOfMeasurementId'] as int?,
      unitOfMeasurementName = json['unitOfMeasurementName'] as String?,
      price = json['price'] as double?,
      specification = json['specification'],
      stock = json['stock'] as double?,
      companyId = json['companyId'] as int?,
      buyingPrice = json['buyingPrice'] as double?,
      taxId = json['taxId'] as int?,
      mrp = json['mrp'] as double?,
      discountPercentage = json['discountPercentage'],
      partyId = json['partyId'],
      hsnCode = json['hsnCode'],
      cessPercentage = json['cessPercentage'],
      imagePath = json['imagePath'],
      openingStock = json['openingStock'] as double?,
      minimumStock = json['minimumStock'] as double?,
      isContainer = json['isContainer'] as int?,
      outName = json['outName'],
      outPartNumber = json['outPartNumber'],
      materialTypeName = json['materialTypeName'] as String?,
      materialImagePath = json['materialImagePath'] as String?,
      aliasName = json['aliasName'] as String?,
      commission = json['commission'] as double?,
      isBomExists = json['isBomExists'],
      serviceExecutionModeId = json['serviceExecutionModeId'],
      serviceType = json['serviceType'],
      qualifiedTeamMembers = json['qualifiedTeamMembers'],
      serviceAvailability = json['serviceAvailability'],
      serviceStartDate = json['serviceStartDate'],
      serviceEndDate = json['serviceEndDate'],
      serviceStatus = json['serviceStatus'],
      serviceTypeName = json['serviceTypeName'],
      subscriptionBasedServices = json['subscriptionBasedServices'],
      materialCategoryName = json['materialCategoryName'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'deleted' : deleted,
    'name' : name,
    'partNumber' : partNumber,
    'supplyTypeId' : supplyTypeId,
    'materialTypeId' : materialTypeId,
    'unitOfMeasurementId' : unitOfMeasurementId,
    'unitOfMeasurementName' : unitOfMeasurementName,
    'price' : price,
    'specification' : specification,
    'stock' : stock,
    'companyId' : companyId,
    'buyingPrice' : buyingPrice,
    'taxId' : taxId,
    'mrp' : mrp,
    'discountPercentage' : discountPercentage,
    'partyId' : partyId,
    'hsnCode' : hsnCode,
    'cessPercentage' : cessPercentage,
    'imagePath' : imagePath,
    'openingStock' : openingStock,
    'minimumStock' : minimumStock,
    'isContainer' : isContainer,
    'outName' : outName,
    'outPartNumber' : outPartNumber,
    'materialTypeName' : materialTypeName,
    'materialImagePath' : materialImagePath,
    'aliasName' : aliasName,
    'commission' : commission,
    'isBomExists' : isBomExists,
    'serviceExecutionModeId' : serviceExecutionModeId,
    'serviceType' : serviceType,
    'qualifiedTeamMembers' : qualifiedTeamMembers,
    'serviceAvailability' : serviceAvailability,
    'serviceStartDate' : serviceStartDate,
    'serviceEndDate' : serviceEndDate,
    'serviceStatus' : serviceStatus,
    'serviceTypeName' : serviceTypeName,
    'subscriptionBasedServices' : subscriptionBasedServices,
    'materialCategoryName' : materialCategoryName
  };
}