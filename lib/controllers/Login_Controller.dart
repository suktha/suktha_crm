import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suktha_crm/Constants/shared_pref_keys.dart';
import 'package:suktha_crm/Model/financial_year_model.dart';
import 'package:suktha_crm/Model/global_settings_model.dart';
import 'package:suktha_crm/Model/login_model.dart';
import 'package:suktha_crm/controllers/global_controller.dart';
import 'package:suktha_crm/controllers/initial_controller.dart';
import 'package:suktha_crm/utils/Services/rest_api_services.dart';
import 'package:suktha_crm/utils/api/common_api.dart';
import 'package:suktha_crm/utils/api/login.dart';
import 'package:suktha_crm/utils/check_token_expired.dart';
import 'package:suktha_crm/view/bottom_navigation/bottom_navigation_mainscreen.dart';
import 'package:suktha_crm/view/screens/pre_sales/pre_sale_screen.dart';
import 'package:suktha_crm/view/widget/snackbar.dart';
// import 'package:suktha/Constants/shared_pref_keys.dart';
// import 'package:suktha/Controller/global_controller.dart';
// import 'package:suktha/Controller/initial_controller.dart';
// import 'package:suktha/Model/financial_year_model.dart';
// import 'package:suktha/Model/global_settings_model.dart';
// import 'package:suktha/Model/login_model.dart';
// import 'package:suktha/Model/transaction_type_model.dart';
// import 'package:suktha/utils/Services/rest_api_services.dart';
// import 'package:suktha/utils/api/common_api.dart';
// import 'package:suktha/utils/api/login.dart';
// import 'package:suktha/utils/check_token_expired.dart';

// import '../View/BottomNavigationBar/navigation_bar_screen.dart';
// import '../View/Widgets/snackbar.dart';

class LoginController extends GetxController {
  final initialController = Get.find<InitialController>();
  final globalController = Get.find<GlobalController>();

  RxBool obscureText = true.obs;
  bool loginsuccess = true;

  RxBool subscriptionMessageShown = false.obs;

  DateTime? loginTime;

