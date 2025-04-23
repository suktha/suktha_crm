class CompanyyProfileDetailsModel {
  final CompanyDTO? companyDTO;
  final List<PartyBankMapDTOList>? partyBankMapDTOList;
  final List<PartyContactDetails>? partyContactDetails;
  final List<dynamic>? partyBankMapListDeletedIds;
  final List<dynamic>? contactDeletedIds;
  final List<BranchDTOList>? branchDTOList;

  CompanyyProfileDetailsModel({
    this.companyDTO,
    this.partyBankMapDTOList,
    this.partyContactDetails,
    this.partyBankMapListDeletedIds,
    this.contactDeletedIds,
    this.branchDTOList,
  });

  CompanyyProfileDetailsModel.fromJson(Map<String, dynamic> json)
      : companyDTO = (json['companyDTO'] as Map<String, dynamic>?) != null ? CompanyDTO.fromJson(json['companyDTO'] as Map<String, dynamic>) : null,
        partyBankMapDTOList = (json['partyBankMapDTOList'] as List?)?.map((dynamic e) => PartyBankMapDTOList.fromJson(e as Map<String, dynamic>)).toList(),
        partyContactDetails = (json['partyContactDetails'] as List?)?.map((dynamic e) => PartyContactDetails.fromJson(e as Map<String, dynamic>)).toList(),
        partyBankMapListDeletedIds = json['partyBankMapListDeletedIds'] as List?,
        contactDeletedIds = json['contactDeletedIds'] as List?,
        branchDTOList = (json['branchDTOList'] as List?)?.map((dynamic e) => BranchDTOList.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'companyDTO': companyDTO?.toJson(),
        'partyBankMapDTOList': partyBankMapDTOList?.map((e) => e.toJson()).toList(),
        'partyContactDetails': partyContactDetails?.map((e) => e.toJson()).toList(),
        'partyBankMapListDeletedIds': partyBankMapListDeletedIds,
        'contactDeletedIds': contactDeletedIds,
        'branchDTOList': branchDTOList?.map((e) => e.toJson()).toList(),
      };
}

class BranchDTOList {
  int? id;
  String? name;
  dynamic deleted;
  int? branchAdminId;
  String? branchAdminName;

  BranchDTOList({
    this.id,
    this.name,
    this.deleted,
    this.branchAdminId,
    this.branchAdminName,
  });

  BranchDTOList.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        deleted = json['deleted'],
        branchAdminId = json['branchAdminId'] as int?,
        branchAdminName = json['branchAdminName'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'deleted': deleted, 'branchAdminId': branchAdminId, 'branchAdminName': branchAdminName};
}

class CompanyDTO {
  final int? id;
  final String? name;
  final String? address;
  final int? cityId;
  final int? stateId;
  final int? countryId;
  final String? gstNumber;
  final dynamic materialIds;
  final String? deleted;
  final String? pinCode;
  final String? primaryTelephone;
  final String? secondaryTelephone;
  final dynamic tinNumber;
  final dynamic tinDate;
  final String? faxNumber;
  final String? contactPersonName;
  final String? primaryMobile;
  final String? secondaryMobile;
  final String? email;
  final String? website;
  final String? contactPersonNumber;
  final dynamic statusId;
  final String? panNumber;
  final dynamic panDate;
  final String? companyLogoPath;
  final String? tagLine;
  final int? gstRegistrationTypeId;
  final List<dynamic>? addressesListDTO;
  final dynamic ceritificateImagePath;
  final String? signatureImagePath;
  final dynamic qRCodeImagePath;
  final String? msmeNumber;
  final dynamic cinNumber;
  final String? subject;
  final dynamic iecCode;
  final int? companyCurrencyId;
  final String? subscriptionEnd;
  final String? subscriptionStart;
  final dynamic planId;
  final dynamic subscriptionId;
  final dynamic paymentId;
  final int? enableTrailAccount;
  final dynamic referedId;
  final dynamic refereeEmail;
  final dynamic schemeType;

