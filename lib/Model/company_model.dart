class CompanyModel {
  final int? id;
  final String? name;
  final String? address;
  final int? cityId;
  final int? stateId;
  final int? countryId;
  final int? gstRegistrationTypeId;
  final String? gstRegistrationName;
  final String? gstNumber;
  final dynamic materialIds;
  final String? deleted;
  final String? pinCode;
  final String? primaryTelephone;
  final dynamic secondaryTelephone;
  final dynamic tinNumber;
  final dynamic tinDate;
  final dynamic faxNumber;
  final String? contactPersonName;
  final String? primaryMobile;
  final String? secondaryMobile;
  final String? email;
  final String? website;
  final String? contactPersonNumber;
  final dynamic statusId;
  final dynamic panNumber;
  final dynamic panDate;
  final dynamic companyLogoPath;
  final List<dynamic>? addressesListDTO;
  final String? stateCode;
  final String? stateName;
  final dynamic tagLine;
  final String? bank;
  final String? branch;
  final String? account;
  final String? ifsc;
  final int? companyCurrencyId;
  final int? bankAdCode;
  final dynamic ceritificateImagePath;
  final String? signatureImagePath;
  final dynamic msmeNumber;
  final dynamic swiftCode;
  final dynamic cinNumber;
  final dynamic subject;
  final dynamic iecCode;
  final String? companyAddress1;
  final dynamic companyAddress2;
  final dynamic subscriptionId;
  final dynamic paymentId;
  final String? subscriptionEnd;
  final String? subscriptionStart;
  final int? enableTrailAccount;
  final dynamic referedId;
  final dynamic refereeEmail;
  final dynamic schemeType;
  final dynamic planId;
  final dynamic qrcodeImagePath;

  CompanyModel({
    this.id,
    this.name,
    this.address,
    this.cityId,
    this.stateId,
    this.countryId,
    this.gstRegistrationTypeId,
    this.gstRegistrationName,
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
    this.addressesListDTO,
    this.stateCode,
    this.stateName,
    this.tagLine,
    this.bank,
    this.branch,
    this.account,
    this.ifsc,
    this.companyCurrencyId,
    this.bankAdCode,
    this.ceritificateImagePath,
    this.signatureImagePath,
    this.msmeNumber,
    this.swiftCode,
    this.cinNumber,
    this.subject,
    this.iecCode,
    this.companyAddress1,
    this.companyAddress2,
    this.subscriptionId,
    this.paymentId,
    this.subscriptionEnd,
    this.subscriptionStart,
    this.enableTrailAccount,
    this.referedId,
    this.refereeEmail,
    this.schemeType,
    this.planId,
    this.qrcodeImagePath,
  });

  CompanyModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        address = json['address'] as String?,
        cityId = json['cityId'] as int?,
        stateId = json['stateId'] as int?,
        countryId = json['countryId'] as int?,
        gstRegistrationTypeId = json['gstRegistrationTypeId'] as int?,
        gstRegistrationName = json['gstRegistrationName'] as String?,
        gstNumber = json['gstNumber'] as String?,
        materialIds = json['materialIds'],
        deleted = json['deleted'] as String?,
        pinCode = json['pinCode'] as String?,
        primaryTelephone = json['primaryTelephone'] as String?,
        secondaryTelephone = json['secondaryTelephone'],
        tinNumber = json['tinNumber'],
        tinDate = json['tinDate'],
        faxNumber = json['faxNumber'],
        contactPersonName = json['contactPersonName'] as String?,
        primaryMobile = json['primaryMobile'] as String?,
        secondaryMobile = json['secondaryMobile'] as String?,
        email = json['email'] as String?,
        website = json['website'] as String?,
        contactPersonNumber = json['contactPersonNumber'] as String?,
        statusId = json['statusId'],
        panNumber = json['panNumber'],
        panDate = json['panDate'],
        companyLogoPath = json['companyLogoPath'],
        addressesListDTO = json['addressesListDTO'] as List?,
        stateCode = json['stateCode'] as String?,
        stateName = json['stateName'] as String?,
        tagLine = json['tagLine'],
        bank = json['bank'] as String?,
        branch = json['branch'] as String?,
        account = json['account'] as String?,
        ifsc = json['ifsc'] as String?,
        companyCurrencyId = json['companyCurrencyId'] as int?,
        bankAdCode = json['bankAdCode'] as int?,
        ceritificateImagePath = json['ceritificateImagePath'],
        signatureImagePath = json['signatureImagePath'] as String?,
        msmeNumber = json['msmeNumber'],
        swiftCode = json['swiftCode'],
        cinNumber = json['cinNumber'],
        subject = json['subject'],
        iecCode = json['iecCode'],
        companyAddress1 = json['companyAddress1'] as String?,
        companyAddress2 = json['companyAddress2'],
        subscriptionId = json['subscriptionId'],
        paymentId = json['paymentId'],
        subscriptionEnd = json['subscriptionEnd'] as String?,
        subscriptionStart = json['subscriptionStart'] as String?,
        enableTrailAccount = json['enableTrailAccount'] as int?,
        referedId = json['referedId'],
        refereeEmail = json['refereeEmail'],
        schemeType = json['schemeType'],
        planId = json['planId'],
        qrcodeImagePath = json['qrcodeImagePath'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'cityId': cityId,
        'stateId': stateId,
        'countryId': countryId,
        'gstRegistrationTypeId': gstRegistrationTypeId,
        'gstRegistrationName': gstRegistrationName,
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
        'addressesListDTO': addressesListDTO,
        'stateCode': stateCode,
        'stateName': stateName,
        'tagLine': tagLine,
        'bank': bank,
        'branch': branch,
        'account': account,
        'ifsc': ifsc,
        'companyCurrencyId': companyCurrencyId,
        'bankAdCode': bankAdCode,
        'ceritificateImagePath': ceritificateImagePath,
        'signatureImagePath': signatureImagePath,
        'msmeNumber': msmeNumber,
        'swiftCode': swiftCode,
        'cinNumber': cinNumber,
        'subject': subject,
        'iecCode': iecCode,
        'companyAddress1': companyAddress1,
        'companyAddress2': companyAddress2,
        'subscriptionId': subscriptionId,
        'paymentId': paymentId,
        'subscriptionEnd': subscriptionEnd,
        'subscriptionStart': subscriptionStart,
        'enableTrailAccount': enableTrailAccount,
        'referedId': referedId,
        'refereeEmail': refereeEmail,
        'schemeType': schemeType,
        'planId': planId,
        'qrcodeImagePath': qrcodeImagePath
      };
}