  void saveLoginTime() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    loginTime = DateTime.now();
    sharedPreferences.setString(SharedPrefKeys().LastLoginTimeKey, loginTime.toString());
  }

  void logout() {
    loginTime = null;
  }

  late TextEditingController usernameController, passwordController;

  final RoundedLoadingButtonController btnController1 = RoundedLoadingButtonController();

  // RxList<TransactionTypeModel> customerInvoiceType = <TransactionTypeModel>[].obs;
  // RxList<TransactionTypeModel> purchaseInvoiceType = <TransactionTypeModel>[].obs;
  // RxList<TransactionTypeModel> subContractingInvoiceType = <TransactionTypeModel>[].obs;
  // RxList<TransactionTypeModel> jobWorkInvocieType = <TransactionTypeModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  RxBool isSubscriptionEnded = false.obs;
  Future loginData(RoundedLoadingButtonController controller, BuildContext context) async {
    controller.reset();
    controller.start();
    Dio dio = Dio();
    var apiData = (baseAuthUrl + loginUrl);

    isSubscriptionEnded.value = false;

    Map mapdatas = {
      "username": usernameController.text.trim(),
      "password": passwordController.text.trim(),
    };
    print(apiData);

    print("username: ${usernameController.text.trim()} -password: ${passwordController.text.trim()}");

    try {
      final response = await dio.post(apiData, data: json.encode(mapdatas));

      print("statuscode${response.statusCode}");
      log("statuscode${response.data}");

      if (response.statusCode == 200) {
        LoginModel result = LoginModel.fromJson(response.data);

        log(result.user!.company!.subscriptionEnd!);

        String apiSubscriptionEnd = result.user!.company!.subscriptionEnd!;

        DateTime subscriptionEnd = DateTime.parse(apiSubscriptionEnd);

        if (subscriptionEnd.isBefore(DateTime.now())) {
          print('Subscription has ended.');

          controller.stop();

          isSubscriptionEnded.value = true;
        } else {
          int daysLeft = subscriptionEnd.difference(DateTime.now()).inDays;
          print('Subscription will end in $daysLeft days.');
        }

        Map resultMap = result.toMap();
        loginDetails.value = result;
        loginDetails.refresh();

        String token = loginDetails.value.token!;
        String user = loginDetails.value.user!.username!;
        int userId = loginDetails.value.user!.id!;

        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

        sharedPreferences.setString('token', token);
        sharedPreferences.setString('user', user);

        await sharedPreferences.setString('userMap', json.encode(resultMap));

        subscriptionMessageShown.value = true;

        if (isSubscriptionEnded.value == false) {
          sharedPreferences.setBool('loginsuccess', loginsuccess);

          saveLoginTime();

          await postUserFCMtoken(userId, token);
          await globalController.getMenus();
          financialYear();
          GetGlobalSettings();
          // initialController.fetchDashboardData();
          // initialController.getInvoicePayment();
          controller.success();
          customSnackbar("Success", "Login Successful", "success");

          Timer(
            const Duration(milliseconds: 700),
            () {
              Get.offAll(
                  () => const BottomNavigationMainscreen(
                        initialIndex: 0,
                      ),
                  transition: Transition.fade,
                  duration: const Duration(milliseconds: 700));
              clearTextInput();
            },
          );
        }
      } else {
        Timer(const Duration(seconds: 1), () {
          controller.error();
          customSnackbar("Error", "You have entered wrong login credentials", "error");
          Timer(const Duration(seconds: 2), () => controller.stop());
        });
      }
    } on DioException catch (e) {
      print(e.response?.data);
      Timer(const Duration(seconds: 1), () {
        controller.error();
        customSnackbar("Error", "You have entered wrong login credentials", "error");
        Timer(const Duration(seconds: 1), () => controller.stop());
      });
    } finally {}
  }

  postUserFCMtoken(int userId, String loginToken) async {
    print("postUserFCMtoken");
    String url = "/saveUserFcmToken";
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? fcmToken = sharedPreferences.getString('fcmToken');
    log('Retrieved FCM Token: $fcmToken');

    if (fcmToken == null) {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      fcmToken = await messaging.getToken();

      log('shared pref fcm null -- FCM Token: $fcmToken');
    }

    Map mapDatas = {
      "id": null,
      "userId": userId,
      "fcmToken": fcmToken.toString(),
      "deviceType": "M",
      "jwtToken": loginToken,
    };

    print("fcmToken: ${mapDatas.toString()}");

    Map<String, dynamic> result = await apiCallService(url, "POST", mapDatas, TheResponseType.map, {}, false);

    if (result.containsKey("id")) {
      await sharedPreferences.setString('userFcmId', result["id"]);
      log('Stored FCM ID in SharedPreferences: ${result["id"]}');
    }
  }

  clearTextInput() {
    usernameController.clear();
    passwordController.clear();
  }

  // // LoginRepository getLoginRepository = LoginRepository();

  var loginDetails = LoginModel().obs;

  Future financialYear() async {
    Dio dio = Dio();

    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');

    var apiData = (baseUrl + financialYearUrl);
    try {
      final response = await dio.get(apiData, options: Options(headers: {"Authorization": "Bearer $token"}));

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        FinancialYearModel result = FinancialYearModel.fromJson(response.data);

        Map decodedMap = result.toJson();

        // result.isActive == 1 ?

        await sharedPreferences.setString('financialYear', json.encode(decodedMap));

        final financialYearDetailDEcoded = json.decode(sharedPreferences.getString('financialYear')!);

        final financialYear = FinancialYearModel.fromJson(financialYearDetailDEcoded);

        print(financialYear.financialYear);
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      print(e);
    }
  }

  Future GetGlobalSettings() async {
    Dio dio = Dio();

    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');

    var apiData = (baseUrl + globalSettingUrl);
    try {
      final response = await dio.get(apiData, options: Options(headers: {"Authorization": "Bearer $token"}));

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        GlobalSetting result = GlobalSetting.fromJson(response.data);

        Map decodedMap = result.toJson();

        await sharedPreferences.setString(SharedPrefKeys().GlobalSettingsKey, json.encode(decodedMap));

        final globalSettingsDecoded = json.decode(sharedPreferences.getString(SharedPrefKeys().GlobalSettingsKey)!);

        final globalSettings = GlobalSetting.fromJson(globalSettingsDecoded);

        globalSettings.itemLevelTax == 0 ? globalController.isItemLevel.value = false : globalController.isItemLevel.value = true;
        globalSettings.itemLevelTaxPurchase == 0 ? globalController.isPurchaseItemLevel.value = false : globalController.isPurchaseItemLevel.value = true;

        log("--------sales Item level tax ---------------${globalSettings.itemLevelTax}");
        log("--------purchase Item level tax ---------------${globalSettings.itemLevelTaxPurchase}");
        log("-check--ewaybill-login-${globalSettings.allowEinvoiceWithEwayBill}");
        log("-check--ewaybill-login-${globalSettings.allowEwayBill}");

        log("this data is coming from the global settings api");
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      print(e);
    }
  }
}
