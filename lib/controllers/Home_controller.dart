// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_Force/Constants/shared_pref_keys.dart';
import 'package:work_Force/Model/company_model.dart';
import 'package:work_Force/Model/global_settings_model.dart';
import 'package:work_Force/Model/response_string_model.dart';
import 'package:work_Force/Model/transaction_number.dart';
import 'package:work_Force/Model/transaction_type_model.dart';
import 'package:work_Force/controllers/global_controller.dart';
import 'package:work_Force/utils/Services/rest_api_services.dart';
import 'package:work_Force/utils/Services/sharedpref_services.dart';
import 'package:work_Force/utils/api/common_api.dart';
import 'package:work_Force/utils/check_token_expired.dart';
import 'package:work_Force/view/screens/login/login_screen.dart';
import 'package:work_Force/view/widget/snackbar.dart';

import '../Model/login_model.dart';

class HomeController extends GetxController {
  final globalController = Get.find<GlobalController>();

  RxList<TransactionTypeModel> transactionTypeList = <TransactionTypeModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCompanyLogoName();
    getCompanyDetails();
    transactionType();
    getGlobalSettings();
  }

  RxBool loading = false.obs;
  RxBool isPageLoading = false.obs;
  RxBool showWidget = false.obs;

  final typeidVAlues = RxMap<String, dynamic>();

  RxString username = "".obs;
  RxString companyImage = "".obs;
      RxBool isLoginIdIsAdmin = false.obs;
        RxBool isLoginIdIsbranchmanger = false.obs;



  Future<List<TransactionTypeModel>> transactionType() async {
    Dio dio = Dio();

    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');

    var apiData = (baseUrl + transactionTypeUrl);

    try {
      final response = await dio.get(apiData, options: Options(headers: {"Authorization": "Bearer $token"}));

      if (response.statusCode == 200) {
        List<TransactionTypeModel> result = (response.data as List).map((e) => TransactionTypeModel.fromJson(e)).toList();

        transactionTypeList.value = result;
        transactionTypeList.refresh();
      } else {
        throw Exception('Failed to load transaction types');
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    }
    return transactionTypeList;
  }

  GlobalSetting? globalSettings;

  Future getGlobalSettings() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      Map<String, dynamic> response = await apiCallService(SettingsUrl, 'GET', {}, TheResponseType.map, {}, false); //--url, Method, body, responsetype, query parameter, isAuth

      GlobalSetting result = GlobalSetting.fromJson(response['globalSetting']);

      Map decodedMap = result.toJson();

      await sharedPreferences.setString(SharedPrefKeys().GlobalSettingsKey, json.encode(decodedMap));

      SettingsModel settingsvalue = SettingsModel.fromJson(response);

      Map settingsDecodedMap = settingsvalue.toJson();
      await sharedPreferences.setString(SharedPrefKeys().settingsKey, json.encode(settingsDecodedMap));

      final globalSettingsDecoded = json.decode(sharedPreferences.getString(SharedPrefKeys().GlobalSettingsKey)!);
      globalSettings = GlobalSetting.fromJson(globalSettingsDecoded);

      globalSettings!.itemLevelTax == 0 ? globalController.isItemLevel.value = false : globalController.isItemLevel.value = true;
      globalSettings!.itemLevelTaxPurchase == 0 ? globalController.isPurchaseItemLevel.value = false : globalController.isPurchaseItemLevel.value = true;

      log("--------sales Item level tax ---------------${globalSettings!.financialYearId}");
      log("--------purchase Item level tax ---------------${globalSettings!.itemLevelTaxPurchase}");
      log("-check--einvoice-home-${globalSettings!.allowEinvoiceWithEwayBill}");
      log("-check--ewaybill-home-${globalSettings!.allowEwayBill}");
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      print('Error: $e');
    }
  }

  Future<void> deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  /// this will delete app's storage
  Future<void> deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }

  Future logoutData() async {
    isPageLoading.value = true;

    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    Dio dio = Dio();
    var apiData = (baseUrl + "/logout");

    print("${loginDetails.token}");
    print(apiData);

    try {
      final response = await dio.get(apiData, options: Options(headers: {"Authorization": "Bearer ${loginDetails.token}"}));

      print("statuscode${response.statusCode}");
      print("statuscode${response.data}");

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        /// this will delete cache

        customSnackbar("Logout Success", "You have been successfully logged Out", "success");

        print(response.data);

        await deleteCacheDir();
        await deleteAppDir();

        await sharedPreferences.clear();

        sharedPreferences.setBool("onboardKey", true);

        Get.offAll(() => const LoginPage(), transition: Transition.fade, duration: const Duration(milliseconds: 1000));
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      await checkTokenExpired(e.response!.statusCode);
      isPageLoading.value = false;
      print(e);
    } finally {
      isPageLoading.value = false;
    }
  }

  //download image----

  final Rx<Uint8List?> companyLogo = Rx<Uint8List?>(null);

  getCompanyLogoName() async {
    String url = '/company/logo/1';

    try {
      Map<String, dynamic> response = await apiCallService(url, "GET", {}, TheResponseType.map, {}, false);

      final value = TransactionNumberModel.fromJson(response);

      value.responseString == null ? SharedPreferencesService.instance.removeValue(SharedPrefKeys().CompanyLogoKey) : null;

      getMaterialImageName(value.responseString!);

      print("printing companyLogo ${companyLogo.value}");

      // Assuming that 'imageData' is the key in your response containing image data
    } catch (e) {
      // Handle errors and return an empty Uint8List or null based on your requirements
      return Uint8List(0);
    }
  }

  getCompanyDetails() async {
    Map<String, dynamic> response = await apiCallService("/company/1", "GET", {}, TheResponseType.map, {}, false);
    CompanyModel responsevalue = CompanyModel.fromJson(response);

    print("company details saving");

    Map companyDetailsMapData = responsevalue.toJson();
    await SharedPreferencesService.instance.setValue(SharedPrefKeys().CompanyDetailsKey, jsonEncode(companyDetailsMapData));

    // String? companyEncodedDetails = await SharedPreferencesService.instance.getValue(SharedPrefKeys().CompanyDetailsKey);

    // CompanyModel companyDetails = CompanyModel.fromJson(jsonDecode(companyEncodedDetails!));

    // print("-company details get-name ${companyDetails.name}");
    update();
  }

  String uint8ListToBase64(Uint8List uint8List) {
    return base64Encode(uint8List);
  }

  getMaterialImageName(String imageName) async {
    String? responseValue;

    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    String api = baseUrl + '/files/company-base64/$imageName';

    print(api);

    Dio dio = Dio();

    try {
      var response = await dio.get(api, options: Options(headers: {"Authorization": "Bearer ${loginDetails.token}", "content-type": "application/json"}));

      var value = ResponseStringModel.fromJson(response.data);

      responseValue = value.responseString!;

      final base64String = responseValue.split(',').last;

      // Decode and update the companyLogo value
      companyLogo.value = base64.decode(base64String);

      print("printing companyLogo ${companyLogo.value}");

      String base64S = uint8ListToBase64(companyLogo.value!);

      print("logo --- setting home controller");

      await SharedPreferencesService.instance.setValue(SharedPrefKeys().CompanyLogoKey, base64S);
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    }
    return responseValue;
  }

  final ImagePicker _picker = ImagePicker();

  Future<XFile?> obtainImage({required ImageSource source}) async {
    final file = await _picker.pickImage(
      source: source,
    );

    return file;
  }

  uploadImage(XFile file) async {
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        file.path,
        filename: file.name,
      ),
    });

    Map<String, dynamic> response = await apiCallService("/files/company", "POST", formData, TheResponseType.map, {}, false);

    print(response);

    await getCompanyLogoName();
  }
}
