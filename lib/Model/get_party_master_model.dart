import 'package:work_Force/Model/company_profile_model.dart';
import 'package:work_Force/Model/material_price_model.dart';
import 'package:work_Force/Model/party_contact_model.dart';

class GetPartyMasterModel {
  final List<PartyWithPriceLists>? partyWithPriceLists;
  final int? totalCount;

  GetPartyMasterModel({
    this.partyWithPriceLists,
    this.totalCount,
  });

  GetPartyMasterModel.fromJson(Map<String, dynamic> json)
      : partyWithPriceLists = (json['partyWithPriceLists'] as List?)?.map((dynamic e) => PartyWithPriceLists.fromJson(e as Map<String, dynamic>)).toList(),
        totalCount = json['totalCount'] as int?;

  Map<String, dynamic> toJson() => {'partyWithPriceLists': partyWithPriceLists?.map((e) => e.toJson()).toList(), 'totalCount': totalCount};
}

class PartyWithPriceLists {
  final PartyDTO? partyDTO;
  final List<MaterialPriceListDTOList>? materialPriceListDTOList;
  final dynamic materialPriceListDeletedIds;
  final List<PartyBankMapDTOList>? partyBankMapDTOList;
  final dynamic partyBankMapDeletedIds;
  final List<PartyContactDetails>? partyContactDetails;
  final dynamic contactDeletedIds;
  final dynamic termsAndConditionDTOS;
  final List<TermsAndConditions>? termsAndConditions;

  PartyWithPriceLists({
    this.partyDTO,
    this.materialPriceListDTOList,
    this.materialPriceListDeletedIds,
    this.partyBankMapDTOList,
    this.partyBankMapDeletedIds,
    this.partyContactDetails,
    this.contactDeletedIds,
    this.termsAndConditionDTOS,
    this.termsAndConditions,
  });

  PartyWithPriceLists.fromJson(Map<String, dynamic> json)
      : partyDTO = (json['partyDTO'] as Map<String, dynamic>?) != null ? PartyDTO.fromJson(json['partyDTO'] as Map<String, dynamic>) : null,
        materialPriceListDTOList = (json['materialPriceListDTOList'] as List?)?.map((dynamic e) => MaterialPriceListDTOList.fromJson(e as Map<String, dynamic>)).toList(),
        materialPriceListDeletedIds = json['materialPriceListDeletedIds'],
        partyBankMapDTOList = (json['partyBankMapDTOList'] as List?)?.map((dynamic e) => PartyBankMapDTOList.fromJson(e as Map<String, dynamic>)).toList(),
        partyBankMapDeletedIds = json['partyBankMapDeletedIds'],
        partyContactDetails = (json['partyContactDetails'] as List?)?.map((dynamic e) => PartyContactDetails.fromJson(e as Map<String, dynamic>)).toList(),
        contactDeletedIds = json['contactDeletedIds'],
        termsAndConditionDTOS = json['termsAndConditionDTOS'],
        termsAndConditions = (json['termsAndConditions'] as List?)?.map((dynamic e) => TermsAndConditions.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'partyDTO': partyDTO?.toJson(),
        'materialPriceListDTOList': materialPriceListDTOList?.map((e) => e.toJson()).toList(),
        'materialPriceListDeletedIds': materialPriceListDeletedIds,
        'partyBankMapDTOList': partyBankMapDTOList?.map((e) => e.toJson()).toList(),
        'partyBankMapDeletedIds': partyBankMapDeletedIds,
        'partyContactDetails': partyContactDetails,
        'contactDeletedIds': contactDeletedIds,
        'termsAndConditionDTOS': termsAndConditionDTOS,
        'termsAndConditions': termsAndConditions?.map((e) => e.toJson()).toList()
      };
}

class PartyDTO {
  final int? id;
   String? name;
  final String? address;
  final int? countryId;
  final int? stateId;
  final String? stateCode;
  final String? stateName;
  final int? cityId;
  final dynamic areaId;
  final dynamic areaName;
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
  final dynamic classificationId;

  PartyDTO({
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
    this.classificationId,
  });

  PartyDTO.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        address = json['address'] as String?,
        countryId = json['countryId'] as int?,
        stateId = json['stateId'] as int?,
        stateCode = json['stateCode'] as String?,
        stateName = json['stateName'] as String?,
        cityId = json['cityId'] as int?,
        areaId = json['areaId'],
        areaName = json['areaName'],
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
        addressesListDTO = json['addressesListDTO'],
        dueDaysLimit = json['dueDaysLimit'],
        isIgst = json['isIgst'] as int?,
        partyId = json['partyId'] as int?,
        partyCode = json['partyCode'] as String?,
        vendorCode = json['vendorCode'] as String?,
        partyCurrencyId = json['partyCurrencyId'],
        partyCurrencyName = json['partyCurrencyName'],
        shipToAddress2 = json['shipToAddress2'] as String?,
        geoLocation = json['geoLocation'],
        classificationId = json['classificationId'];

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
        'geoLocation': geoLocation,
        'classificationId': classificationId
      };
}


class TermsAndConditions {
  int? id;
  String? name;
  String? termsAndCondition;
  dynamic paymentTerms;
  dynamic deliveryTerms;
  dynamic defaultTermsAndCondition;
  int? transactionTypeId;
  String? deleted;
  int? partyId;

  TermsAndConditions({
    this.id,
    this.name,
    this.termsAndCondition,
    this.paymentTerms,
    this.deliveryTerms,
    this.defaultTermsAndCondition,
    this.transactionTypeId,
    this.deleted,
    this.partyId,
  });

  TermsAndConditions.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        termsAndCondition = json['termsAndCondition'] as String?,
        paymentTerms = json['paymentTerms'],
        deliveryTerms = json['deliveryTerms'],
        defaultTermsAndCondition = json['defaultTermsAndCondition'],
        transactionTypeId = json['transactionTypeId'] as int?,
        deleted = json['deleted'] as String?,
        partyId = json['partyId'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'termsAndCondition': termsAndCondition,
        'paymentTerms': paymentTerms,
        'deliveryTerms': deliveryTerms,
        'defaultTermsAndCondition': defaultTermsAndCondition,
        'transactionTypeId': transactionTypeId,
        'deleted': deleted,
        'partyId': partyId
      };
}
