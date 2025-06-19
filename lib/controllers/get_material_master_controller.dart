// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_Force/Model/login_model.dart';
import 'package:work_Force/Model/taxes_model.dart';
import 'package:work_Force/Model/type_model.dart';
import 'package:work_Force/utils/Services/rest_api_services.dart';
import 'package:work_Force/utils/api/common_api.dart';
import 'package:work_Force/utils/check_token_expired.dart';
import 'package:work_Force/view/widget/snackbar.dart';

import '../Model/material_list_model.dart';
import '../Model/transaction_number.dart';

class GetMaterialMasterController extends GetxController {
  late TextEditingController printHeaderTextController, searchController;
  @override
  void onInit() {
    super.onInit();

    getTaxesList("");
    getMaterialTypeList();

    printHeaderTextController = TextEditingController();
    searchController = TextEditingController();
  }

  RxList<MaterialListModel> materialMasteritem = <MaterialListModel>[].obs;

  RxList<TaxesModel> taxList = <TaxesModel>[].obs;

  RxBool loading = false.obs;
  RxBool hasMore = true.obs;
  RxBool listLoad = false.obs;
  RxBool hidefloatingButton = true.obs;
  RxBool materialImageIschecked = false.obs;
  RxString searchValue = "".obs;
  RxString sortdirection = "desc".obs;
  RxString sortwith = "name".obs;
  RxList<String> selectedStatuses = <String>[].obs;
  RxBool isFilter = false.obs;

  RxBool sortDirection = true.obs;

  void containerOnpressed() {
    sortDirection.value = !sortDirection.value;
  }

  RxString selectedRadio = "".obs;

  void onRadioSelected(String value) {
    selectedRadio.value = value;
  }

  final dropdownvalue = 'ORIGINAL'.obs;

  TransactionNumberModel? materialMasterTransactionNumber;

  List ismaterialTypeSelected = <bool>[].obs;
  var selectedIndex = (-1).obs;

  void onStatusCheckboxChanged(int index, bool value) {
    if (selectedIndex.value != -1) {
      ismaterialTypeSelected[selectedIndex.value] = false;
    }

    // Select the new index
    ismaterialTypeSelected[index] = true;
    selectedIndex.value = index;
  }

  RxList<TypeModel> materialTypeList = <TypeModel>[].obs;

  getMaterialTypeList() async {
    //35 is the transationtype id of the lead management
    List<dynamic> responseValue = await apiCallService(
        "/material-type", 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
    List<TypeModel> status = (responseValue).map((e) => TypeModel.fromJson(e)).toList();
    materialTypeList.value = status.toList();
    ismaterialTypeSelected = List<bool>.filled(materialTypeList.length, false).obs;
    print("material type bool ---$ismaterialTypeSelected");

    materialTypeList.refresh();
  }

  Future<List<TaxesModel>> getTaxesList(String query) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    print("----------------------007----------------------------$token");

    Dio dio = Dio();

    var apiData = (baseUrl + taxesUrl);

    try {
      final response = await dio.get(apiData, options: Options(headers: {"Authorization": "Bearer $token"}));

      print(response.data);

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        List<TaxesModel> result = (response.data as List).map((e) => TaxesModel.fromJson(e)).toList();

        taxList.value = result;
        taxList.refresh();
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return taxList;
  }

  RxString materialsTypeId = "0".obs;

  Future<List<MaterialListModel>> getMaterialMasterlist(
      String query, int page, String sortDirection, String sortWith, bool isFilter, String materialTypeId) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);

    final loginDetails = LoginModel.fromJson(logindecoded);

    print(loginDetails.token);

    const limit = 10;

    Dio dio = Dio();

    print(query);

    // var apiData = baseUrl + "/materials";
        var apiData = "$baseUrl/material/recent/1/$materialTypeId/$sortWith/$sortDirection/$page/$limit?searchText=$query";


    print("URL----------$apiData");

    try {
      final response = await dio.get(apiData, options: Options(headers: {"Authorization": "Bearer ${loginDetails.token}"}));

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        page == 0 ? materialMasteritem.clear() : null;

        page++;

        loading.value = true;

        Map<String, dynamic> data = response.data;

        List<dynamic> headers = data['materials'];

        listLoad.value = false;

        if (headers.length < limit) {
          hasMore.value = false;

          print("limited-------");
        }

        materialMasteritem.addAll(headers.map((header) => MaterialListModel.fromJson(header)).toList());

        materialMasteritem.refresh();
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      print("fjdlsfjslfjsljfslflfj$e");
    }
    return materialMasteritem;
  }

  deletePoList(
    bool isPopup,
    MaterialListModel? SavedPurchaseResult,
  ) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    var item = SavedPurchaseResult!.id;

    Dio dio = Dio();

    var apiData = "$baseUrl/material/$item";

    print(apiData);

    try {
      final response = await dio.delete(apiData, options: Options(headers: {"Authorization": "Bearer ${loginDetails.token}"}));

      if (response.data['responseStatus'] == 1) {
        isPopup == true ? Get.back() : null;

        customSnackbar("Deleted", response.data["responseString"], "success");

        getMaterialMasterlist("", 0, "asc", "name", false, "0");
      } else if (response.data['responseStatus'] == 0) {
        customSnackbar("Can't Delete", response.data["responseString"], "error");
      }
      print("status code ------ ${response.statusCode}");
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      if (e.response!.statusCode == 500) {
        customSnackbar("Can't Delete", "Material is being used somewhere else", "error");
      }
      print(e);
    }
  }
}
