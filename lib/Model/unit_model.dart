class UnitsModel {
  final int? id;
  final String? createdDateTime;
  final String? createdBy;
  final String? updatedDateTime;
  final String? updatedBy;
  final String? deleted;
  final String? name;
  final int? uomForId;
  final int? isSubscriptionBasedService;
  final int? serviceTimeSpanId;
  int? taxId;
  int? serviceFrequencyCount;
  double? serviceCharge;
  String? description;

  UnitsModel({
    this.id,
    this.createdDateTime,
    this.createdBy,
    this.updatedDateTime,
    this.updatedBy,
    this.deleted,
    this.name,
    this.uomForId,
    this.isSubscriptionBasedService,
    this.serviceTimeSpanId,
    this.taxId,
    this.serviceFrequencyCount,
    this.serviceCharge,
    this.description,
  });

  UnitsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        createdDateTime = json['createdDateTime'] as String?,
        createdBy = json['createdBy'] as String?,
        updatedDateTime = json['updatedDateTime'] as String?,
        updatedBy = json['updatedBy'] as String?,
        deleted = json['deleted'] as String?,
        name = json['name'] as String?,
        uomForId = json['uomForId'] as int?,
        isSubscriptionBasedService = json['isSubscriptionBasedService'] as int?,
        serviceTimeSpanId = json['serviceTimeSpanId'] as int?,
        taxId = json['taxId'] as int?,
        serviceFrequencyCount = json['serviceFrequencyCount'] as int?,
        serviceCharge = json['serviceCharge'] as double?,
        description = json['description'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdDateTime': createdDateTime,
        'createdBy': createdBy,
        'updatedDateTime': updatedDateTime,
        'updatedBy': updatedBy,
        'deleted': deleted,
        'name': name,
        'uomForId': uomForId,
        'isSubscriptionBasedService': isSubscriptionBasedService,
        'serviceTimeSpanId': serviceTimeSpanId,
        'taxId': taxId,
        'serviceFrequencyCount': serviceFrequencyCount,
        'serviceCharge': serviceCharge,
        'description': description,
      };
}
