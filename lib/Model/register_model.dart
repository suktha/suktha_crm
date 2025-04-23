class RegisterModel {
  final UserDTO? userDTO;
  final CompanyDTO? companyDTO;
  final int? enableJobwork;
  final int? enableTrailAccount;
  final int? agreeTermsAndCondtion;

  RegisterModel({
    this.userDTO,
    this.companyDTO,
    this.enableJobwork,
    this.enableTrailAccount,
    this.agreeTermsAndCondtion,
  });

  RegisterModel.fromJson(Map<String, dynamic> json)
      : userDTO = (json['userDTO'] as Map<String, dynamic>?) != null ? UserDTO.fromJson(json['userDTO'] as Map<String, dynamic>) : null,
        companyDTO =
            (json['companyDTO'] as Map<String, dynamic>?) != null ? CompanyDTO.fromJson(json['companyDTO'] as Map<String, dynamic>) : null,
        enableJobwork = json['enableJobwork'] as int?,
        enableTrailAccount = json['enableTrailAccount'] as int?,
        agreeTermsAndCondtion = json['agreeTermsAndCondtion'] as int?;

  Map<String, dynamic> toJson() => {
        'userDTO': userDTO?.toJson(),
        'companyDTO': companyDTO?.toJson(),
        'enableJobwork': enableJobwork,
        'enableTrailAccount': enableTrailAccount,
        'agreeTermsAndCondtion': agreeTermsAndCondtion
      };
}

class UserDTO {
  final dynamic id;
  final String? username;
  final String? email;
  final String? password;
  final String? name;
  final dynamic currentAddress;
  final int? isLogInRequired;
  final dynamic employeeNumber;
  final String? mobileNumber;

  UserDTO({
    this.id,
    this.username,
    this.email,
    this.password,
    this.name,
    this.currentAddress,
    this.isLogInRequired,
    this.employeeNumber,
    this.mobileNumber,
  });

  UserDTO.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'] as String?,
        email = json['email'] as String?,
        password = json['password'] as String?,
        name = json['name'] as String?,
        currentAddress = json['currentAddress'],
        isLogInRequired = json['isLogInRequired'] as int?,
        employeeNumber = json['employeeNumber'],
        mobileNumber = json['mobileNumber'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'password': password,
        'name': name,
        'currentAddress': currentAddress,
        'isLogInRequired': isLogInRequired,
        'employeeNumber': employeeNumber,
        'mobileNumber': mobileNumber
      };
}

class CompanyDTO {
  final dynamic id;
  final String? name;
  final String? address;
  final int? stateId;
  final dynamic countryId;
  final dynamic primaryMobile;
  final dynamic secondaryMobile;
  final dynamic email;
  final int? gstRegistrationTypeId;
  final int? enableJobwork;
  final String? subscriptionStart;
  final String? subscriptionEnd;
  final int? enableTrailAccount;

  CompanyDTO({
    this.id,
    this.name,
    this.address,
    this.stateId,
    this.countryId,
    this.primaryMobile,
    this.secondaryMobile,
    this.email,
    this.gstRegistrationTypeId,
    this.enableJobwork,
    this.subscriptionStart,
    this.subscriptionEnd,
    this.enableTrailAccount,
  });

  CompanyDTO.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'] as String?,
        address = json['address'] as String?,
        stateId = json['stateId'] as int?,
        countryId = json['countryId'],
        primaryMobile = json['primaryMobile'],
        secondaryMobile = json['secondaryMobile'],
        email = json['email'],
        gstRegistrationTypeId = json['gstRegistrationTypeId'] as int?,
        enableJobwork = json['enableJobwork'] as int?,
        subscriptionStart = json['subscriptionStart'] as String?,
        subscriptionEnd = json['subscriptionEnd'] as String?,
        enableTrailAccount = json['enableTrailAccount'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'stateId': stateId,
        'countryId': countryId,
        'primaryMobile': primaryMobile,
        'secondaryMobile': secondaryMobile,
        'email': email,
        'gstRegistrationTypeId': gstRegistrationTypeId,
        'enableJobwork': enableJobwork,
        'subscriptionStart': subscriptionStart,
        'subscriptionEnd': subscriptionEnd,
        'enableTrailAccount': enableTrailAccount
      };
}
