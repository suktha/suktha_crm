class LeadHistoryModel {
  final String? id;
  final String? leadId;
  final dynamic assignedId;
  final String? previousFollowUp;
  final String? nextFollowUp;
  final String? userComments;
  final String? leadComments;
  final String? deleted;
  final dynamic assignedName;

  LeadHistoryModel({
    this.id,
    this.leadId,
    this.assignedId,
    this.previousFollowUp,
    this.nextFollowUp,
    this.userComments,
    this.leadComments,
    this.deleted,
    this.assignedName,
  });

  LeadHistoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        leadId = json['leadId'] as String?,
        assignedId = json['assignedId'],
        previousFollowUp = json['previousFollowUp'] as String?,
        nextFollowUp = json['nextFollowUp'] as String?,
        userComments = json['userComments'] as String?,
        leadComments = json['leadComments'] as String?,
        deleted = json['deleted'] as String?,
        assignedName = json['assignedName'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'leadId': leadId,
        'assignedId': assignedId,
        'previousFollowUp': previousFollowUp,
        'nextFollowUp': nextFollowUp,
        'userComments': userComments,
        'leadComments': leadComments,
        'deleted': deleted,
        'assignedName': assignedName
      };
}
