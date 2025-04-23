// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suktha_crm/Constants/shared_pref_keys.dart';
import 'package:suktha_crm/Model/login_model.dart';
import 'package:suktha_crm/utils/check_token_expired.dart';
import 'package:suktha_crm/view/screens/login/login_screen.dart';
import 'package:suktha_crm/view/widget/snackbar.dart';

import '../Model/company_model.dart';
import '../Model/menu_model.dart';
import '../utils/Services/rest_api_services.dart';
import '../utils/api/common_api.dart';

import 'package:suktha_crm/Model/login_model.dart' as loginModel;

class GlobalController extends GetxController {
  RxList<MenuModel> menuList = <MenuModel>[].obs;

  CompanyModel? companyDetails;

  RxBool isJobworkIncluded = false.obs;
  RxBool isItemLevel = true.obs;
  RxBool isPurchaseItemLevel = true.obs;
  RxBool isStateLevel = false.obs;

  loginModel.LoginModel? loginDetails;

  onInit() {
    super.onInit();

    loadSharedPreferencesUserMenuData();
    loadSharedPrefCompanyDetails();
  }

  Future<List<MenuModel>> getMenus() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var userName = sharedPreferences.get("user");

    try {
      List<dynamic> result = await apiCallService("$menuUrl/${userName}", 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth

      List<MenuModel> menuListValue = (result).map((e) => MenuModel.fromJson(e)).toList();

      menuListValue.forEach((element) {
        log("menuListValue: ${element.name}");
      });

      // log("These items are in the menu list matching : $menuListValue");

      List<String> encodedMenuList = menuListValue.map((value) => jsonEncode(value.toJson())).toList();

      log("These items are in the menu lists matching : $encodedMenuList");

      await sharedPreferences.setStringList('userMenu', encodedMenuList);

      await loadSharedPreferencesUserMenuData();
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      log('Error: $e');
    } finally {
      print("completed");
    }
    return menuList;
  }

  loadSharedPreferencesUserMenuData() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String>? encodedList = sharedPreferences.getStringList('userMenu');

    print("encodedList: $encodedList");

    if (encodedList == null) {
      logoutData();
    }

    menuList.value = encodedList!.map((encoded) => MenuModel.fromJson(jsonDecode(encoded))).toList();

    menuList.refresh();
  }

  loadSharedPrefCompanyDetails() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? companyEncodedDetails = sharedPreferences.getString(SharedPrefKeys().CompanyDetailsKey);

    companyDetails = CompanyModel.fromJson(jsonDecode(companyEncodedDetails!));

    print("-company details- ${companyDetails!.name}");
  }

  Future logoutData() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    Dio dio = Dio();
    var logoutApi = (baseUrl + "/logout");

    await deleteFcmToken();

    try {
      final response = await dio.get(logoutApi, options: Options(headers: {"Authorization": "Bearer ${loginDetails.token}"}));

      print("statuscode${response.statusCode}");
      print("statuscode${response.data}");

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        /// this will delete cache

        customSnackbar("Logout Success", "You have been successfully logged Out", "success");

        print(response.data);

        await sharedPreferences.clear();

        sharedPreferences.setBool("onboardKey", true);

        Get.offAll(() => LoginPage(), transition: Transition.fade, duration: const Duration(milliseconds: 1000));
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);

      print(e);
    } finally {}
  }

  Future? setStateId(int? stateId) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    loginDetails = loginModel.LoginModel.fromJson(logindecoded);
    if (loginDetails!.user!.name != null) {
      print(loginDetails!.user!.company!.state!.id ?? "");
    }

    if (loginDetails!.user!.company!.state!.id == stateId) {
      isStateLevel.value = true;
    } else {
      isStateLevel.value = false;
    }

    print("state level: ${isStateLevel.value}");
    return null;
  }

  Future<void> deleteFcmToken() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? fcmId = sharedPreferences.getString(SharedPrefKeys().userFcmId);

    print("fcmId: $fcmId");

    try {
      var response = await apiCallService("/deleteUserFcmToken/$fcmId", "GET", {}, TheResponseType.map, {}, false);

      if (response != null && response['status'] == 'success') {
        print("FCM token deleted successfully");
      } else {
        print("Failed to delete FCM token: ${response?['message'] ?? 'Unknown error'}");
      }
    } catch (e) {
      print("Error deleting FCM token: $e");
    }
  }
}
