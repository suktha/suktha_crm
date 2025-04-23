class SubHistoryModel {
  final String? createdDateTime;
  final String? createdBy;
  final String? updatedDateTime;
  final String? updatedBy;
  final int? id;
  final dynamic status;
  final dynamic subscriptionId;
  final dynamic planId;
  final dynamic noOfBillingCycle;
  final dynamic subscriptionUrl;
  final dynamic company;
  final dynamic offerId;
  final String? trailPeriodEnd;
  final String? trailPeriodStarted;
  final dynamic subscriptionEndDate;
  final dynamic subscriptionStartDate;
  final dynamic canceledReason;
  final dynamic active;
  final dynamic activeStatusName;
  final dynamic cancelPolicyAccepted;

  SubHistoryModel({
    this.createdDateTime,
    this.createdBy,
    this.updatedDateTime,
    this.updatedBy,
    this.id,
    this.status,
    this.subscriptionId,
    this.planId,
    this.noOfBillingCycle,
    this.subscriptionUrl,
    this.company,
    this.offerId,
    this.trailPeriodEnd,
    this.trailPeriodStarted,
    this.subscriptionEndDate,
    this.subscriptionStartDate,
    this.canceledReason,
    this.active,
    this.activeStatusName,
    this.cancelPolicyAccepted,
  });

  SubHistoryModel.fromJson(Map<String, dynamic> json)
      : createdDateTime = json['createdDateTime'] as String?,
        createdBy = json['createdBy'] as String?,
        updatedDateTime = json['updatedDateTime'] as String?,
        updatedBy = json['updatedBy'] as String?,
        id = json['id'] as int?,
        status = json['status'],
        subscriptionId = json['subscriptionId'],
        planId = json['planId'],
        noOfBillingCycle = json['noOfBillingCycle'],
        subscriptionUrl = json['subscriptionUrl'],
        company = json['company'],
        offerId = json['offerId'],
        trailPeriodEnd = json['trailPeriodEnd'] as String?,
        trailPeriodStarted = json['trailPeriodStarted'] as String?,
        subscriptionEndDate = json['subscriptionEndDate'],
        subscriptionStartDate = json['subscriptionStartDate'],
        canceledReason = json['canceledReason'],
        active = json['active'],
        activeStatusName = json['activeStatusName'],
        cancelPolicyAccepted = json['cancelPolicyAccepted'];

  Map<String, dynamic> toJson() => {
        'createdDateTime': createdDateTime,
        'createdBy': createdBy,
        'updatedDateTime': updatedDateTime,
        'updatedBy': updatedBy,
        'id': id,
        'status': status,
        'subscriptionId': subscriptionId,
        'planId': planId,
        'noOfBillingCycle': noOfBillingCycle,
        'subscriptionUrl': subscriptionUrl,
        'company': company,
        'offerId': offerId,
        'trailPeriodEnd': trailPeriodEnd,
        'trailPeriodStarted': trailPeriodStarted,
        'subscriptionEndDate': subscriptionEndDate,
        'subscriptionStartDate': subscriptionStartDate,
        'canceledReason': canceledReason,
        'active': active,
        'activeStatusName': activeStatusName,
        'cancelPolicyAccepted': cancelPolicyAccepted
      };
}
