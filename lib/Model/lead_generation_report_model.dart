class LeadGenerationReportModel {
  final String? id;
  final String? leadName;
  final String? leadGenerationNumber;
  final String? leadGenerationDate;
  final String? cityName;
  final String? areaName;
  final String? countryName;
  final String? stateName;
  final String? mobileNo;
  final String? email;
  final String? priorityName;
  final String? sourceName;
  final String? interestedProductNames;
  final String? interestedServiceNames;
  final String? conversionChanceName;
  final double? amount;
  final String? statusName;
  final String? assignedToName;
  final String? followUpDate;
  final String? annualTurnOver;
  final String? leadOwnerName;
  final String? leadCategory;
  final String? industrySegment;
  final String? createdByName;

  LeadGenerationReportModel({
    this.id,
    this.leadName,
    this.leadGenerationNumber,
    this.leadGenerationDate,
    this.cityName,
    this.areaName,
    this.countryName,
    this.stateName,
    this.mobileNo,
    this.email,
    this.priorityName,
    this.sourceName,
    this.interestedProductNames,
    this.interestedServiceNames,
    this.conversionChanceName,
    this.amount,
    this.statusName,
    this.assignedToName,
    this.followUpDate,
    this.annualTurnOver,
    this.leadOwnerName,
    this.leadCategory,
    this.industrySegment,
    this.createdByName,
  });

  LeadGenerationReportModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        leadName = json['leadName'] as String?,
        leadGenerationNumber = json['leadGenerationNumber'] as String?,
        leadGenerationDate = json['leadGenerationDate'] as String?,
        cityName = json['cityName'] as String?,
        areaName = json['areaName'] as String?,
        countryName = json['countryName'] as String?,
        stateName = json['stateName'] as String?,
        mobileNo = json['mobileNo'] as String?,
        email = json['email'] as String?,
        priorityName = json['priorityName'] as String?,
        sourceName = json['sourceName'] as String?,
        interestedProductNames = json['interestedProductNames'] as String?,
        interestedServiceNames = json['interestedServiceNames'] as String?,
        conversionChanceName = json['conversionChanceName'] as String?,
        amount = json['amount'] as double?,
        statusName = json['statusName'] as String?,
        assignedToName = json['assignedToName'] as String?,
        followUpDate = json['followUpDate'] as String?,
        annualTurnOver = json['annualTurnOver'] as String?,
        leadOwnerName = json['leadOwnerName'] as String?,
        leadCategory = json['leadCategory'] as String?,
        industrySegment = json['industrySegment'] as String?,
        createdByName = json['createdByName'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'leadName': leadName,
        'leadGenerationNumber': leadGenerationNumber,
        'leadGenerationDate': leadGenerationDate,
        'cityName': cityName,
        'areaName': areaName,
        'countryName': countryName,
        'stateName': stateName,
        'mobileNo': mobileNo,
        'email': email,
        'priorityName': priorityName,
        'sourceName': sourceName,
        'interestedProductNames': interestedProductNames,
        'interestedServiceNames': interestedServiceNames,
        'conversionChanceName': conversionChanceName,
        'amount': amount,
        'statusName': statusName,
        'assignedToName': assignedToName,
        'followUpDate': followUpDate,
        'annualTurnOver': annualTurnOver,
        'leadOwnerName': leadOwnerName,
        'leadCategory': leadCategory,
        'industrySegment': industrySegment,
        'createdByName': createdByName
      };
}
