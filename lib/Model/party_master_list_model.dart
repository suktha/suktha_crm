class PartyMasterListModel {
  final int? id;
  final String? name;
  final String? address;
  final int? countryId;
  final int? stateId;
  final String? stateCode;
  final String? stateName;
  final int? cityId;
  final int? areaId;
  final dynamic areaName;
  final dynamic pinCode;
  final dynamic primaryTelephone;
  final dynamic secondaryTelephone;
  final dynamic primaryMobile;
  final dynamic secondaryMobile;
  final String? email;
  final dynamic contactPersonName;
  final dynamic contactPersonNumber;
  final dynamic webSite;
  final int? partyTypeId;
  final String? partyTypeName;
  final String? deleted;
  final dynamic billAddress;
  final String? panNumber;
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

  PartyMasterListModel({
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
  });

  PartyMasterListModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = json['name'] as String?,
      address = json['address'] as String?,
      countryId = json['countryId'] as int?,
      stateId = json['stateId'] as int?,
      stateCode = json['stateCode'] as String?,
      stateName = json['stateName'] as String?,
      cityId = json['cityId'] as int?, 
      areaId = json['areaId'] as int?,
      areaName = json['areaName'],
      pinCode = json['pinCode'],
      primaryTelephone = json['primaryTelephone'],
      secondaryTelephone = json['secondaryTelephone'],
      primaryMobile = json['primaryMobile'],
      secondaryMobile = json['secondaryMobile'],
      email = json['email'] as String?,
      contactPersonName = json['contactPersonName'],
      contactPersonNumber = json['contactPersonNumber'],
      webSite = json['webSite'],
      partyTypeId = json['partyTypeId'] as int?,
      partyTypeName = json['partyTypeName'] as String?,
      deleted = json['deleted'] as String?,
      billAddress = json['billAddress'],
      panNumber = json['panNumber'] as String?,
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
      shipToAddress2 = json['shipToAddress2'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'address' : address,
    'countryId' : countryId,
    'stateId' : stateId,
    'stateCode' : stateCode,
    'stateName' : stateName,
    'cityId' : cityId,
    'areaId' : areaId,
    'areaName' : areaName,
    'pinCode' : pinCode,
    'primaryTelephone' : primaryTelephone,
    'secondaryTelephone' : secondaryTelephone,
    'primaryMobile' : primaryMobile,
    'secondaryMobile' : secondaryMobile,
    'email' : email,
    'contactPersonName' : contactPersonName,
    'contactPersonNumber' : contactPersonNumber,
    'webSite' : webSite,
    'partyTypeId' : partyTypeId,
    'partyTypeName' : partyTypeName,
    'deleted' : deleted,
    'billAddress' : billAddress,
    'panNumber' : panNumber,
    'gstRegistrationTypeId' : gstRegistrationTypeId,
    'gstNumber' : gstNumber,
    'addressesListDTO' : addressesListDTO,
    'dueDaysLimit' : dueDaysLimit,
    'isIgst' : isIgst,
    'partyId' : partyId,
    'partyCode' : partyCode,
    'vendorCode' : vendorCode,
    'partyCurrencyId' : partyCurrencyId,
    'partyCurrencyName' : partyCurrencyName,
    'shipToAddress2' : shipToAddress2
  };
}