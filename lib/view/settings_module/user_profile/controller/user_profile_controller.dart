import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:work_Force/Model/area_model.dart';
import 'package:work_Force/Model/country_master_model.dart';
import 'package:work_Force/Model/get_all_branches_model.dart';
import 'package:work_Force/Model/login_model.dart';
import 'package:work_Force/Model/state_model.dart';
import 'package:work_Force/Model/user_dropdown_model.dart';
import 'package:work_Force/Model/user_role_model.dart';
import 'package:work_Force/utils/Services/rest_api_services.dart';
import 'package:work_Force/utils/Services/sharedpref_services.dart';
import 'package:work_Force/view/widget/snackbar.dart';
import '../../../../Model/city_model.dart';
import '../../../../Model/user_model.dart';

class UserProfileController extends GetxController {
  RxList<UserModel> UserProfileList = <UserModel>[].obs;

  RxList<UserRoleModel> userRoleList = <UserRoleModel>[].obs;
  RxList<UserRoleModel> selectedUserRoleList = <UserRoleModel>[].obs;

  RxString userRoleId = "".obs;
  RxString getBranchId = "".obs;
  RxString BranchAdminId = "".obs;

  RxList<DropdownUserModel> prefixList = <DropdownUserModel>[].obs;
  RxList<DropdownUserModel> genderList = <DropdownUserModel>[].obs;
  RxList<DropdownUserModel> employeeTypeList = <DropdownUserModel>[].obs;

  RxList<UserModel> savedValueList = <UserModel>[].obs;

  RxList<String> stateName = <String>[].obs;
  RxList<String> CountryName = <String>[].obs;

  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController currentAddressController = TextEditingController();
  TextEditingController mobileNumController = TextEditingController();
  TextEditingController dateOfLeavingController = TextEditingController();
  TextEditingController telePhoneNumController = TextEditingController();
  TextEditingController DOBController = TextEditingController();
  TextEditingController employeeCodeController = TextEditingController();
  TextEditingController permaentAddressController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  TextEditingController dateOfJoiningController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController employeeTypeController = TextEditingController();
  TextEditingController userRoleController = TextEditingController();
  TextEditingController reportingBranchController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  RxString prefixName = "".obs;
  RxString prefixId = "".obs;
  RxString validationMessage = "".obs;

  RxString genderName = "".obs;
  RxString genderId = "".obs;
  RxString validationMessageGender = "".obs;

  RxString employeeTypeName = "".obs;
  RxString employeeTypeId = "".obs;
  RxString validationMessageemployeeType = "".obs;

  RxBool StateIdisSelected = true.obs;
  StateModel? StateValue;
  RxString stateId = "".obs;

  RxBool areaIdisSelected = true.obs;
  RxBool isStaffSelected = false.obs;

  AreaModel? areaValue;
  RxString areaId = "".obs;

  RxBool countryIdisSelected = true.obs;
  CountryMasterModel? countryValue;
  RxString countryId = "".obs;

  RxBool cityIdisSelected = true.obs;
  CityModel? cityValue;
  RxString cityId = "".obs;

  RxBool employeeTypeIdisSelected = true.obs;
  DropdownUserModel? employeeTypeValue;

  RxBool isClicked = false.obs;
  RxBool isClicked2 = false.obs;

  getprefixList() {
    var itemList = [
      DropdownUserModel(id: 1, name: "Mr"),
      DropdownUserModel(id: 2, name: "Mrs"),
      DropdownUserModel(id: 3, name: "Ms"),
      DropdownUserModel(id: 4, name: "Dr"),
    ];

    prefixList.addAll(itemList);
    prefixList.refresh();
    print("prefixList------------${prefixList}");
  }

  getGenderList() {
    var itemList = [
      DropdownUserModel(id: 1, name: "Male"),
      DropdownUserModel(id: 2, name: "Female"),
    ];

    genderList.addAll(itemList);
    genderList.refresh();
    print("genderList------------${genderList}");
  }

