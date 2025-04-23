class SupplierDetailedReportModel {
  final int? id;
  final String? name;
  final String? address;
  final int? countryId;
  final int? stateId;
  final String? stateCode;
  final String? stateName;
  final int? cityId;
  final int? areaId;
  final String? areaName;
  final String? pinCode;
  final String? primaryTelephone;
  final String? secondaryTelephone;
  final String? primaryMobile;
  final String? secondaryMobile;
  final String? email;
  final String? contactPersonName;
  final String? contactPersonNumber;
  final String? webSite;
  final int? partyTypeId;
  final String? partyTypeName;
  final String? deleted;
  final String? billAddress;
  final String? panNumber;
  final int? gstRegistrationTypeId;
  final String? gstNumber;
  final List<dynamic>? addressesListDTO;
  final dynamic dueDaysLimit;
  final int? isIgst;
  final int? partyId;
  final String? partyCode;
  final String? vendorCode;
  final dynamic partyCurrencyId;
  final dynamic partyCurrencyName;
  final String? shipToAddress2;
  final dynamic geoLocation;

  SupplierDetailedReportModel({
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
  });

  SupplierDetailedReportModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = json['name'] as String?,
      address = json['address'] as String?,
      countryId = json['countryId'] as int?,
      stateId = json['stateId'] as int?,
      stateCode = json['stateCode'] as String?,
      stateName = json['stateName'] as String?,
      cityId = json['cityId'] as int?,
      areaId = json['areaId'] as int?,
      areaName = json['areaName'] as String?,
      pinCode = json['pinCode'] as String?,
      primaryTelephone = json['primaryTelephone'] as String?,
      secondaryTelephone = json['secondaryTelephone'] as String?,
      primaryMobile = json['primaryMobile'] as String?,
      secondaryMobile = json['secondaryMobile'] as String?,
      email = json['email'] as String?,
      contactPersonName = json['contactPersonName'] as String?,
      contactPersonNumber = json['contactPersonNumber'] as String?,
      webSite = json['webSite'] as String?,
      partyTypeId = json['partyTypeId'] as int?,
      partyTypeName = json['partyTypeName'] as String?,
      deleted = json['deleted'] as String?,
      billAddress = json['billAddress'] as String?,
      panNumber = json['panNumber'] as String?,
      gstRegistrationTypeId = json['gstRegistrationTypeId'] as int?,
      gstNumber = json['gstNumber'] as String?,
      addressesListDTO = json['addressesListDTO'] as List?,
      dueDaysLimit = json['dueDaysLimit'],
      isIgst = json['isIgst'] as int?,
      partyId = json['partyId'] as int?,
      partyCode = json['partyCode'] as String?,
      vendorCode = json['vendorCode'] as String?,
      partyCurrencyId = json['partyCurrencyId'],
      partyCurrencyName = json['partyCurrencyName'],
      shipToAddress2 = json['shipToAddress2'] as String?,
      geoLocation = json['geoLocation'];

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
    'shipToAddress2' : shipToAddress2,
    'geoLocation' : geoLocation
  };
}