  CompanyDTO({
    this.id,
    this.name,
    this.address,
    this.cityId,
    this.stateId,
    this.countryId,
    this.gstNumber,
    this.materialIds,
    this.deleted,
    this.pinCode,
    this.primaryTelephone,
    this.secondaryTelephone,
    this.tinNumber,
    this.tinDate,
    this.faxNumber,
    this.contactPersonName,
    this.primaryMobile,
    this.secondaryMobile,
    this.email,
    this.website,
    this.contactPersonNumber,
    this.statusId,
    this.panNumber,
    this.panDate,
    this.companyLogoPath,
    this.tagLine,
    this.gstRegistrationTypeId,
    this.addressesListDTO,
    this.ceritificateImagePath,
    this.signatureImagePath,
    this.qRCodeImagePath,
    this.msmeNumber,
    this.cinNumber,
    this.subject,
    this.iecCode,
    this.companyCurrencyId,
    this.subscriptionEnd,
    this.subscriptionStart,
    this.planId,
    this.subscriptionId,
    this.paymentId,
    this.enableTrailAccount,
    this.referedId,
    this.refereeEmail,
    this.schemeType,
  });

  CompanyDTO.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        address = json['address'] as String?,
        cityId = json['cityId'] as int?,
        stateId = json['stateId'] as int?,
        countryId = json['countryId'] as int?,
        gstNumber = json['gstNumber'] as String?,
        materialIds = json['materialIds'],
        deleted = json['deleted'] as String?,
        pinCode = json['pinCode'] as String?,
        primaryTelephone = json['primaryTelephone'] as String?,
        secondaryTelephone = json['secondaryTelephone'] as String?,
        tinNumber = json['tinNumber'],
        tinDate = json['tinDate'],
        faxNumber = json['faxNumber'] as String?,
        contactPersonName = json['contactPersonName'] as String?,
        primaryMobile = json['primaryMobile'] as String?,
        secondaryMobile = json['secondaryMobile'] as String?,
        email = json['email'] as String?,
        website = json['website'] as String?,
        contactPersonNumber = json['contactPersonNumber'] as String?,
        statusId = json['statusId'],
        panNumber = json['panNumber'] as String?,
        panDate = json['panDate'],
        companyLogoPath = json['companyLogoPath'] as String?,
        tagLine = json['tagLine'] as String?,
        gstRegistrationTypeId = json['gstRegistrationTypeId'] as int?,
        addressesListDTO = json['addressesListDTO'] as List?,
        ceritificateImagePath = json['ceritificateImagePath'],
        signatureImagePath = json['signatureImagePath'] as String?,
        qRCodeImagePath = json['qRCodeImagePath'],
        msmeNumber = json['msmeNumber'] as String?,
        cinNumber = json['cinNumber'],
        subject = json['subject'] as String?,
        iecCode = json['iecCode'],
        companyCurrencyId = json['companyCurrencyId'] as int?,
        subscriptionEnd = json['subscriptionEnd'] as String?,
        subscriptionStart = json['subscriptionStart'] as String?,
        planId = json['planId'],
        subscriptionId = json['subscriptionId'],
        paymentId = json['paymentId'],
        enableTrailAccount = json['enableTrailAccount'] as int?,
        referedId = json['referedId'],
        refereeEmail = json['refereeEmail'],
        schemeType = json['schemeType'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'cityId': cityId,
        'stateId': stateId,
        'countryId': countryId,
        'gstNumber': gstNumber,
        'materialIds': materialIds,
        'deleted': deleted,
        'pinCode': pinCode,
        'primaryTelephone': primaryTelephone,
        'secondaryTelephone': secondaryTelephone,
        'tinNumber': tinNumber,
        'tinDate': tinDate,
        'faxNumber': faxNumber,
        'contactPersonName': contactPersonName,
        'primaryMobile': primaryMobile,
        'secondaryMobile': secondaryMobile,
        'email': email,
        'website': website,
        'contactPersonNumber': contactPersonNumber,
        'statusId': statusId,
        'panNumber': panNumber,
        'panDate': panDate,
        'companyLogoPath': companyLogoPath,
        'tagLine': tagLine,
        'gstRegistrationTypeId': gstRegistrationTypeId,
        'addressesListDTO': addressesListDTO,
        'ceritificateImagePath': ceritificateImagePath,
        'signatureImagePath': signatureImagePath,
        'qRCodeImagePath': qRCodeImagePath,
        'msmeNumber': msmeNumber,
        'cinNumber': cinNumber,
        'subject': subject,
        'iecCode': iecCode,
        'companyCurrencyId': companyCurrencyId,
        'subscriptionEnd': subscriptionEnd,
        'subscriptionStart': subscriptionStart,
        'planId': planId,
        'subscriptionId': subscriptionId,
        'paymentId': paymentId,
        'enableTrailAccount': enableTrailAccount,
        'referedId': referedId,
        'refereeEmail': refereeEmail,
        'schemeType': schemeType
      };
}

