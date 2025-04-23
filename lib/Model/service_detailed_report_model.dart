class ServiceDetailedReportModel {
  final dynamic materials;
  final List<ServiceItems>? serviceItems;
  final int? totalCount;

  ServiceDetailedReportModel({
    this.materials,
    this.serviceItems,
    this.totalCount,
  });

  ServiceDetailedReportModel.fromJson(Map<String, dynamic> json)
      : materials = json['materials'],
        serviceItems = (json['serviceItems'] as List?)?.map((dynamic e) => ServiceItems.fromJson(e as Map<String, dynamic>)).toList(),
        totalCount = json['totalCount'] as int?;

  Map<String, dynamic> toJson() => {'materials': materials, 'serviceItems': serviceItems?.map((e) => e.toJson()).toList(), 'totalCount': totalCount};
}

class ServiceItems {
  final int? id;
  final String? name;
  final String? uomName;
  final dynamic materialCategoryName;
  final dynamic price;
  final dynamic specification;
  final String? taxName;
  final double? commission;
  final dynamic serviceExecutionModeName;
  final String? serviceTypeName;
  final String? qualifiedTeamMembers;
  final String? serviceAvailabilityName;
  final dynamic serviceStartDate;
  final dynamic serviceEndDate;
  final int? serviceStatus;
  final dynamic subscriptionBasedServices;
  final String? serviceStatusName;
  final String? createdDateTime;
  final int? taxId;

  ServiceItems({
    this.id,
    this.name,
    this.uomName,
    this.materialCategoryName,
    this.price,
    this.specification,
    this.taxName,
    this.commission,
    this.serviceExecutionModeName,
    this.serviceTypeName,
    this.qualifiedTeamMembers,
    this.serviceAvailabilityName,
    this.serviceStartDate,
    this.serviceEndDate,
    this.serviceStatus,
    this.subscriptionBasedServices,
    this.serviceStatusName,
    this.createdDateTime,
    this.taxId,
  });

  ServiceItems.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        uomName = json['uomName'] as String?,
        materialCategoryName = json['materialCategoryName'],
        price = json['price'],
        specification = json['specification'],
        taxName = json['taxName'] as String?,
        commission = json['commission'] as double?,
        serviceExecutionModeName = json['serviceExecutionModeName'],
        serviceTypeName = json['serviceTypeName'] as String?,
        qualifiedTeamMembers = json['qualifiedTeamMembers'] as String?,
        serviceAvailabilityName = json['serviceAvailabilityName'] as String?,
        serviceStartDate = json['serviceStartDate'],
        serviceEndDate = json['serviceEndDate'],
        serviceStatus = json['serviceStatus'] as int?,
        subscriptionBasedServices = json['subscriptionBasedServices'],
        serviceStatusName = json['serviceStatusName'] as String?,
        createdDateTime = json['createdDateTime'] as String?,
        taxId = json['taxId'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'uomName': uomName,
        'materialCategoryName': materialCategoryName,
        'price': price,
        'specification': specification,
        'taxName': taxName,
        'commission': commission,
        'serviceExecutionModeName': serviceExecutionModeName,
        'serviceTypeName': serviceTypeName,
        'qualifiedTeamMembers': qualifiedTeamMembers,
        'serviceAvailabilityName': serviceAvailabilityName,
        'serviceStartDate': serviceStartDate,
        'serviceEndDate': serviceEndDate,
        'serviceStatus': serviceStatus,
        'subscriptionBasedServices': subscriptionBasedServices,
        'serviceStatusName': serviceStatusName,
        'createdDateTime': createdDateTime,
        'taxId': taxId
      };
}
