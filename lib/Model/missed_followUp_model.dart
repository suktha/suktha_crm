class MissedFollowUpModel {
  final String? leadId;
  final String? leadName;
  final String? assignedToName;
  final String? followUpDate;
  final String? phone;

  MissedFollowUpModel({
    this.leadId,
    this.leadName,
    this.assignedToName,
    this.followUpDate,
    this.phone,
  });

  MissedFollowUpModel.fromJson(Map<String, dynamic> json)
      : leadId = json['leadId'] as String?,
        leadName = json['leadName'] as String?,
        assignedToName = json['assignedToName'] as String?,
        followUpDate = json['followUpDate'] as String?,
        phone = json['phone'] as String?;

  Map<String, dynamic> toJson() => {'leadId': leadId, 'leadName': leadName, 'assignedToName': assignedToName, 'followUpDate': followUpDate, 'phone': phone};
}
