class CustomerDetailedReportModel {
  final int? id;
  final String? name;
  final String? address;
  final String? countryName;
  final int? stateId;
  final String? stateCode;
  final String? stateName;
  final dynamic cityName;
  final dynamic areaId;
  final dynamic areaName;
  final dynamic pinCode;
  final dynamic primaryTelephone;
  final dynamic secondaryTelephone;
  final String? primaryMobile;
  final dynamic secondaryMobile;
  final String? email;
  final dynamic contactPersonName;
  final dynamic createdDateTime;
  final dynamic contactPersonNumber;
  final dynamic webSite;
  final int? partyTypeId;
  final String? partyTypeName;
  final String? deleted;
  final dynamic billAddress;
  final dynamic panNumber;
  final int? gstRegistrationTypeId;
  final String? gstNumber;
  final List<dynamic>? addressesListDTO;
  final dynamic dueDaysLimit;
  final int? isIgst;
  final int? partyId;
  final String? partyCode;
  final dynamic vendorCode;
  final dynamic partyCurrencyId;
  final dynamic partyCurrencyName;
  final dynamic shipToAddress2;
  final dynamic geoLocation;

  CustomerDetailedReportModel({
    this.id,
    this.name,
    this.address,
    this.countryName,
    this.stateId,
    this.stateCode,
    this.stateName,
    this.cityName,
    this.areaId,
    this.areaName,
    this.pinCode,
    this.primaryTelephone,
    this.secondaryTelephone,
    this.primaryMobile,
    this.secondaryMobile,
    this.email,
    this.contactPersonName,
    this.createdDateTime,
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
  });

  CustomerDetailedReportModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        address = json['address'] as String?,
        countryName = json['countryName'] as String?,
        stateId = json['stateId'] as int?,
        stateCode = json['stateCode'] as String?,
        stateName = json['stateName'] as String?,
        cityName = json['cityName'],
        areaId = json['areaId'],
        areaName = json['areaName'],
        pinCode = json['pinCode'],
        primaryTelephone = json['primaryTelephone'],
        secondaryTelephone = json['secondaryTelephone'],
        primaryMobile = json['primaryMobile'] as String?,
        secondaryMobile = json['secondaryMobile'],
        email = json['email'] as String?,
        contactPersonName = json['contactPersonName'],
        createdDateTime = json['createdDateTime'],
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
        geoLocation = json['geoLocation'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'countryName': countryName,
        'stateId': stateId,
        'stateCode': stateCode,
        'stateName': stateName,
        'cityName': cityName,
        'areaId': areaId,
        'areaName': areaName,
        'pinCode': pinCode,
        'primaryTelephone': primaryTelephone,
        'secondaryTelephone': secondaryTelephone,
        'primaryMobile': primaryMobile,
        'secondaryMobile': secondaryMobile,
        'email': email,
        'contactPersonName': contactPersonName,
        'createdDateTime': createdDateTime,
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
        'geoLocation': geoLocation
      };
}
