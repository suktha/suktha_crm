// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_Force/Model/Material_category_model.dart';
import 'package:work_Force/Model/get_party_master_model.dart';
import 'package:work_Force/Model/get_po_model.dart';
import 'package:work_Force/Model/material_models.dart';
import 'package:work_Force/Model/taxes_model.dart';
import 'package:work_Force/Model/unit_model.dart';
import 'package:work_Force/utils/Services/rest_api_services.dart';
import 'package:work_Force/utils/api/common_api.dart';
import 'package:work_Force/utils/api/po.dart';
import 'package:work_Force/utils/check_token_expired.dart';
import 'package:work_Force/view/screens/settings_module/Masters/Masters%20Items/Material%20Master/View%20Material%20Master/list_material_master.dart';
import 'package:work_Force/view/widget/snackbar.dart';
import '../../../../../../../Model/type_model.dart';
import 'package:http/http.dart' as http;
import '../Model/financial_year_model.dart';
import '../Model/login_model.dart';
import '../Model/material_list_model.dart';

class MaterialMasterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController materialTypeController = TextEditingController();
  TextEditingController hsnController = TextEditingController();
  TextEditingController currentStockController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController openingStockController = TextEditingController();
  TextEditingController partNumberController = TextEditingController();
  TextEditingController minimumStockController = TextEditingController();
  TextEditingController taxController = TextEditingController();
  TextEditingController mrpController = TextEditingController();
  TextEditingController buyingPriceController = TextEditingController();
  TextEditingController specificationController = TextEditingController();
  TextEditingController aliasNameController = TextEditingController();
  TextEditingController sellingPriceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
    TextEditingController partyController = TextEditingController();


  RxList<TypeModel> materailTypeList = <TypeModel>[].obs;
  RxList<MaterialModel> materialNameList = <MaterialModel>[].obs;
  RxList<UnitsModel> unitList = <UnitsModel>[].obs;
  RxList<TaxesModel> taxList = <TaxesModel>[].obs;
  RxList<MaterialCategoryModel> categoryList = <MaterialCategoryModel>[].obs;
  RxList<PartyDTO> partyList = <PartyDTO>[].obs;

  MaterialListModel? saveMaterailValue;

  Map? mapvalue;

  RxBool supplyType = false.obs;
  RxBool inclusiveTaxIschecked = false.obs;
  RxString taxeS = "".obs;
  RxDouble taxRate = 0.0.obs;
  int? taxid;
  int? unitId;
  RxInt categoryId =0.obs;
    RxInt partyId =0.obs;

  RxString inclusiveTaxAmount = "".obs;
  RxString inclusiveTaxRate = "".obs;
  RxBool nocustomerFound = false.obs;
  RxBool customerSelected = false.obs;
  RxString poParty = "".obs;
  RxString poid = "".obs;
  String? currencyVal;
  RxBool isOpenEnded = false.obs;
  RxBool isPageLoading = false.obs;

  Future<List<TypeModel>> getMaterialTypeList(String query) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    print(token);

    Dio dio = Dio();

    var apiData = ('$baseUrl/material-type');

    try {
      final response = await dio.get(apiData,
          options: Options(headers: {"Authorization": "Bearer $token"}));

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        List<TypeModel> result =
            (response.data as List).map((e) => TypeModel.fromJson(e)).toList();

        materailTypeList.value = result;
        materailTypeList.refresh();

        materailTypeList.sort(
          (a, b) => a.name!.toLowerCase().toString().compareTo(
                b.name!.toLowerCase().toString(),
              ),
        );
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return materailTypeList;
  }

  Future<List<UnitsModel>> getUnitLists(String query) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    print(token);

    Dio dio = Dio();

    var apiData = (baseUrl + unitsUrl);

    try {
      final response = await dio.get(apiData,
          options: Options(headers: {"Authorization": "Bearer $token"}));

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        List<UnitsModel> result = (response.data as List)
            .where((e) => e['isSubscriptionBasedService'] == 0)
            .map((e) => UnitsModel.fromJson(e))
            .toList();
        unitList.value = result;
        unitList.refresh();
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return unitList;
  }

  Future<List<TaxesModel>> getTaxesList(String query) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    print("----------------------007----------------------------$token");

    Dio dio = Dio();

    var apiData = (baseUrl + taxesUrl);

    try {
      final response = await dio.get(apiData,
          options: Options(headers: {"Authorization": "Bearer $token"}));

      print(response.data);

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        List<TaxesModel> result =
            (response.data as List).map((e) => TaxesModel.fromJson(e)).toList();

        taxList.value = result;
        taxList.refresh();
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return taxList;
  }

  Future saveMaterialMaster() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString('token');

    Map map = saveMaterailValue!.toJson();

    print(map);

    var mapdatas = jsonEncode(map);

    var apiData = "$baseUrl/material";

    try {
      final response = await http.post(
        Uri.parse(apiData),
        body: mapdatas,
        headers: {
          "Authorization": "Bearer $token",
          "content-type": "application/json"
        },
      );

      log("ajith--------------------response dataaa a-------------${response.body}");
      print(
          "ajith--------------------response dataaa a-------------${response.statusCode}");

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        MaterialListModel value =
            MaterialListModel.fromJson(jsonDecode(response.body));

        customSnackbar("Success", "successfully Saved", "success");

        Get.offAll(
            () => const MaterialMasterScreen(
                ),
            transition: Transition.fade,
            duration: const Duration(milliseconds: 600));
      } else {
        customSnackbar("error", "Material is not Saved", "error");
        print(response.statusCode);
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      print("step 5");
      print(e);
    } finally {
      isPageLoading.value = false;
    }
  }

  Future<List<MaterialCategoryModel>?>fetchCategory() async {
    try {
      var apiUrl = "/materialCategory";
      List<dynamic> value = await apiCallService(
          apiUrl, "GET", {}, TheResponseType.list, {}, false);
      List<MaterialCategoryModel> result =
          value.map((e) => MaterialCategoryModel.fromJson(e)).toList();
      categoryList.value = result;
      categoryList.refresh();
    } catch (e) {
      print("error--$e");
    }
    return categoryList;
  }


   Future<List<PartyDTO>?>fetchPartyList() async {
    try {
      var apiUrl = "/parties";
      List<dynamic>  value = await apiCallService(
          apiUrl, "GET", {}, TheResponseType.list, {}, false);

          List<PartyDTO> partyDtoList = value.map((e) => PartyDTO.fromJson(e["partyDTO"])).toList();
      partyList.value = partyDtoList;
      print("partylisttt-----$partyList");
      partyList.refresh();
    } catch (e) {
      print("error partylist--$e");
    }
    return partyList;
  }

  Future updateMaterialMaster(GetPOlistModel? poSavedValue,
      List<GetPOlistModel>? getList, int? indexList) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString('token');

    final financialYearDetailDEcoded =
        json.decode(sharedPreferences.getString('financialYear')!);

    final financialYear =
        FinancialYearModel.fromJson(financialYearDetailDEcoded);

    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    var value;
    Map map = value.toJson();

    // print(editedList);
    print(map);

    var mapdatas =
        jsonEncode({"purchaseOrderHeader": map, "itemToBeRemove": []});

    log(mapdatas.toString());

    Dio dio = Dio();

    var apiData = baseUrl + PurchaseOrderUrl;

    // print(apiData);

    try {
      final response = await dio.post(apiData,
          data: mapdatas,
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
              "content-type": "application/json"
            },
          ));

      // final response = await http.post(
      //   Uri.parse(apiData),
      //   body: mapdatas,
      //   headers: {
      //     "Authorization": "Bearer $token",
      //     "content-type": "application/json"
      //   },
      // );

      print("this is status code ${response.data}");

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        GetPOlistModel value = GetPOlistModel.fromJson(response.data);

        print("this is status code ${response.data}");

        customSnackbar("Success", "successfully Saved", "success");

        // Get.offAll(
        //     () => OpenPurchaseOrderScreen(
        //           poSavedModel: value,
        //         ),
        //     transition: Transition.fade,
        //     duration: Duration(milliseconds: 600));
      } else {
        customSnackbar("error", "Material Master is not Saved", "error");
        print(response.statusCode);
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      await checkTokenExpired(e.response!.statusCode);
      print("step 5");
      print(e.response!.data);
    }
  }
}