  getEmployeeTypeList() {
    var itemList = [
      DropdownUserModel(id: 1, name: "Permanent"),
      DropdownUserModel(id: 2, name: "Temporary"),
      DropdownUserModel(id: 3, name: "Part Time"),
    ];

    employeeTypeList.addAll(itemList);
    employeeTypeList.refresh();
    print("employeeTypeList------------${employeeTypeList}");
  }

  RxList names = [].obs;
  RxList ids = [].obs;
  RxString userRoleName = "".obs;

  String getUserRoleNames(List<dynamic> userRoleIds) {
    if (userRoleIds == "" || userRoleIds == "0") {
      return "";
    }

    return userRoleList
        .where((model) => userRoleIds.contains(model.id))
        .map((e) => e.role)
        .join(', ');
  }

  String datePareser(String date) {
    String isoDate = date;

    print("incoming date" + date);

    // Parse the date
    DateTime parsedDate = DateTime.parse(isoDate);

    // Format the date
    String formattedDate = DateFormat("d'th' MMM y").format(parsedDate);

    // Handling the day suffix (st, nd, rd, th)
    formattedDate =
        formattedDate.replaceAll('th', getDaySuffix(parsedDate.day));

    print(formattedDate); // Output: 15th May 2013

    return formattedDate;
  }

  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  void onInit() {
    getUserRoleList("");
    getprefixList();
    getGenderList();
    getEmployeeTypeList();
    super.onInit();
  }

  Future<List<UserRoleModel>> getUserRoleList(String query) async {
    List<dynamic> responseValue = await apiCallService(
        "/user-roles",
        'GET',
        {},
        TheResponseType.list,
        {},
        false); //--url, Method, body, responsetype, query parameter, isAuth
    List<UserRoleModel> userDatas =
        (responseValue).map((e) => UserRoleModel.fromJson(e)).toList();

    userRoleList.value = userDatas;
    userRoleList.refresh();

    return userRoleList;
  }

  RxList<GetAllBranchesModel> getAllBranchList = <GetAllBranchesModel>[].obs;

  Future<List<GetAllBranchesModel>> getBranchList() async {
    List<dynamic> responseValue = await apiCallService(
        "/getAllBranches",
        'GET',
        {},
        TheResponseType.list,
        {},
        false); //--url, Method, body, responsetype, query parameter, isAuth
    List<GetAllBranchesModel> userDatas =
        (responseValue).map((e) => GetAllBranchesModel.fromJson(e)).toList();

    getAllBranchList.value = userDatas;
    getAllBranchList.refresh();

    return getAllBranchList;
  }

  Future<List<UserModel>> getCreatedByNames(
      String search, String employeNo) async {
    try {
      Map<String, dynamic> result = await apiCallService(
          "/user/recent/name/desc/1/30?searchText=$search",
          "GET",
          {},
          TheResponseType.map,
          {},
          false);
      List<dynamic> headers = result["users"];
      List<UserModel> values =
          headers.map((e) => UserModel.fromJson(e)).toList();

      UserProfileList.value = values;
      print(UserProfileList[0].name);
      print(UserProfileList.length);
      UserProfileList.refresh();
      print("createdby------- ----${UserProfileList}");

      // customSnackbar("Success", "User profile Saved Successfully", "success");
    } catch (e) {
      print("ERROR LIST---$e");
      customSnackbar("Error", "Something went wrong $e", "error");
    }
    return UserProfileList;
  }

  deleteUserList(var id) async {
    Map<String, dynamic> response = await apiCallService(
        "/user/$id", "DELETE", {}, TheResponseType.map, {}, false);
    print("DELETE response -- $response");

    customSnackbar("Success", "User profile deleted Successfully", "success");
    Get.back();
    UserProfileList.clear();
    UserProfileList.refresh();
    await getCreatedByNames("", "name");
  }

  checkEmail(var email) async {
    try {
      Map<String, dynamic> response = await apiCallService(
          "/check-email/$email", "GET", {}, TheResponseType.map, {}, false);
      print("response -- $response");
    } catch (e) {
      print("error----$e");
      customSnackbar("Error", "Something went wrong $e", "error");
    }
  }

