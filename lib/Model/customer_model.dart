class CustomerModel {
  int? id;
  String? name;
  String? address;
  int? countryId;
  int? stateId;
  String? stateCode;
  String? stateName;
  dynamic cityId;
  dynamic areaId;
  dynamic areaName;
  dynamic pinCode;
  dynamic primaryTelephone;
  dynamic secondaryTelephone;
  String? primaryMobile;
  dynamic secondaryMobile;
  String? email;
  dynamic contactPersonName;
  dynamic contactPersonNumber;
  dynamic webSite;
  int? partyTypeId;
  String? partyTypeName;
  String? deleted;
  dynamic billAddress;
  dynamic panNumber;
  int? gstRegistrationTypeId;
  String? gstNumber;
  List<dynamic>? addressesListDTO;
  dynamic dueDaysLimit;
  int? isIgst;
  int? partyId;
  String? partyCode;
  dynamic vendorCode;
  dynamic partyCurrencyId;
  dynamic partyCurrencyName;
  dynamic shipToAddress2;
  dynamic geoLocation;
  dynamic classificationId;
  dynamic storedPartyId;

  CustomerModel({
    this.id,
    this.name,
    this.address,
    this.countryId,
    this.stateId,
    this.stateCode,
    this.stateName,
    this.cityId,
    this.areaId,
    this.areaName,
    this.pinCode,
    this.primaryTelephone,
    this.secondaryTelephone,
    this.primaryMobile,
    this.secondaryMobile,
    this.email,
    this.contactPersonName,
    this.contactPersonNumber,
    this.webSite,
    this.partyTypeId,
    this.partyTypeName,
    this.deleted,
    this.billAddress,
    this.panNumber,
    this.gstRegistrationTypeId,
    this.gstNumber,
    this.addressesListDTO,
    this.dueDaysLimit,
    this.isIgst,
    this.partyId,
    this.partyCode,
    this.vendorCode,
    this.partyCurrencyId,
    this.partyCurrencyName,
    this.shipToAddress2,
    this.geoLocation,
    this.storedPartyId,
    this.classificationId,
  });

  CustomerModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        address = json['address'] as String?,
        countryId = json['countryId'] as int?,
        stateId = json['stateId'] as int?,
        stateCode = json['stateCode'] as String?,
        stateName = json['stateName'] as String?,
        cityId = json['cityId'],
        areaId = json['areaId'],
        areaName = json['areaName'],
        pinCode = json['pinCode'],
        primaryTelephone = json['primaryTelephone'],
        secondaryTelephone = json['secondaryTelephone'],
        primaryMobile = json['primaryMobile'] as String?,
        secondaryMobile = json['secondaryMobile'],
        email = json['email'] as String?,
        contactPersonName = json['contactPersonName'],
        contactPersonNumber = json['contactPersonNumber'],
        webSite = json['webSite'],
        partyTypeId = json['partyTypeId'] as int?,
        partyTypeName = json['partyTypeName'] as String?,
        deleted = json['deleted'] as String?,
        billAddress = json['billAddress'],
        panNumber = json['panNumber'],
        gstRegistrationTypeId = json['gstRegistrationTypeId'] as int?,
        gstNumber = json['gstNumber'] as String?,
        addressesListDTO = json['addressesListDTO'] as List?,
        dueDaysLimit = json['dueDaysLimit'],
        isIgst = json['isIgst'] as int?,
        partyId = json['partyId'] as int?,
        partyCode = json['partyCode'] as String?,
        vendorCode = json['vendorCode'],
        partyCurrencyId = json['partyCurrencyId'],
        partyCurrencyName = json['partyCurrencyName'],
        shipToAddress2 = json['shipToAddress2'],
        classificationId = json['classificationId'],
        storedPartyId = json['storedPartyId'],
        geoLocation = json['geoLocation'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'countryId': countryId,
        'stateId': stateId,
        'stateCode': stateCode,
        'stateName': stateName,
        'cityId': cityId,
        'areaId': areaId,
        'areaName': areaName,
        'pinCode': pinCode,
        'primaryTelephone': primaryTelephone,
        'secondaryTelephone': secondaryTelephone,
        'primaryMobile': primaryMobile,
        'secondaryMobile': secondaryMobile,
        'email': email,
        'contactPersonName': contactPersonName,
        'contactPersonNumber': contactPersonNumber,
        'webSite': webSite,
        'partyTypeId': partyTypeId,
        'partyTypeName': partyTypeName,
        'deleted': deleted,
        'billAddress': billAddress,
        'panNumber': panNumber,
        'gstRegistrationTypeId': gstRegistrationTypeId,
        'gstNumber': gstNumber,
        'addressesListDTO': addressesListDTO,
        'dueDaysLimit': dueDaysLimit,
        'isIgst': isIgst,
        'partyId': partyId,
        'partyCode': partyCode,
        'vendorCode': vendorCode,
        'partyCurrencyId': partyCurrencyId,
        'partyCurrencyName': partyCurrencyName,
        'shipToAddress2': shipToAddress2,
        'storedPartyId': storedPartyId,
        'classificationId': classificationId,
        'geoLocation': geoLocation
      };
}

class CustomerInputedModel {
  String? quotationNumber;
  String? quotationDate;
  String? mobileNumber;
  String? email;
  String? enquiryNumber;
  String? enquiryDate;
  String? subject;
  String? kindAttention;
  String? remarks;

  CustomerInputedModel({
    this.quotationNumber,
    this.quotationDate,
    this.mobileNumber,
    this.email,
    this.enquiryNumber,
    this.enquiryDate,
    this.subject,
    this.kindAttention,
    this.remarks,
  });

  CustomerInputedModel.fromJson(Map<String, dynamic> json) {
    quotationNumber = json['quotationNumber'] as String?;
    quotationDate = json['quotationDate'] as String?;
    mobileNumber = json['mobileNumber'] as String?;
    email = json['email'] as String?;
    enquiryNumber = json['enquiryNumber'] as String?;
    enquiryDate = json['enquiryDate'] as String?;
    subject = json['subject'] as String?;
    kindAttention = json['kindAttention'] as String?;
    remarks = json['remarks'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['quotationNumber'] = quotationNumber;

    json['quotationDate'] = quotationDate;
    json['mobileNumber'] = mobileNumber;
    json['email'] = email;
    json['enquiryNumber'] = enquiryNumber;
    json['enquiryDate'] = enquiryDate;
    json['subject'] = subject;
    json['kindAttention'] = kindAttention;
    json['remarks'] = remarks;
    return json;
  }
}
