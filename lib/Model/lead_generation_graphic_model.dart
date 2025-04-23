class LeadGenerationGraphicModel {
  final String? id;
  final String? leadName;
  final String? leadGenerationNumber;
  final dynamic leadGenerationId;
  final String? leadGenerationDate;
  final String? deleted;
  final int? financialYearId;
  final int? companyId;
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
  final List<int>? interestedProductId;
  final int? conversionChanceId;
  final String? comments;
  final double? amount;
  final int? leadGenerationType;
  final int? statusId;
  final String? statusName;
  final int? assignedToId;
  final String? followUpDate;
  final dynamic followUpTime;
  final String? leadComments;
  final String? userComments;
  final int? isExistingCustomer;
  final dynamic partyId;
  final String? partyName;
  final dynamic productName;
  final List<dynamic>? interestedServiceId;
  final String? annualTurnOver;
  final String? leadGeoLocation;
  final int? leadOwnerId;
  final int? quickLead;
  final String? leadCompanyName;
  final dynamic leadCategoryId;
  final String? referralName;
  final dynamic industrySegmentId;
  final dynamic designationId;
  final dynamic whatsappNumber;
  final String? website;
  final dynamic pincode;
  final dynamic leadScore;
  final String? leadSourceDetails;
  final dynamic preferredContactTime;
  final String? customerPainPoints;
  final String? competitors;
  final dynamic customerBudget;
  final dynamic numberOfEmployees;
  final String? proposedSolution;
  final int? userId;
  final String? leadDescription;
  final String? createdDate;
  final dynamic reasonId;

  LeadGenerationGraphicModel({
    this.id,
    this.leadName,
    this.leadGenerationNumber,
    this.leadGenerationId,
    this.leadGenerationDate,
    this.deleted,
    this.financialYearId,
    this.companyId,
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
    this.conversionChanceId,
    this.comments,
    this.amount,
    this.leadGenerationType,
    this.statusId,
    this.statusName,
    this.assignedToId,
    this.followUpDate,
    this.followUpTime,
    this.leadComments,
    this.userComments,
    this.isExistingCustomer,
    this.partyId,
    this.partyName,
    this.productName,
    this.interestedServiceId,
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
    this.createdDate,
    this.reasonId,
  });

  LeadGenerationGraphicModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        leadName = json['leadName'] as String?,
        leadGenerationNumber = json['leadGenerationNumber'] as String?,
        leadGenerationId = json['leadGenerationId'],
        leadGenerationDate = json['leadGenerationDate'] as String?,
        deleted = json['deleted'] as String?,
        financialYearId = json['financialYearId'] as int?,
        companyId = json['companyId'] as int?,
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
        interestedProductId = (json['interestedProductId'] as List?)?.map((dynamic e) => e as int).toList(),
        conversionChanceId = json['conversionChanceId'] as int?,
        comments = json['comments'] as String?,
        amount = json['amount'] as double?,
        leadGenerationType = json['leadGenerationType'] as int?,
        statusId = json['statusId'] as int?,
        statusName = json['statusName'] as String?,
        assignedToId = json['assignedToId'] as int?,
        followUpDate = json['followUpDate'] as String?,
        followUpTime = json['followUpTime'],
        leadComments = json['leadComments'] as String?,
        userComments = json['userComments'] as String?,
        isExistingCustomer = json['isExistingCustomer'] as int?,
        partyId = json['partyId'],
        partyName = json['partyName'] as String?,
        productName = json['productName'],
        interestedServiceId = json['interestedServiceId'] as List?,
        annualTurnOver = json['annualTurnOver'] as String?,
        leadGeoLocation = json['leadGeoLocation'] as String?,
        leadOwnerId = json['leadOwnerId'] as int?,
        quickLead = json['quickLead'] as int?,
        leadCompanyName = json['leadCompanyName'] as String?,
        leadCategoryId = json['leadCategoryId'],
        referralName = json['referralName'] as String?,
        industrySegmentId = json['industrySegmentId'],
        designationId = json['designationId'],
        whatsappNumber = json['whatsappNumber'],
        website = json['website'] as String?,
        pincode = json['pincode'],
        leadScore = json['leadScore'],
        leadSourceDetails = json['leadSourceDetails'] as String?,
        preferredContactTime = json['preferredContactTime'],
        customerPainPoints = json['customerPainPoints'] as String?,
        competitors = json['competitors'] as String?,
        customerBudget = json['customerBudget'],
        numberOfEmployees = json['numberOfEmployees'],
        proposedSolution = json['proposedSolution'] as String?,
        userId = json['userId'] as int?,
        leadDescription = json['leadDescription'] as String?,
        createdDate = json['createdDate'] as String?,
        reasonId = json['reasonId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'leadName': leadName,
        'leadGenerationNumber': leadGenerationNumber,
        'leadGenerationId': leadGenerationId,
        'leadGenerationDate': leadGenerationDate,
        'deleted': deleted,
        'financialYearId': financialYearId,
        'companyId': companyId,
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
        'conversionChanceId': conversionChanceId,
        'comments': comments,
        'amount': amount,
        'leadGenerationType': leadGenerationType,
        'statusId': statusId,
        'statusName': statusName,
        'assignedToId': assignedToId,
        'followUpDate': followUpDate,
        'followUpTime': followUpTime,
        'leadComments': leadComments,
        'userComments': userComments,
        'isExistingCustomer': isExistingCustomer,
        'partyId': partyId,
        'partyName': partyName,
        'productName': productName,
        'interestedServiceId': interestedServiceId,
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
        'createdDate': createdDate,
        'reasonId': reasonId
      };
}
