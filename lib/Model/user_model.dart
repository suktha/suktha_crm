class UserModel {
  int? id;
  final String? username;
  final String? email;
  final String? password;
  final String? name;
  final String? lastName;
  final int? active;
  final List<dynamic>? roleIds;
  final dynamic currentAddress;
  final dynamic permanentAddress;
  final dynamic prefixId;
  final dynamic countryId;
  final dynamic stateId;
  final dynamic cityId;
  final dynamic areaId;
  final dynamic genderId;
  final dynamic pinCode;
  final dynamic employeeNumber;
  final dynamic telephoneNumber;
  final dynamic mobileNumber;
  final dynamic dateOfBirth;
  final dynamic dateOfJoin;
  final dynamic dateOfLeaving;
  final dynamic comments;
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
  final String? userThemeName;
  final String? userLanguage;
  final int? reportingTo;

  UserModel({
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
    this.reportingTo,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        username = json['username'] as String?,
        email = json['email'] as String?,
        password = json['password'] as String?,
        name = json['name'] as String?,
        lastName = json['lastName'] as String?,
        active = json['active'] as int?,
        roleIds = (json['roleIds'] as List?)?.map((dynamic e) => e as int).toList(),
        currentAddress = json['currentAddress'],
        permanentAddress = json['permanentAddress'],
        prefixId = json['prefixId'],
        countryId = json['countryId'],
        stateId = json['stateId'],
        cityId = json['cityId'],
        areaId = json['areaId'],
        genderId = json['genderId'],
        pinCode = json['pinCode'],
        employeeNumber = json['employeeNumber'],
        telephoneNumber = json['telephoneNumber'],
        mobileNumber = json['mobileNumber'],
        dateOfBirth = json['dateOfBirth'],
        dateOfJoin = json['dateOfJoin'],
        dateOfLeaving = json['dateOfLeaving'],
        comments = json['comments'],
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
        userThemeName = json['userThemeName'] as String?,
        userLanguage = json['userLanguage'] as String?,
        reportingTo = json['reportingTo'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'password': password,
        'name': name,
        'lastName': lastName,
        'active': active,
        'roleIds': roleIds,
        'currentAddress': currentAddress,
        'permanentAddress': permanentAddress,
        'prefixId': prefixId,
        'countryId': countryId,
        'stateId': stateId,
        'cityId': cityId,
        'areaId': areaId,
        'genderId': genderId,
        'pinCode': pinCode,
        'employeeNumber': employeeNumber,
        'telephoneNumber': telephoneNumber,
        'mobileNumber': mobileNumber,
        'dateOfBirth': dateOfBirth,
        'dateOfJoin': dateOfJoin,
        'dateOfLeaving': dateOfLeaving,
        'comments': comments,
        'employeeStatusId': employeeStatusId,
        'panNumber': panNumber,
        'displayName': displayName,
        'companyId': companyId,
        'employeeTypeId': employeeTypeId,
        'employeeId': employeeId,
        'securityQuestionId': securityQuestionId,
        'securityAnswer': securityAnswer,
        'isLogInRequired': isLogInRequired,
        'deleted': deleted,
        'userThemeName': userThemeName,
        'userLanguage': userLanguage,
        'reportingTo': reportingTo
      };
}
