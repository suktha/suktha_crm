
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