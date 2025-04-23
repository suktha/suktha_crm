class LeadModel {
  final String? id;
  final String? leadName;
  final String? leadGenerationNumber;
  final dynamic leadGenerationId;
  final String? leadGenerationDate;
  final String? deleted;
  final dynamic createdBy;
  final int? financialYearId;
  final int? companyId;
  final String? createdDate;
  final int? isExistingCustomer;
  final dynamic updatedDate;
  final String? address;
  final dynamic cityId;
  final dynamic areaId;
  final dynamic countryId;
  final dynamic stateId;
  final String? contactPerson;
  final String? contactPersonNo;
  final String? mobileNo;
  final String? email;
  final int? priorityId;
  final int? sourceId;
  final List<dynamic>? interestedProductId;
  final List<dynamic>? interestedServiceId;
  final int? conversionChanceId;
  final dynamic comments;
  final double? amount;
  final int? statusId;
  final String? statusName;
  final int? leadGenerationType;
  final int? assignedToId;
  final String? followUpDate;
  final dynamic followUpTime;
  final String? leadComments;
  final String? userComments;
  final dynamic partyId;
  final String? partyName;
  final dynamic productName;
  final String? annualTurnOver;
  final dynamic leadGeoLocation;
  final int? leadOwnerId;
  final int? quickLead;
  final String? leadCompanyName;
  final dynamic leadCategoryId;
  final String? referralName;
  final int? industrySegmentId;
  final dynamic designationId;
  final dynamic whatsappNumber;
  final String? website;
  final dynamic pincode;
  final dynamic leadScore;
  final String? leadSourceDetails;
  final String? preferredContactTime;
  final String? customerPainPoints;
  final String? competitors;
  final dynamic customerBudget;
  final dynamic numberOfEmployees;
  final String? proposedSolution;
  final int? userId;
  final String? leadDescription;
  final dynamic reasonId;

  LeadModel({
    this.id,
    this.leadName,
    this.leadGenerationNumber,
    this.leadGenerationId,
    this.leadGenerationDate,
    this.deleted,
    this.createdBy,
    this.financialYearId,
    this.companyId,
    this.createdDate,
    this.isExistingCustomer,
    this.updatedDate,
    this.address,
    this.cityId,
    this.areaId,
    this.countryId,
    this.stateId,
    this.contactPerson,
    this.contactPersonNo,
    this.mobileNo,
    this.email,
    this.priorityId,
    this.sourceId,
    this.interestedProductId,
    this.interestedServiceId,
    this.conversionChanceId,
    this.comments,
    this.amount,
    this.statusId,
    this.statusName,
    this.leadGenerationType,
    this.assignedToId,
    this.followUpDate,
    this.followUpTime,
    this.leadComments,
    this.userComments,
    this.partyId,
    this.partyName,
    this.productName,
    this.annualTurnOver,
    this.leadGeoLocation,
    this.leadOwnerId,
    this.quickLead,
    this.leadCompanyName,
    this.leadCategoryId,
    this.referralName,
    this.industrySegmentId,
    this.designationId,
    this.whatsappNumber,
    this.website,
    this.pincode,
    this.leadScore,
    this.leadSourceDetails,
    this.preferredContactTime,
    this.customerPainPoints,
    this.competitors,
    this.customerBudget,
    this.numberOfEmployees,
    this.proposedSolution,
    this.userId,
    this.leadDescription,
    this.reasonId,
  });

  LeadModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        leadName = json['leadName'] as String?,
        leadGenerationNumber = json['leadGenerationNumber'] as String?,
        leadGenerationId = json['leadGenerationId'],
        leadGenerationDate = json['leadGenerationDate'] as String?,
        deleted = json['deleted'] as String?,
        createdBy = json['createdBy'],
        financialYearId = json['financialYearId'] as int?,
        companyId = json['companyId'] as int?,
        createdDate = json['createdDate'] as String?,
        isExistingCustomer = json['isExistingCustomer'] as int?,
        updatedDate = json['updatedDate'],
        address = json['address'] as String?,
        cityId = json['cityId'],
        areaId = json['areaId'],
        countryId = json['countryId'],
        stateId = json['stateId'],
        contactPerson = json['contactPerson'] as String?,
        contactPersonNo = json['contactPersonNo'] as String?,
        mobileNo = json['mobileNo'] as String?,
        email = json['email'] as String?,
        priorityId = json['priorityId'] as int?,
        sourceId = json['sourceId'] as int?,
        interestedProductId = json['interestedProductId'] as List?,
        interestedServiceId = json['interestedServiceId'] as List?,
        conversionChanceId = json['conversionChanceId'] as int?,
        comments = json['comments'],
        amount = json['amount'] as double?,
        statusId = json['statusId'] as int?,
        statusName = json['statusName'] as String?,
        leadGenerationType = json['leadGenerationType'] as int?,
        assignedToId = json['assignedToId'] as int?,
        followUpDate = json['followUpDate'] as String?,
        followUpTime = json['followUpTime'],
        leadComments = json['leadComments'] as String?,
        userComments = json['userComments'] as String?,
        partyId = json['partyId'],
        partyName = json['partyName'] as String?,
        productName = json['productName'],
        annualTurnOver = json['annualTurnOver'] as String?,
        leadGeoLocation = json['leadGeoLocation'],
        leadOwnerId = json['leadOwnerId'] as int?,
        quickLead = json['quickLead'] as int?,
        leadCompanyName = json['leadCompanyName'] as String?,
        leadCategoryId = json['leadCategoryId'],
        referralName = json['referralName'] as String?,
        industrySegmentId = json['industrySegmentId'] as int?,
        designationId = json['designationId'],
        whatsappNumber = json['whatsappNumber'],
        website = json['website'] as String?,
        pincode = json['pincode'],
        leadScore = json['leadScore'],
        leadSourceDetails = json['leadSourceDetails'] as String?,
        preferredContactTime = json['preferredContactTime'] as String?,
        customerPainPoints = json['customerPainPoints'] as String?,
        competitors = json['competitors'] as String?,
        customerBudget = json['customerBudget'],
        numberOfEmployees = json['numberOfEmployees'],
        proposedSolution = json['proposedSolution'] as String?,
        userId = json['userId'] as int?,
        leadDescription = json['leadDescription'] as String?,
        reasonId = json['reasonId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'leadName': leadName,
        'leadGenerationNumber': leadGenerationNumber,
        'leadGenerationId': leadGenerationId,
        'leadGenerationDate': leadGenerationDate,
        'deleted': deleted,
        'createdBy': createdBy,
        'financialYearId': financialYearId,
        'companyId': companyId,
        'createdDate': createdDate,
        'isExistingCustomer': isExistingCustomer,
        'updatedDate': updatedDate,
        'address': address,
        'cityId': cityId,
        'areaId': areaId,
        'countryId': countryId,
        'stateId': stateId,
        'contactPerson': contactPerson,
        'contactPersonNo': contactPersonNo,
        'mobileNo': mobileNo,
        'email': email,
        'priorityId': priorityId,
        'sourceId': sourceId,
        'interestedProductId': interestedProductId,
        'interestedServiceId': interestedServiceId,
        'conversionChanceId': conversionChanceId,
        'comments': comments,
        'amount': amount,
        'statusId': statusId,
        'statusName': statusName,
        'leadGenerationType': leadGenerationType,
        'assignedToId': assignedToId,
        'followUpDate': followUpDate,
        'followUpTime': followUpTime,
        'leadComments': leadComments,
        'userComments': userComments,
        'partyId': partyId,
        'partyName': partyName,
        'productName': productName,
        'annualTurnOver': annualTurnOver,
        'leadGeoLocation': leadGeoLocation,
        'leadOwnerId': leadOwnerId,
        'quickLead': quickLead,
        'leadCompanyName': leadCompanyName,
        'leadCategoryId': leadCategoryId,
        'referralName': referralName,
        'industrySegmentId': industrySegmentId,
        'designationId': designationId,
        'whatsappNumber': whatsappNumber,
        'website': website,
        'pincode': pincode,
        'leadScore': leadScore,
        'leadSourceDetails': leadSourceDetails,
        'preferredContactTime': preferredContactTime,
        'customerPainPoints': customerPainPoints,
        'competitors': competitors,
        'customerBudget': customerBudget,
        'numberOfEmployees': numberOfEmployees,
        'proposedSolution': proposedSolution,
        'userId': userId,
        'leadDescription': leadDescription,
        'reasonId': reasonId
      };
}