  checkUserName(var userName) async {
    try {
      Map<String, dynamic> response = await apiCallService(
          "/check-username/$userName",
          "GET",
          {},
          TheResponseType.map,
          {},
          false);
      print("response -- $response");
    } catch (e) {
      print("error----$e");
      customSnackbar("Error", "Something went wrong $e", "error");
    }
  }

  int? tryParseInt(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    return int.tryParse(value);
  }

  disableLogin(UserModel userMap) async {
    var datas = {
      "id": userMap.id,
      "username": userMap.username,
      "email": userMap.email,
      "password": userMap.password,
      "name": userMap.name,
      "lastName": userMap.lastName,
      "active": userMap.active,
      "roleIds": userMap.roleIds,
      "currentAddress": userMap.currentAddress,
      "permanentAddress": userMap.permanentAddress,
      "prefixId": userMap.prefixId,
      "countryId": userMap.countryId,
      "stateId": userMap.stateId,
      "cityId": userMap.cityId,
      "areaId": userMap.areaId,
      "genderId": userMap.genderId,
      "pinCode": userMap.pinCode,
      "employeeNumber": userMap.employeeNumber,
      "telephoneNumber": userMap.telephoneNumber,
      "mobileNumber": userMap.mobileNumber,
      "dateOfBirth": userMap.dateOfBirth,
      "dateOfJoin": userMap.dateOfJoin,
      "dateOfLeaving": userMap.dateOfLeaving,
      "comments": userMap.comments,
      "employeeStatusId": userMap.employeeStatusId,
      "panNumber": userMap.panNumber,
      "displayName": userMap.displayName,
      "companyId": userMap.companyId,
      "employeeTypeId": userMap.employeeTypeId,
      "employeeId": userMap.employeeId,
      "securityQuestionId": userMap.securityQuestionId,
      "securityAnswer": userMap.securityAnswer,
      "isLogInRequired": userMap.isLogInRequired,
      "deleted": userMap.deleted,
      "userThemeName": userMap.userThemeName,
      "userLanguage": userMap.userLanguage
    };
    try {
      bool response = await apiCallService(
          "/disable-login", "POST", datas, TheResponseType.bool, {}, false);

      await getCreatedByNames("", "name");
      Get.back();
      Get.back();
      customSnackbar(
          "Success", "Login disabled for the ${userMap.username}", "success");
    } catch (e) {
      print("error----$e");
    }
  }

