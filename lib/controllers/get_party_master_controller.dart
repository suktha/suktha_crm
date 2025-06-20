// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_Force/Model/login_model.dart';
import 'package:work_Force/Model/save_bank_model.dart';
import 'package:work_Force/utils/api/common_api.dart';
import 'package:work_Force/utils/api/po.dart';
import 'package:work_Force/utils/check_token_expired.dart';
import 'package:work_Force/view/widget/snackbar.dart';
import '../Model/get_party_master_model.dart';
import '../Model/materialPriceListModel.dart';

class GetPartyMasterController extends GetxController {
  late TextEditingController printHeaderTextController, searchController;

  @override
  void onInit() {
    super.onInit();

    printHeaderTextController = TextEditingController();
    searchController = TextEditingController();
  }

  // RxList<PartyMasterListModel> partyMasterList = <PartyMasterListModel>[].obs;
  // RxList<Map<String, dynamic>> itemData = <Map<String, dynamic>>[].obs;

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

  RxBool isPageLoading = false.obs;

  final dropdownvalue = 'ORIGINAL'.obs;

  RxList<MaterialPriceListModel> priceListData = <MaterialPriceListModel>[].obs;
  RxList<SaveBankModel> BankListData = <SaveBankModel>[].obs;

  RxBool sortDirection = true.obs;

  void containerOnpressed() {
    sortDirection.value = !sortDirection.value;
  }

  RxString selectedRadio = "".obs;

  void onRadioSelected(String value) {
    selectedRadio.value = value;
  }

  RxList<PartyWithPriceLists> partyMasterList = <PartyWithPriceLists>[].obs;

  Future<List<PartyWithPriceLists>> getPartyMasterlist(String query, int page, String sortDirection, String sortWith, bool isFilter) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    print(loginDetails.token);

    Dio dio = Dio();

    const limit = 10;

    var apiData = "$baseUrl/parties/recent/$sortWith/$sortDirection/$page/$limit?searchText=$query";

    print("api url ----------------- $apiData");

    try {
      final response = await dio.get(apiData, options: Options(headers: {"Authorization": "Bearer ${loginDetails.token}"}));

      print(response.statusCode);

      print("outside-------${response.data}");

      await checkTokenExpired(response.statusCode);

      if (response.statusCode == 200) {
        page == 0 ? partyMasterList.clear() : null;

        loading.value = true;

        Map<String, dynamic> data = response.data;

        print("data-------${data}");

        GetPartyMasterModel partyValue = GetPartyMasterModel.fromJson(data);

        print("new value-------${partyValue.partyWithPriceLists}");

        partyMasterList.addAll(partyValue.partyWithPriceLists!);

        print("partyList-----${partyMasterList.length}");

        listLoad.value = false;

        if (partyMasterList.length < limit) {
          hasMore.value = false;
          print("Limited-----");
        }

        // partyList.forEach((party) {
        //   PartyMasterListModel partyModel = PartyMasterListModel.fromJson(party['partyDTO']);

        //   print("partyModel---------${partyModel}");

        //   partyMasterList.add(partyModel);

        //   List<dynamic>? pricelistJson = party['materialPriceListDTOList'];

        //   if (pricelistJson != null) {
        //     priceListData.value = pricelistJson.map((json) => MaterialPriceListModel.fromJson(json)).toList();
        //   } else {}

        //   print("price-----" + priceListData.toString());

        //   List<dynamic>? bankListJson = party['partyBankMapDTOList'];

        //   if (bankListJson != null) {
        //     BankListData.value = bankListJson.map((json) => SaveBankModel.fromJson(json)).toList();
        //   }

        //   print("bank---" + BankListData.toString());
        // });

        // partyList.forEach((party) {
        //   MaterialPriceListModel priceModel = MaterialPriceListModel.fromJson(
        //       party['materialPriceListDTOList']);

        //   priceListData.value = priceModel;
        // });

        // partyList.forEach((party) {
        //   SaveBankModel bankModel =
        //       SaveBankModel.fromJson(party['partyBankMapDTOList']);

        //   BankListData = bankModel;
        // });

        partyMasterList.refresh();
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      print("fjdlsfjslfjsljfslflfj$e");
    } finally {
      isPageLoading.value = false;
    }
    return partyMasterList;
  }

