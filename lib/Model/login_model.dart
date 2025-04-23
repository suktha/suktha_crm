class LoginModel {
  String? token;
  User? user;

  LoginModel({
    this.token,
    this.user,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'] as String?;
    user = (json['user'] as Map<String, dynamic>?) != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['token'] = token;
    json['user'] = user?.toJson();
    return json;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['token'] = token;
    map['user'] = user?.toJson();
    // Add all other fields
    return map;
  }
}

class User {
  int? id;
  dynamic createdDateTime;
  dynamic createdBy;
  String? updatedDateTime;
  String? updatedBy;
  String? username;
  String? email;
  String? password;
  String? name;
  String? lastName;
  int? active;
  List<Roles>? roles;
  String? currentAddress;
  String? permanentAddress;
  NamePrefix? namePrefix;
  dynamic country;
  State? state;
  City? city;
  dynamic area;
  Gender? gender;
  String? pinCode;
  String? employeeNumber;
  String? telephoneNumber;
  String? mobileNumber;
  String? dateOfBirth;
  String? dateOfJoin;
  String? dateOfLeaving;
  String? comments;
  dynamic panNumber;
  dynamic displayName;
  Company? company;
  EmployeeType? employeeType;
  dynamic employeeId;
  dynamic securityQuestion;
  dynamic securityAnswer;
  int? isLogInRequired;
  String? deleted;
  dynamic userThemeName;
  dynamic userLanguage;

  User({
    this.id,
    this.createdDateTime,
    this.createdBy,
    this.updatedDateTime,
    this.updatedBy,
    this.username,
    this.email,
    this.password,
    this.name,
    this.lastName,
    this.active,
    this.roles,
    this.currentAddress,
    this.permanentAddress,
    this.namePrefix,
    this.country,
    this.state,
    this.city,
    this.area,
    this.gender,
    this.pinCode,
    this.employeeNumber,
    this.telephoneNumber,
    this.mobileNumber,
    this.dateOfBirth,
    this.dateOfJoin,
    this.dateOfLeaving,
    this.comments,
    this.panNumber,
    this.displayName,
    this.company,
    this.employeeType,
    this.employeeId,
    this.securityQuestion,
    this.securityAnswer,
    this.isLogInRequired,
    this.deleted,
    this.userThemeName,
    this.userLanguage,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    createdDateTime = json['createdDateTime'];
    createdBy = json['createdBy'];
    updatedDateTime = json['updatedDateTime'] as String?;
    updatedBy = json['updatedBy'] as String?;
    username = json['username'] as String?;
    email = json['email'] as String?;
    password = json['password'] as String?;
    name = json['name'] as String?;
    lastName = json['lastName'] as String?;
    active = json['active'] as int?;
    roles = (json['roles'] as List?)?.map((dynamic e) => Roles.fromJson(e as Map<String, dynamic>)).toList();
    currentAddress = json['currentAddress'] as String?;
    permanentAddress = json['permanentAddress'] as String?;
    namePrefix = (json['namePrefix'] as Map<String, dynamic>?) != null ? NamePrefix.fromJson(json['namePrefix'] as Map<String, dynamic>) : null;
    country = json['country'];
    state = (json['state'] as Map<String, dynamic>?) != null ? State.fromJson(json['state'] as Map<String, dynamic>) : null;
    city = (json['city'] as Map<String, dynamic>?) != null ? City.fromJson(json['city'] as Map<String, dynamic>) : null;
    area = json['area'];
    gender = (json['gender'] as Map<String, dynamic>?) != null ? Gender.fromJson(json['gender'] as Map<String, dynamic>) : null;
    pinCode = json['pinCode'] as String?;
    employeeNumber = json['employeeNumber'] as String?;
    telephoneNumber = json['telephoneNumber'] as String?;
    mobileNumber = json['mobileNumber'] as String?;
    dateOfBirth = json['dateOfBirth'] as String?;
    dateOfJoin = json['dateOfJoin'] as String?;
    dateOfLeaving = json['dateOfLeaving'] as String?;
    comments = json['comments'] as String?;
    panNumber = json['panNumber'];
    displayName = json['displayName'];
    company = (json['company'] as Map<String, dynamic>?) != null ? Company.fromJson(json['company'] as Map<String, dynamic>) : null;
    employeeType = (json['employeeType'] as Map<String, dynamic>?) != null ? EmployeeType.fromJson(json['employeeType'] as Map<String, dynamic>) : null;
    employeeId = json['employeeId'];
    securityQuestion = json['securityQuestion'];
    securityAnswer = json['securityAnswer'];
    isLogInRequired = json['isLogInRequired'] as int?;
    deleted = json['deleted'] as String?;
    userThemeName = json['userThemeName'];
    userLanguage = json['userLanguage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['createdDateTime'] = createdDateTime;
    json['createdBy'] = createdBy;
    json['updatedDateTime'] = updatedDateTime;
    json['updatedBy'] = updatedBy;
    json['username'] = username;
    json['email'] = email;
    json['password'] = password;
    json['name'] = name;
    json['lastName'] = lastName;
    json['active'] = active;
    json['roles'] = roles?.map((e) => e.toJson()).toList();
    json['currentAddress'] = currentAddress;
    json['permanentAddress'] = permanentAddress;
    json['namePrefix'] = namePrefix?.toJson();
    json['country'] = country;
    json['state'] = state?.toJson();
    json['city'] = city?.toJson();
    json['area'] = area;
    json['gender'] = gender?.toJson();
    json['pinCode'] = pinCode;
    json['employeeNumber'] = employeeNumber;
    json['telephoneNumber'] = telephoneNumber;
    json['mobileNumber'] = mobileNumber;
    json['dateOfBirth'] = dateOfBirth;
    json['dateOfJoin'] = dateOfJoin;
    json['dateOfLeaving'] = dateOfLeaving;
    json['comments'] = comments;
    json['panNumber'] = panNumber;
    json['displayName'] = displayName;
    json['company'] = company?.toJson();
    json['employeeType'] = employeeType?.toJson();
    json['employeeId'] = employeeId;
    json['securityQuestion'] = securityQuestion;
    json['securityAnswer'] = securityAnswer;
    json['isLogInRequired'] = isLogInRequired;
    json['deleted'] = deleted;
    json['userThemeName'] = userThemeName;
    json['userLanguage'] = userLanguage;
    return json;
  }
}

class Roles {
  int? id;
  dynamic createdDateTime;
  dynamic createdBy;
  dynamic updatedDateTime;
  dynamic updatedBy;
  String? role;
  RoleType? roleType;

  Roles({
    this.id,
    this.createdDateTime,
    this.createdBy,
    this.updatedDateTime,
    this.updatedBy,
    this.role,
    this.roleType,
  });

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    createdDateTime = json['createdDateTime'];
    createdBy = json['createdBy'];
    updatedDateTime = json['updatedDateTime'];
    updatedBy = json['updatedBy'];
    role = json['role'] as String?;
    roleType = (json['roleType'] as Map<String, dynamic>?) != null ? RoleType.fromJson(json['roleType'] as Map<String, dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['createdDateTime'] = createdDateTime;
    json['createdBy'] = createdBy;
    json['updatedDateTime'] = updatedDateTime;
    json['updatedBy'] = updatedBy;
    json['role'] = role;
    json['roleType'] = roleType?.toJson();
    return json;
  }
}

class RoleType {
  int? id;
  dynamic createdDateTime;
  dynamic createdBy;
  dynamic updatedDateTime;
  dynamic updatedBy;
  String? name;
  String? deleted;

  RoleType({
    this.id,
    this.createdDateTime,
    this.createdBy,
    this.updatedDateTime,
    this.updatedBy,
    this.name,
    this.deleted,
  });

  RoleType.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    createdDateTime = json['createdDateTime'];
    createdBy = json['createdBy'];
    updatedDateTime = json['updatedDateTime'];
    updatedBy = json['updatedBy'];
    name = json['name'] as String?;
    deleted = json['deleted'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['createdDateTime'] = createdDateTime;
    json['createdBy'] = createdBy;
    json['updatedDateTime'] = updatedDateTime;
    json['updatedBy'] = updatedBy;
    json['name'] = name;
    json['deleted'] = deleted;
    return json;
  }
}

class NamePrefix {
  int? id;
  dynamic createdDateTime;
  dynamic createdBy;
  dynamic updatedDateTime;
  dynamic updatedBy;
  String? name;
  String? deleted;

  NamePrefix({
    this.id,
    this.createdDateTime,
    this.createdBy,
    this.updatedDateTime,
    this.updatedBy,
    this.name,
    this.deleted,
  });

  NamePrefix.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    createdDateTime = json['createdDateTime'];
    createdBy = json['createdBy'];
    updatedDateTime = json['updatedDateTime'];
    updatedBy = json['updatedBy'];
    name = json['name'] as String?;
    deleted = json['deleted'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['createdDateTime'] = createdDateTime;
    json['createdBy'] = createdBy;
    json['updatedDateTime'] = updatedDateTime;
    json['updatedBy'] = updatedBy;
    json['name'] = name;
    json['deleted'] = deleted;
    return json;
  }
}

class State {
  int? id;
  dynamic createdDateTime;
  dynamic createdBy;
  dynamic updatedDateTime;
  dynamic updatedBy;
  String? name;
  String? stateCode;
  Country? country;
  int? typeStateId;
  String? deleted;

  State({
    this.id,
    this.createdDateTime,
    this.createdBy,
    this.updatedDateTime,
    this.updatedBy,
    this.name,
    this.stateCode,
    this.country,
    this.typeStateId,
    this.deleted,
  });

  State.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    createdDateTime = json['createdDateTime'];
    createdBy = json['createdBy'];
    updatedDateTime = json['updatedDateTime'];
    updatedBy = json['updatedBy'];
    name = json['name'] as String?;
    stateCode = json['stateCode'] as String?;
    country = (json['country'] as Map<String, dynamic>?) != null ? Country.fromJson(json['country'] as Map<String, dynamic>) : null;
    typeStateId = json['typeStateId'] as int?;
    deleted = json['deleted'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['createdDateTime'] = createdDateTime;
    json['createdBy'] = createdBy;
    json['updatedDateTime'] = updatedDateTime;
    json['updatedBy'] = updatedBy;
    json['name'] = name;
    json['stateCode'] = stateCode;
    json['country'] = country?.toJson();
    json['typeStateId'] = typeStateId;
    json['deleted'] = deleted;
    return json;
  }
}

class Country {
  int? id;
  dynamic createdDateTime;
  dynamic createdBy;
  dynamic updatedDateTime;
  dynamic updatedBy;
  String? name;
  String? deleted;

  Country({
    this.id,
    this.createdDateTime,
    this.createdBy,
    this.updatedDateTime,
    this.updatedBy,
    this.name,
    this.deleted,
  });

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    createdDateTime = json['createdDateTime'];
    createdBy = json['createdBy'];
    updatedDateTime = json['updatedDateTime'];
    updatedBy = json['updatedBy'];
    name = json['name'] as String?;
    deleted = json['deleted'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['createdDateTime'] = createdDateTime;
    json['createdBy'] = createdBy;
    json['updatedDateTime'] = updatedDateTime;
    json['updatedBy'] = updatedBy;
    json['name'] = name;
    json['deleted'] = deleted;
    return json;
  }
}

class City {
  int? id;
  dynamic createdDateTime;
  dynamic createdBy;
  dynamic updatedDateTime;
  dynamic updatedBy;
  String? name;
  State? state;
  String? deleted;

  City({
    this.id,
    this.createdDateTime,
    this.createdBy,
    this.updatedDateTime,
    this.updatedBy,
    this.name,
    this.state,
    this.deleted,
  });

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    createdDateTime = json['createdDateTime'];
    createdBy = json['createdBy'];
    updatedDateTime = json['updatedDateTime'];
    updatedBy = json['updatedBy'];
    name = json['name'] as String?;
    state = (json['state'] as Map<String, dynamic>?) != null ? State.fromJson(json['state'] as Map<String, dynamic>) : null;
    deleted = json['deleted'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['createdDateTime'] = createdDateTime;
    json['createdBy'] = createdBy;
    json['updatedDateTime'] = updatedDateTime;
    json['updatedBy'] = updatedBy;
    json['name'] = name;
    json['state'] = state?.toJson();
    json['deleted'] = deleted;
    return json;
  }
}

class Gender {
  int? id;
  dynamic createdDateTime;
  dynamic createdBy;
  dynamic updatedDateTime;
  dynamic updatedBy;
  String? name;
  String? deleted;

  Gender({
    this.id,
    this.createdDateTime,
    this.createdBy,
    this.updatedDateTime,
    this.updatedBy,
    this.name,
    this.deleted,
  });

  Gender.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    createdDateTime = json['createdDateTime'];
    createdBy = json['createdBy'];
    updatedDateTime = json['updatedDateTime'];
    updatedBy = json['updatedBy'];
    name = json['name'] as String?;
    deleted = json['deleted'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['createdDateTime'] = createdDateTime;
    json['createdBy'] = createdBy;
    json['updatedDateTime'] = updatedDateTime;
    json['updatedBy'] = updatedBy;
    json['name'] = name;
    json['deleted'] = deleted;
    return json;
  }
}

class Company {
  int? id;
  dynamic createdDateTime;
  dynamic createdBy;
  String? updatedDateTime;
  String? updatedBy;
  String? name;
  String? address;
  City? city;
  State? state;
  Country? country;
  GstRegistrationType? gstRegistrationType;
  String? gstNumber;
  String? deleted;
  String? pinCode;
  String? primaryTelephone;
  String? secondaryTelephone;
  dynamic tinNumber;
  dynamic tinDate;
  String? faxNumber;
  String? contactPersonName;
  String? primaryMobile;
  String? secondaryMobile;
  String? email;
  String? website;
  String? contactPersonNumber;
  dynamic status;
  String? panNumber;
  dynamic panDate;
  String? companyLogoPath;
  List<dynamic>? addresses;
  String? tagLine;
  dynamic ceritificateImagePath;
  String? signatureImagePath;
  dynamic qRCodeImagePath;
  String? msmeNumber;
  String? cinNumber;
  String? subject;
  String? iecCode;
  int? companyCurrencyId;
  String? companyAddress1;
  String? companyAddress2;
  String? subscriptionId;
  String? paymentId;
  String? subscriptionEnd;
  String? subscriptionStart;
  int? enableTrailAccount;

  Company({
    this.id,
    this.createdDateTime,
    this.createdBy,
    this.updatedDateTime,
    this.updatedBy,
    this.name,
    this.address,
    this.city,
    this.state,
    this.country,
    this.gstRegistrationType,
    this.gstNumber,
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
    this.status,
    this.panNumber,
    this.panDate,
    this.companyLogoPath,
    this.addresses,
    this.tagLine,
    this.ceritificateImagePath,
    this.signatureImagePath,
    this.qRCodeImagePath,
    this.msmeNumber,
    this.cinNumber,
    this.subject,
    this.iecCode,
    this.companyCurrencyId,
    this.companyAddress1,
    this.companyAddress2,
    this.subscriptionId,
    this.paymentId,
    this.subscriptionEnd,
    this.subscriptionStart,
    this.enableTrailAccount,
  });

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    createdDateTime = json['createdDateTime'];
    createdBy = json['createdBy'];
    updatedDateTime = json['updatedDateTime'] as String?;
    updatedBy = json['updatedBy'] as String?;
    name = json['name'] as String?;
    address = json['address'] as String?;
    city = (json['city'] as Map<String, dynamic>?) != null ? City.fromJson(json['city'] as Map<String, dynamic>) : null;
    state = (json['state'] as Map<String, dynamic>?) != null ? State.fromJson(json['state'] as Map<String, dynamic>) : null;
    country = (json['country'] as Map<String, dynamic>?) != null ? Country.fromJson(json['country'] as Map<String, dynamic>) : null;
    gstRegistrationType = (json['gstRegistrationType'] as Map<String, dynamic>?) != null ? GstRegistrationType.fromJson(json['gstRegistrationType'] as Map<String, dynamic>) : null;
    gstNumber = json['gstNumber'] as String?;
    deleted = json['deleted'] as String?;
    pinCode = json['pinCode'] as String?;
    primaryTelephone = json['primaryTelephone'] as String?;
    secondaryTelephone = json['secondaryTelephone'] as String?;
    tinNumber = json['tinNumber'];
    tinDate = json['tinDate'];
    faxNumber = json['faxNumber'] as String?;
    contactPersonName = json['contactPersonName'] as String?;
    primaryMobile = json['primaryMobile'] as String?;
    secondaryMobile = json['secondaryMobile'] as String?;
    email = json['email'] as String?;
    website = json['website'] as String?;
    contactPersonNumber = json['contactPersonNumber'] as String?;
    status = json['status'];
    panNumber = json['panNumber'] as String?;
    panDate = json['panDate'];
    companyLogoPath = json['companyLogoPath'] as String?;
    addresses = json['addresses'] as List?;
    tagLine = json['tagLine'] as String?;
    ceritificateImagePath = json['ceritificateImagePath'];
    signatureImagePath = json['signatureImagePath'] as String?;
    qRCodeImagePath = json['qRCodeImagePath'];
    msmeNumber = json['msmeNumber'] as String?;
    cinNumber = json['cinNumber'] as String?;
    subject = json['subject'] as String?;
    iecCode = json['iecCode'] as String?;
    companyCurrencyId = json['companyCurrencyId'] as int?;
    companyAddress1 = json['companyAddress1'] as String?;

    companyAddress2 = json['companyAddress2'] as String?;
    subscriptionId = json['subscriptionId'] as String?;
    paymentId = json['paymentId'] as String?;
    subscriptionEnd = json['subscriptionEnd'] as String?;
    subscriptionStart = json['subscriptionStart'] as String?;
    enableTrailAccount = json['enableTrailAccount'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['createdDateTime'] = createdDateTime;
    json['createdBy'] = createdBy;
    json['updatedDateTime'] = updatedDateTime;
    json['updatedBy'] = updatedBy;
    json['name'] = name;
    json['address'] = address;
    json['city'] = city?.toJson();
    json['state'] = state?.toJson();
    json['country'] = country?.toJson();
    json['gstRegistrationType'] = gstRegistrationType?.toJson();
    json['gstNumber'] = gstNumber;
    json['deleted'] = deleted;
    json['pinCode'] = pinCode;
    json['primaryTelephone'] = primaryTelephone;
    json['secondaryTelephone'] = secondaryTelephone;
    json['tinNumber'] = tinNumber;
    json['tinDate'] = tinDate;
    json['faxNumber'] = faxNumber;
    json['contactPersonName'] = contactPersonName;
    json['primaryMobile'] = primaryMobile;
    json['secondaryMobile'] = secondaryMobile;
    json['email'] = email;
    json['website'] = website;
    json['contactPersonNumber'] = contactPersonNumber;
    json['status'] = status;
    json['panNumber'] = panNumber;
    json['panDate'] = panDate;
    json['companyLogoPath'] = companyLogoPath;
    json['addresses'] = addresses;
    json['tagLine'] = tagLine;
    json['ceritificateImagePath'] = ceritificateImagePath;
    json['signatureImagePath'] = signatureImagePath;
    json['qRCodeImagePath'] = qRCodeImagePath;
    json['msmeNumber'] = msmeNumber;
    json['cinNumber'] = cinNumber;
    json['subject'] = subject;
    json['iecCode'] = iecCode;
    json['companyCurrencyId'] = companyCurrencyId;
    json['companyAddress1'] = companyAddress1;
    json['companyAddress2'] = companyAddress2;
    json['subscriptionId'] = subscriptionId;
    json['paymentId'] = paymentId;
    json['subscriptionEnd'] = subscriptionEnd;
    json['subscriptionStart'] = subscriptionStart;
    json['enableTrailAccount'] = enableTrailAccount;
    return json;
  }
}

class GstRegistrationType {
  int? id;
  dynamic createdDateTime;
  dynamic createdBy;
  dynamic updatedDateTime;
  dynamic updatedBy;
  String? name;
  String? deleted;

  GstRegistrationType({
    this.id,
    this.createdDateTime,
    this.createdBy,
    this.updatedDateTime,
    this.updatedBy,
    this.name,
    this.deleted,
  });

  GstRegistrationType.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    createdDateTime = json['createdDateTime'];
    createdBy = json['createdBy'];
    updatedDateTime = json['updatedDateTime'];
    updatedBy = json['updatedBy'];
    name = json['name'] as String?;
    deleted = json['deleted'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['createdDateTime'] = createdDateTime;
    json['createdBy'] = createdBy;
    json['updatedDateTime'] = updatedDateTime;
    json['updatedBy'] = updatedBy;
    json['name'] = name;
    json['deleted'] = deleted;
    return json;
  }
}

class EmployeeType {
  int? id;
  dynamic createdDateTime;
  dynamic createdBy;
  dynamic updatedDateTime;
  dynamic updatedBy;
  String? name;
  String? deleted;

  EmployeeType({
    this.id,
    this.createdDateTime,
    this.createdBy,
    this.updatedDateTime,
    this.updatedBy,
    this.name,
    this.deleted,
  });

  EmployeeType.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    createdDateTime = json['createdDateTime'];
    createdBy = json['createdBy'];
    updatedDateTime = json['updatedDateTime'];
    updatedBy = json['updatedBy'];
    name = json['name'] as String?;
    deleted = json['deleted'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['createdDateTime'] = createdDateTime;
    json['createdBy'] = createdBy;
    json['updatedDateTime'] = updatedDateTime;
    json['updatedBy'] = updatedBy;
    json['name'] = name;
    json['deleted'] = deleted;
    return json;
  }
}