  newEmployeeCheck(var id) async {
    int? tryParseInt(String? value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      return int.tryParse(value);
    }

    var prefs = SharedPreferencesService.instance;

    final logindecoded = json.decode(prefs.getValue('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    var datas = {
      "id": id,
      "username":
          userNameController.text.isEmpty ? null : userNameController.text,
      "email": emailController.text.isEmpty ? null : emailController.text,
      "password": null,
      "name": nameController.text.isEmpty ? null : nameController.text,
      "lastName": null,
      "active": 0,
      "roleIds": selectedUserRoleList.map<int>((item) => item.id!).toList(),
      "currentAddress": currentAddressController.text.isEmpty
          ? null
          : currentAddressController.text,
      "permanentAddress": permaentAddressController.text.isEmpty
          ? null
          : permaentAddressController.text,
      "prefixId": tryParseInt(prefixId.value),
      "countryId": tryParseInt(countryId.value),
      "stateId": tryParseInt(stateId.value),
      "cityId": tryParseInt(cityId.value),
      "areaId": tryParseInt(areaId.value),
      "genderId": tryParseInt(genderId.value),
      "pinCode": pincodeController.text.isEmpty ? null : pincodeController.text,
      "employeeNumber": employeeCodeController.text.isEmpty
          ? null
          : employeeCodeController.text,
      "telephoneNumber": telePhoneNumController.text.isEmpty
          ? null
          : telePhoneNumController.text,
      "mobileNumber":
          mobileNumController.text.isEmpty ? null : mobileNumController.text,
      "dateOfBirth": DOBController.text.isEmpty ? null : DOBController.text,
      "dateOfJoin": dateOfJoiningController.text.isEmpty
          ? null
          : dateOfJoiningController.text,
      "dateOfLeaving": dateOfLeavingController.text.isEmpty
          ? null
          : dateOfLeavingController.text,
      "comments":
          commentsController.text.isEmpty ? null : commentsController.text,
      "employeeStatusId": null,
      "panNumber": null,
      "displayName":
          userNameController.text.isEmpty ? null : userNameController.text,
      "companyId": loginDetails.user!.company!.id,
      "employeeTypeId": tryParseInt(employeeTypeId.value),
      "employeeId": null,
      "securityQuestionId": null,
      "securityAnswer": null,
      "isLogInRequired": null,
      "deleted": "N",
      "userThemeName": null,
      "userLanguage": null
    };
    try {
      Map<String, dynamic> response = await apiCallService(
          "/new-employee", "POST", datas, TheResponseType.map, {}, false);

      print("response----$response");
      customSnackbar("Success", "User profile Saved Successfully", "success");
      await passwordChange(id);
    } catch (e) {
      print("error----$e");
    }
  }

  passwordChange(var id) async {
    var values = {
      "email": emailController.text,
      "id": id,
      "username": userNameController.text,
      "password": confirmPasswordController.text,
    };
    try {
      bool response = await apiCallService(
          "/password-change", "POST", values, TheResponseType.bool, {}, false);
      print("response----$response");

      await getCreatedByNames("", "name");
      Get.back();
      Get.back();

      customSnackbar("Success", "User profile Saved Successfully", "success");
    } catch (e) {
      print("error----$e");
    }
  }

  saveUserProfile() async {
    var prefs = SharedPreferencesService.instance;

    final logindecoded = json.decode(prefs.getValue('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    int? tryParseInt(String? value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      return int.tryParse(value);
    }

    var datas = UserModel(
      id: null,
      username: userNameController.text.isEmpty ? "" : userNameController.text,
      displayName: nameController.text.isEmpty ? "" : nameController.text,
      email: emailController.text.isEmpty ? "" : emailController.text,
      password: null,
      name: nameController.text.isEmpty ? "" : nameController.text,
      lastName: null,
      active: null,
      roleIds: selectedUserRoleList.map<int>((item) => item.id!).toList(),
      currentAddress: currentAddressController.text.isEmpty
          ? ""
          : currentAddressController.text,
      permanentAddress: permaentAddressController.text.isEmpty
          ? ""
          : permaentAddressController.text,
      prefixId: tryParseInt(prefixId.value),
      countryId: tryParseInt(countryId.value),
      stateId: tryParseInt(stateId.value),
      cityId: tryParseInt(cityId.value),
      areaId: tryParseInt(areaId.value),
      genderId: tryParseInt(genderId.value),
      pinCode: pincodeController.text.isEmpty ? "" : pincodeController.text,
      employeeNumber: employeeCodeController.text.isEmpty
          ? ""
          : employeeCodeController.text,
      telephoneNumber: telePhoneNumController.text.isEmpty
          ? ""
          : telePhoneNumController.text,
      mobileNumber:
          mobileNumController.text.isEmpty ? "" : mobileNumController.text,
      dateOfBirth: DOBController.text.isEmpty ? "" : DOBController.text,
      dateOfJoin: dateOfJoiningController.text.isEmpty
          ? ""
          : dateOfJoiningController.text,
      dateOfLeaving: dateOfLeavingController.text.isEmpty
          ? ""
          : dateOfLeavingController.text,
      comments: commentsController.text.isEmpty ? "" : commentsController.text,
      employeeTypeId: tryParseInt(employeeTypeId.value),
      deleted: null,
      companyId: loginDetails.user!.company!.id,
      userLanguage: null,
      userThemeName: null,
      reportingTo:getBranchId.value.isEmpty?null: int.tryParse(getBranchId.value),
    );

    print("data-----${datas.toJson().toString()}");
    try {
      Map<String, dynamic> response = await apiCallService(
          "/user", "POST", datas.toJson(), TheResponseType.map, {}, false);
      print("savedValueList response -- $response");
      customSnackbar("Success", "User profile Saved Successfully", "success");
      UserProfileList.clear();
      await getCreatedByNames("", "name");
    } catch (e) {
      print(e);
    }
  }

  updateUserProfile(UserModel item) async {
    print("stateeeeee------" + stateId.value);

    int? tryParseInt(String? value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      return int.tryParse(value);
    }

    var datas = UserModel(
      id: item.id,
      username: userNameController.text.isEmpty ? "" : userNameController.text,
      displayName: nameController.text.isEmpty ? "" : nameController.text,
      email: emailController.text.isEmpty ? "" : emailController.text,
      password: item.password,
      name: nameController.text.isEmpty ? "" : nameController.text,
      lastName: item.lastName,
      active: item.active,
      roleIds: selectedUserRoleList.map<int>((item) => item.id!).toList(),
      currentAddress: currentAddressController.text.isEmpty
          ? ""
          : currentAddressController.text,
      permanentAddress: permaentAddressController.text.isEmpty
          ? ""
          : permaentAddressController.text,
      prefixId: tryParseInt(prefixId.value),
      countryId: tryParseInt(countryId.value),
      stateId: tryParseInt(stateId.value),
      cityId: tryParseInt(cityId.value),
      areaId: tryParseInt(areaId.value),
      genderId: tryParseInt(genderId.value),
      pinCode: pincodeController.text.isEmpty ? "" : pincodeController.text,
      employeeNumber: employeeCodeController.text.isEmpty
          ? ""
          : employeeCodeController.text,
      telephoneNumber: telePhoneNumController.text.isEmpty
          ? ""
          : telePhoneNumController.text,
      mobileNumber:
          mobileNumController.text.isEmpty ? "" : mobileNumController.text,
      dateOfBirth: DOBController.text.isEmpty ? "" : DOBController.text,
      dateOfJoin: dateOfJoiningController.text.isEmpty
          ? ""
          : dateOfJoiningController.text,
      dateOfLeaving: dateOfLeavingController.text.isEmpty
          ? ""
          : dateOfLeavingController.text,
      comments: commentsController.text.isEmpty ? "" : commentsController.text,
      employeeTypeId:
          employeeTypeId.isEmpty ? null : int.parse(employeeTypeId.value),
      deleted: item.deleted,
      isLogInRequired: item.isLogInRequired,
      employeeId: item.employeeId,
      employeeStatusId: item.employeeStatusId,
      panNumber: item.panNumber,
      securityAnswer: item.securityAnswer,
      securityQuestionId: item.securityQuestionId,
      companyId: item.companyId,
      userLanguage: item.userLanguage,
      userThemeName: item.userThemeName,
    );

    print("data-----${datas.toJson().toString()}");
    try {
      Map<String, dynamic> response = await apiCallService(
          "/user", "POST", datas.toJson(), TheResponseType.map, {}, false);
      print("savedValueList response -- $response");
      UserProfileList.clear();
      UserProfileList.refresh();

      await getCreatedByNames("", "name");
      Get.back();
      Get.back();
      customSnackbar("Success", "User profile Saved Successfully", "success");
    } catch (e) {
      print(e);
    }
  }

  clearFunction() {
    emailController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    userNameController.clear();
    prefixId.value = '';
    prefixName.value = '';
    genderId.value = '';
    genderName.value = '';
    stateId.value = '';
    stateController.clear();
    cityId.value = '';
    cityController.clear();
    areaId.value = '';
    areaController.clear();
    countryId.value = '';
    countryController.clear();
    employeeTypeId.value = '';
    employeeTypeController.clear();
    userRoleId.value = '';
    userRoleController.clear();
    nameController.clear();
    pincodeController.clear();
    dateOfJoiningController.clear();
    dateOfLeavingController.clear();
    DOBController.clear();
    mobileNumController.clear();
    telePhoneNumController.clear();
    employeeCodeController.clear();
    permaentAddressController.clear();
    currentAddressController.clear();
    commentsController.clear();
    validationMessage.value = "";
    validationMessageGender.value = "";
    validationMessageemployeeType.value = "";
    userRoleController.clear();
    userRoleId.value = "";
    selectedUserRoleList.clear();
    reportingBranchController.clear();
    getAllBranchList.clear();
    getBranchId.value = "";
    isStaffSelected.value = false;
  }
}