  var itemDatas;

  // Future getPartyMasterdetails(String id) async {
  //   final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //   final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
  //   final loginDetails = LoginModel.fromJson(logindecoded);

  //   print(loginDetails.token);

  //   Dio dio = Dio();

  //   var apiData = baseUrl + "/party" + "/$id";

  //   print(apiData);

  //   try {
  //     final response = await dio.get(apiData, options: Options(headers: {"Authorization": "Bearer ${loginDetails.token}"}));

  //     await checkTokenExpired(response.statusCode);
  //     if (response.statusCode == 200) {
  //       print(response.data);
  //       // print("Status code - ${response.statusCode}");

  //       Map<String, dynamic> data = response.data;

  //       List<dynamic>? jsonData = data['materialPriceListDTOList'];

  //       if (jsonData != null) {
  //         priceListData.value = jsonData.map((json) => MaterialPriceListModel.fromJson(json)).toList();
  //       } else {}

  //       print("price-----" + priceListData.toString());

  //       List<dynamic>? jsonData1 = data['partyBankMapDTOList'];

  //       if (jsonData1 != null) {
  //         BankListData.value = jsonData1.map((json) => SaveBankModel.fromJson(json)).toList();
  //       }

  //       print("bank---" + BankListData.toString());

  //       // MaterialPriceListModel priceModel =
  //       //     MaterialPriceListModel.fromJson(data['materialPriceListDTOList']);

  //       // priceListData = priceModel;

  //       // List<dynamic> partyList = data['materialPriceListDTOList'];

  //       // listLoad.value = false;

  //       // // partyList.forEach((party) {
  //       // //   PartyMasterListModel partyModel =
  //       // //       PartyMasterListModel.fromJson(party['partyDTO']);

  //       // //   print("partyModel---------${partyModel}");

  //       // //   partyMasterList.add(partyModel);
  //       // // });

  //       // partyList.forEach((party) {
  //       //   SaveBankModel bankModel =
  //       //       SaveBankModel.fromJson(party['partyBankMapDTOList']);

  //       //   BankListData = bankModel;
  //       // });

  //       partyMasterList.refresh();
  //     }
  //   } on DioException catch (e) {
  //     await checkTokenExpired(e.response!.statusCode);
  //     print("fjdlsfjslfjsljfslflfj$e");
  //   } finally {
  //     isPageLoading.value = false;
  //   }
  // }

  deletePartyMasterList(
    bool isPopup,
    PartyDTO? SavedPurchaseResult,
  ) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    var item = SavedPurchaseResult!.id.toString();

    Dio dio = Dio();

    var apiData = "$baseUrl/party/$item";

    print(apiData);

    try {
      final response = await dio.delete(apiData, options: Options(headers: {"Authorization": "Bearer ${loginDetails.token}"}));
      print(response.data);
      if (response.data['responseStatus'] == 1) {
        isPopup == true ? Get.back() : null;
        customSnackbar("Deleted", "Party Master has been deleted Successfully", "success");
        getPartyMasterlist("", 0, "desc", "name", false);
      } else {
        print(response.data['responseStatus']);
        customSnackbar("Can't Delete", "Can't Delete Older Party Master", "error");
      }
      print(response.statusCode);
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      print(e);
    }
  }

  Future closePO(
    id,
  ) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString('token');

    String apiData = "$baseUrl$PurchaseOrderUrl$closePoUrl/$id/1";

    // 1 means close the po and 0 means not closed

    Dio dio = Dio();

    try {
      final response =
          await dio.get(apiData, options: Options(headers: {"Authorization": "Bearer $token", "content-type": "application/json"}));

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        print("Success");

        print(response.data);
        print("worked");
        getPartyMasterlist("", 1, "desc", "name", false);
        partyMasterList.refresh();
        Get.back();
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      print(e);
    }
  }

  
}
