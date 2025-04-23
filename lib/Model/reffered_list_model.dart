class RefferedListModel {
  final int? id;
  final String? refereedName;
  final String? refereeName;
  final String? refereeEmail;
  final String? refereeLink;
  final String? referralCode;
  final dynamic phoneNum;
  final String? referralDateTime;
  final int? referralStatus;
  final String? conversionDate;
  final dynamic revertedCancellationDate;
  final int? referralSchemeType;
  final dynamic rewardAppliedDateTime;
  final int? resendCount;
  final dynamic createdDateTime;
  final dynamic createdBy;
  final dynamic updatedDateTime;
  final dynamic updatedBy;
  final String? tenant;
  final String? statusName;
  final dynamic contactNo;
  final dynamic companyName;
  final dynamic contactPerson;

  RefferedListModel({
    this.id,
    this.refereedName,
    this.refereeName,
    this.refereeEmail,
    this.refereeLink,
    this.referralCode,
    this.phoneNum,
    this.referralDateTime,
    this.referralStatus,
    this.conversionDate,
    this.revertedCancellationDate,
    this.referralSchemeType,
    this.rewardAppliedDateTime,
    this.resendCount,
    this.createdDateTime,
    this.createdBy,
    this.updatedDateTime,
    this.updatedBy,
    this.tenant,
    this.statusName,
    this.contactNo,
    this.companyName,
    this.contactPerson,
  });

  RefferedListModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      refereedName = json['refereedName'] as String?,
      refereeName = json['refereeName'] as String?,
      refereeEmail = json['refereeEmail'] as String?,
      refereeLink = json['refereeLink'] as String?,
      referralCode = json['referralCode'] as String?,
      phoneNum = json['phoneNum'],
      referralDateTime = json['referralDateTime'] as String?,
      referralStatus = json['referralStatus'] as int?,
      conversionDate = json['conversionDate'] as String?,
      revertedCancellationDate = json['revertedCancellationDate'],
      referralSchemeType = json['referralSchemeType'] as int?,
      rewardAppliedDateTime = json['rewardAppliedDateTime'],
      resendCount = json['resendCount'] as int?,
      createdDateTime = json['createdDateTime'],
      createdBy = json['createdBy'],
      updatedDateTime = json['updatedDateTime'],
      updatedBy = json['updatedBy'],
      tenant = json['tenant'] as String?,
      statusName = json['statusName'] as String?,
      contactNo = json['contactNo'],
      companyName = json['companyName'],
      contactPerson = json['contactPerson'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'refereedName' : refereedName,
    'refereeName' : refereeName,
    'refereeEmail' : refereeEmail,
    'refereeLink' : refereeLink,
    'referralCode' : referralCode,
    'phoneNum' : phoneNum,
    'referralDateTime' : referralDateTime,
    'referralStatus' : referralStatus,
    'conversionDate' : conversionDate,
    'revertedCancellationDate' : revertedCancellationDate,
    'referralSchemeType' : referralSchemeType,
    'rewardAppliedDateTime' : rewardAppliedDateTime,
    'resendCount' : resendCount,
    'createdDateTime' : createdDateTime,
    'createdBy' : createdBy,
    'updatedDateTime' : updatedDateTime,
    'updatedBy' : updatedBy,
    'tenant' : tenant,
    'statusName' : statusName,
    'contactNo' : contactNo,
    'companyName' : companyName,
    'contactPerson' : contactPerson
  };
}