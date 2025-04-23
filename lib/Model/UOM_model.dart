class UOMGetModel {
  final int? id;
  final dynamic createdDateTime;
  final dynamic createdBy;
  final String? updatedDateTime;
  final String? updatedBy;
  final String? deleted;
  final String? name;
  final int? uomForId;
  final int? isSubscriptionBasedService;
  final dynamic serviceTimeSpanId;

  UOMGetModel({
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
  });

  UOMGetModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        createdDateTime = json['createdDateTime'],
        createdBy = json['createdBy'],
        updatedDateTime = json['updatedDateTime'] as String?,
        updatedBy = json['updatedBy'] as String?,
        deleted = json['deleted'] as String?,
        name = json['name'] as String?,
        uomForId = json['uomForId'] as int?,
        isSubscriptionBasedService = json['isSubscriptionBasedService'] as int?,
        serviceTimeSpanId = json['serviceTimeSpanId'];

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
        'serviceTimeSpanId': serviceTimeSpanId
      };
}