class PartyBankMapDTOList {
  int? id;
  int? companyId;
  dynamic partyId;
  int? bankId;
  String? bankname;
  String? branch;
  String? ifsc;
  String? accountNumber;
  int? bankAdCode;
  dynamic openingBalance;
  dynamic contactNumber;
  dynamic swiftCode;
  int? isChecked;

  PartyBankMapDTOList({
    this.id,
    this.companyId,
    this.partyId,
    this.bankId,
    this.bankname,
    this.branch,
    this.ifsc,
    this.accountNumber,
    this.bankAdCode,
    this.openingBalance,
    this.contactNumber,
    this.swiftCode,
    this.isChecked,
  });

  PartyBankMapDTOList.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        companyId = json['companyId'] as int?,
        partyId = json['partyId'],
        bankId = json['bankId'] as int?,
        bankname = json['bankname'] as String?,
        branch = json['branch'] as String?,
        ifsc = json['ifsc'] as String?,
        accountNumber = json['accountNumber'] as String?,
        bankAdCode = json['bankAdCode'] as int?,
        openingBalance = json['openingBalance'],
        contactNumber = json['contactNumber'],
        swiftCode = json['swiftCode'],
        isChecked = json['isChecked'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'companyId': companyId,
        'partyId': partyId,
        'bankId': bankId,
        'bankname': bankname,
        'branch': branch,
        'ifsc': ifsc,
        'accountNumber': accountNumber,
        'bankAdCode': bankAdCode,
        'openingBalance': openingBalance,
        'contactNumber': contactNumber,
        'swiftCode': swiftCode,
        'isChecked': isChecked
      };
}

class PartyContactDetails {
  dynamic id;
  dynamic partyId;
  dynamic deleted;
  dynamic name;
  String? department;
  String? designation;
  int? departmentId;
  int? designationId;
  dynamic email;
  dynamic primaryPhoneNumber;
  dynamic secondaryPhoneNumber;
  dynamic remarks;
  dynamic companyId;
  dynamic isPrimary;
  dynamic imp;

  PartyContactDetails({
    this.id,
    this.partyId,
    this.deleted,
    this.name,
    this.department,
    this.designation,
    this.departmentId,
    this.designationId,
    this.email,
    this.primaryPhoneNumber,
    this.secondaryPhoneNumber,
    this.remarks,
    this.companyId,
    this.isPrimary,
    this.imp,
  });

  PartyContactDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        partyId = json['partyId'],
        deleted = json['deleted'],
        name = json['name'],
        department = json['department'] as String?,
        designation = json['designation'] as String?,
        departmentId = json['departmentId'] as int?,
        designationId = json['designationId'] as int?,
        email = json['email'],
        primaryPhoneNumber = json['primaryPhoneNumber'],
        secondaryPhoneNumber = json['secondaryPhoneNumber'],
        remarks = json['remarks'],
        companyId = json['companyId'],
        isPrimary = json['isPrimary'],
        imp = json['imp'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'partyId': partyId,
        'deleted': deleted,
        'name': name,
        'department': department,
        'designation': designation,
        'departmentId': departmentId,
        'designationId': designationId,
        'email': email,
        'primaryPhoneNumber': primaryPhoneNumber,
        'secondaryPhoneNumber': secondaryPhoneNumber,
        'remarks': remarks,
        'companyId': companyId,
        'isPrimary': isPrimary,
        'imp': imp
      };
}
