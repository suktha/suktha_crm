import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_Force/Model/login_model.dart';
import 'package:work_Force/Model/service_material_model.dart';
import 'package:work_Force/Model/type_model.dart';
import 'package:work_Force/utils/Services/rest_api_services.dart';
import 'package:work_Force/utils/api/common_api.dart';
import 'package:work_Force/utils/check_token_expired.dart';
import 'package:work_Force/view/widget/snackbar.dart';
import '../Model/transaction_number.dart';

class GetServiceMasterController extends GetxController {
  late TextEditingController printHeaderTextController, searchController;
  @override
  void onInit() {
    super.onInit();

    printHeaderTextController = TextEditingController();
    searchController = TextEditingController();
  }

  RxList<ServiceMaterialListModel> ServiceMasteritem = <ServiceMaterialListModel>[].obs;

  RxBool loading = false.obs;
  RxBool hasMore = true.obs;
  RxBool listLoad = false.obs;
  RxBool hidefloatingButton = true.obs;
  RxBool materialImageIschecked = false.obs;
  RxString searchValue = "".obs;
  RxBool isPageLoading = false.obs;
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

  TransactionNumberModel? ServiceMasterTransactionNumber;

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

  Future<List<ServiceMaterialListModel>> getServiceMasterlist(
      String query, int page, String sortDirection, String sortWith, bool isFilter) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    print(loginDetails.token);

    const limit = 10;

    Dio dio = Dio();

    var apiData = "$baseUrl/material/recent/2/0/$sortWith/$sortDirection/$page/$limit?searchText=$query";

    print("url---------- $apiData");

    try {
      final response = await dio.get(apiData, options: Options(headers: {"Authorization": "Bearer ${loginDetails.token}"}));

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        page == 0 ? ServiceMasteritem.clear() : null;

        page++;

        loading.value = true;

        Map<String, dynamic> data = response.data;

        List<dynamic> headers = data['materials'];

        listLoad.value = false;

        if (headers.length < limit) {
          hasMore.value = false;
          print("limited------");
        }
        ServiceMasteritem.addAll(headers.map((header) => ServiceMaterialListModel.fromJson(header)).toList());

        ServiceMasteritem.refresh();
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      print("fjdlsfjslfjsljfslflfj$e");
    }
    return ServiceMasteritem;
  }

  deletePoList(
    bool isPopup,
    ServiceMaterialListModel? SavedPurchaseResult,
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

        await getServiceMasterlist("", 0, "desc", "name", false);
      } else {
        customSnackbar("Can't Delete", response.data["responseString"], "error");
      }
      print(response.statusCode);
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      print(e);
    }
  }
}
