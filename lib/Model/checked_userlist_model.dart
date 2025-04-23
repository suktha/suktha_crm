

class CheckedUsersListModel {
  final int? id;
  final String? username;
  final String? email;
  final String? password;
  final String? name;
  final String? lastName;
  final int? active;
  final List<int>? roleIds;
  final String? currentAddress;
  final String? permanentAddress;
  final int? prefixId;
  final dynamic countryId;
  final int? stateId;
  final int? cityId;
  final dynamic areaId;
  final int? genderId;
  final String? pinCode;
  final String? employeeNumber;
  final String? telephoneNumber;
  final String? mobileNumber;
  final String? dateOfBirth;
  final String? dateOfJoin;
  final String? dateOfLeaving;
  final String? comments;
  final dynamic employeeStatusId;
  final dynamic panNumber;
  final dynamic displayName;
  final int? companyId;
  final int? employeeTypeId;
  final dynamic employeeId;
  final dynamic securityQuestionId;
  final dynamic securityAnswer;
  final int? isLogInRequired;
  final String? deleted;
  final dynamic userThemeName;
  final dynamic userLanguage;

  CheckedUsersListModel({
    this.id,
    this.username,
    this.email,
    this.password,
    this.name,
    this.lastName,
    this.active,
    this.roleIds,
    this.currentAddress,
    this.permanentAddress,
    this.prefixId,
    this.countryId,
    this.stateId,
    this.cityId,
    this.areaId,
    this.genderId,
    this.pinCode,
    this.employeeNumber,
    this.telephoneNumber,
    this.mobileNumber,
    this.dateOfBirth,
    this.dateOfJoin,
    this.dateOfLeaving,
    this.comments,
    this.employeeStatusId,
    this.panNumber,
    this.displayName,
    this.companyId,
    this.employeeTypeId,
    this.employeeId,
    this.securityQuestionId,
    this.securityAnswer,
    this.isLogInRequired,
    this.deleted,
    this.userThemeName,
    this.userLanguage,
  });

  CheckedUsersListModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      username = json['username'] as String?,
      email = json['email'] as String?,
      password = json['password'] as String?,
      name = json['name'] as String?,
      lastName = json['lastName'] as String?,
      active = json['active'] as int?,
      roleIds = (json['roleIds'] as List?)?.map((dynamic e) => e as int).toList(),
      currentAddress = json['currentAddress'] as String?,
      permanentAddress = json['permanentAddress'] as String?,
      prefixId = json['prefixId'] as int?,
      countryId = json['countryId'],
      stateId = json['stateId'] as int?,
      cityId = json['cityId'] as int?,
      areaId = json['areaId'],
      genderId = json['genderId'] as int?,
      pinCode = json['pinCode'] as String?,
      employeeNumber = json['employeeNumber'] as String?,
      telephoneNumber = json['telephoneNumber'] as String?,
      mobileNumber = json['mobileNumber'] as String?,
      dateOfBirth = json['dateOfBirth'] as String?,
      dateOfJoin = json['dateOfJoin'] as String?,
      dateOfLeaving = json['dateOfLeaving'] as String?,
      comments = json['comments'] as String?,
      employeeStatusId = json['employeeStatusId'],
      panNumber = json['panNumber'],
      displayName = json['displayName'],
      companyId = json['companyId'] as int?,
      employeeTypeId = json['employeeTypeId'] as int?,
      employeeId = json['employeeId'],
      securityQuestionId = json['securityQuestionId'],
      securityAnswer = json['securityAnswer'],
      isLogInRequired = json['isLogInRequired'] as int?,
      deleted = json['deleted'] as String?,
      userThemeName = json['userThemeName'],
      userLanguage = json['userLanguage'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'username' : username,
    'email' : email,
    'password' : password,
    'name' : name,
    'lastName' : lastName,
    'active' : active,
    'roleIds' : roleIds,
    'currentAddress' : currentAddress,
    'permanentAddress' : permanentAddress,
    'prefixId' : prefixId,
    'countryId' : countryId,
    'stateId' : stateId,
    'cityId' : cityId,
    'areaId' : areaId,
    'genderId' : genderId,
    'pinCode' : pinCode,
    'employeeNumber' : employeeNumber,
    'telephoneNumber' : telephoneNumber,
    'mobileNumber' : mobileNumber,
    'dateOfBirth' : dateOfBirth,
    'dateOfJoin' : dateOfJoin,
    'dateOfLeaving' : dateOfLeaving,
    'comments' : comments,
    'employeeStatusId' : employeeStatusId,
    'panNumber' : panNumber,
    'displayName' : displayName,
    'companyId' : companyId,
    'employeeTypeId' : employeeTypeId,
    'employeeId' : employeeId,
    'securityQuestionId' : securityQuestionId,
    'securityAnswer' : securityAnswer,
    'isLogInRequired' : isLogInRequired,
    'deleted' : deleted,
    'userThemeName' : userThemeName,
    'userLanguage' : userLanguage
  };
}