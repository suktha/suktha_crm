// ignore_for_file: avoid_print, unused_local_variable

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_Force/Model/Industry_Segment_Model.dart';
import 'package:work_Force/Model/area_model.dart';
import 'package:work_Force/Model/bank_model.dart';
import 'package:work_Force/Model/city_model.dart';
import 'package:work_Force/Model/country_master_model.dart';
import 'package:work_Force/Model/customer_classification_model.dart';
import 'package:work_Force/Model/department_model.dart';
import 'package:work_Force/Model/designation_model.dart';
import 'package:work_Force/Model/expense_head.dart';
import 'package:work_Force/Model/state_model.dart';
import 'package:work_Force/utils/Services/rest_api_services.dart';
import 'package:work_Force/utils/check_token_expired.dart';
import 'package:work_Force/view/widget/snackbar.dart';

class GeneralMasterController extends GetxController {
  RxList<IndustrySegmentModel> category_items = <IndustrySegmentModel>[].obs;

  RxList<BankModel> bank_master_items = <BankModel>[].obs;
  RxList<IndustrySegmentModel> industry_segment_items =
      <IndustrySegmentModel>[].obs;
  RxList<IndustrySegmentModel> reason_items = <IndustrySegmentModel>[].obs;

  RxList<CountryMasterModel> country_master_items = <CountryMasterModel>[].obs;
  RxList<StateModel> state_master_items = <StateModel>[].obs;
  RxList<StateModel> foriegn_state_master_items = <StateModel>[].obs;

  RxList<DesignationModel> designation_items = <DesignationModel>[].obs;
  RxList<CityModel> city_master_items = <CityModel>[].obs;
  RxList<DepartmentModel> department_items = <DepartmentModel>[].obs;
  RxList<AreaModel> area_master_items = <AreaModel>[].obs;
  RxList<ExpenseHeadModel> expense_head_items = <ExpenseHeadModel>[].obs;
  RxList<CustomerClassificationModel> customer_class_items =
      <CustomerClassificationModel>[].obs;

  TextEditingController CategoryNameController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController bankAddressController = TextEditingController();
  TextEditingController countryNameController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController designationNameController = TextEditingController();
  TextEditingController departmentNameController = TextEditingController();
  TextEditingController expenseNameController = TextEditingController();
  TextEditingController foreignStateController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController areaNameController = TextEditingController();
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController indusSegNameController = TextEditingController();
  TextEditingController reasonNameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getBankdetails();
    getCountryDetails("");
    getDesignationDetails();
    getDepartmentDetails();
    getExpenseHeadDetails();
    getLeadCategoryDetails();
    getForiegnStateDetails();
    getCityMasterDetails("");
    getStateDetails("");
    getAreaMasterDetails("");
    getReasonDetails();
    getCategoryDetails();
    getIndustrySegmentDetails();
  }

  final searchQuery = ''.obs;
  RxInt cityId = 0.obs;
  RxString cityName = ''.obs;
  RxString stateName = ''.obs;

  void search(String query) {
    searchQuery.value = query;
  }

  List<IndustrySegmentModel> get searchCategoryResult {
    if (searchQuery.isEmpty) {
      return category_items;
    } else {
      return category_items
          .where((item) => item.name!
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  List<IndustrySegmentModel> get searchIndusSegmentResults {
    if (searchQuery.isEmpty) {
      return industry_segment_items;
    } else {
      return industry_segment_items
          .where((item) => item.name!
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  List<IndustrySegmentModel> get searchReasonResults {
    if (searchQuery.isEmpty) {
      return reason_items;
    } else {
      return reason_items
          .where((item) => item.name!
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  List<CountryMasterModel> get searchResults {
    if (searchQuery.isEmpty) {
      return country_master_items;
    } else {
      return country_master_items
          .where((item) => item.name!
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  List<BankModel> get searchResultsBank {
    if (searchQuery.isEmpty) {
      return bank_master_items;
    } else {
      return bank_master_items
          .where((item) => item.bankname!
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  List<StateModel> get searchResultsState {
    if (searchQuery.isEmpty) {
      return state_master_items;
    } else {
      return state_master_items
          .where((item) => item.name!
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  List<StateModel> get searchResultsForeignState {
    if (searchQuery.isEmpty) {
      return foriegn_state_master_items;
    } else {
      return foriegn_state_master_items
          .where((item) =>
              item.name!
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) &&
              item.typeStateId == 2)
          .toList();
    }
  }

  List<DesignationModel> get searchResultDesignstion {
    if (searchQuery.isEmpty) {
      return designation_items;
    } else {
      return designation_items
          .where((item) => item.designationName
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  List<DepartmentModel> get searchResultDepartment {
    if (searchQuery.isEmpty) {
      return department_items;
    } else {
      return department_items
          .where((item) => item.departmentName
              .toString()
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  List<CustomerClassificationModel> get searchResultCustomerClass {
    if (searchQuery.isEmpty) {
      return customer_class_items;
    } else {
      return customer_class_items
          .where((item) => item.name
              .toString()
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  List<ExpenseHeadModel> get searchResultExpenseHead {
    if (searchQuery.isEmpty) {
      return expense_head_items;
    } else {
      return expense_head_items
          .where((item) =>
              item.name.toLowerCase().contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  List<CityModel> get searchResultCityMaster {
    if (searchQuery.isEmpty) {
      return city_master_items;
    } else {
      return city_master_items
          .where((item) => item.name!
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  List<AreaModel> get searchResultAreaMaster {
    if (searchQuery.isEmpty) {
      return area_master_items;
    } else {
      return area_master_items
          .where((item) => item.name!
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  Future<List<CustomerClassificationModel>> getLeadCategoryDetails() async {
    try {
      List<dynamic> result = await apiCallService('/customerClassification',
          'GET', {}, TheResponseType.list, {}, false);
      List<CustomerClassificationModel> values =
          (result).map((e) => CustomerClassificationModel.fromJson(e)).toList();

      customer_class_items.value = values.reversed.toList();
      customer_class_items.refresh();
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return customer_class_items;
  }

  Future<List<IndustrySegmentModel>> getCategoryDetails() async {
    try {
      List<dynamic> result = await apiCallService(
          '/materialCategory', 'GET', {}, TheResponseType.list, {}, false);
      List<IndustrySegmentModel> values =
          (result).map((e) => IndustrySegmentModel.fromJson(e)).toList();

      category_items.value = values.reversed.toList();
      category_items.refresh();
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return category_items;
  }

  Future<List<IndustrySegmentModel>> getIndustrySegmentDetails() async {
    try {
      List<dynamic> result = await apiCallService('/get-all-industrySegment',
          'GET', {}, TheResponseType.list, {}, false);
      List<IndustrySegmentModel> values =
          (result).map((e) => IndustrySegmentModel.fromJson(e)).toList();

      industry_segment_items.value = values.reversed.toList();
      industry_segment_items.refresh();
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return industry_segment_items;
  }

  postIndustrySegmentCategory([bool? isedit, var addedValues]) async {
    if (isedit == true) {
      try {
        List<dynamic> values = await apiCallService("/industrySegments", "POST",
            addedValues, TheResponseType.list, {}, false);
        Get.back();

        customSnackbar(
            'Success', 'Industry segment Edited successfully', 'success');

        indusSegNameController.clear();

        await getIndustrySegmentDetails();
      } catch (e) {
        print("errorr--$e");
      }
    } else {
      IndustrySegmentModel mapDatas = IndustrySegmentModel(
          id: null, name: indusSegNameController.text, deleted: "N");
      industry_segment_items.add(mapDatas);

      var responseBody =
          industry_segment_items.map((element) => element.toJson()).toList();
      print("mapdatas---${responseBody.toString()}");

      try {
        List<dynamic> values = await apiCallService("/industrySegments", "POST",
            responseBody, TheResponseType.list, {}, false);
        Get.back();

        customSnackbar(
            'Success', 'Industry segment added successfully', 'success');

        indusSegNameController.clear();

        await getIndustrySegmentDetails();
      } catch (e) {
        print("errorr--$e");
      }
    }
  }

  Future deleteIndustrySegmentDetails(id) async {
    try {
      Map<String, dynamic> result = await apiCallService(
          '/industrySegment/$id', 'DELETE', {}, TheResponseType.map, {}, false);

      customSnackbar(
          'success',
          result['responseString'],
          result['responseString']
                  .toString()
                  .toLowerCase()
                  .contains('could not execute statement')
              ? 'error'
              : "success");

      await getIndustrySegmentDetails();
    } catch (e) {
      print(e);
    }
  }

  Future<List<IndustrySegmentModel>> getReasonDetails() async {
    try {
      List<dynamic> result = await apiCallService(
          '/get-all-reasons', 'GET', {}, TheResponseType.list, {}, false);
      List<IndustrySegmentModel> values =
          (result).map((e) => IndustrySegmentModel.fromJson(e)).toList();

      reason_items.value = values.reversed.toList();
      reason_items.refresh();
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return reason_items;
  }

  postReason([bool? isedit, var addedValues]) async {
    if (isedit == true) {
      try {
        List<dynamic> values = await apiCallService(
            "/reasons", "POST", addedValues, TheResponseType.list, {}, false);
        Get.back();

        customSnackbar('Success', 'Reason Edited successfully', 'success');

        reasonNameController.clear();

        await getReasonDetails();
      } catch (e) {
        print("errorr--$e");
      }
    } else {
      IndustrySegmentModel mapDatas = IndustrySegmentModel(
          id: null, name: reasonNameController.text, deleted: "N");
      reason_items.add(mapDatas);

      var responseBody =
          reason_items.map((element) => element.toJson()).toList();
      print("mapdatas---${responseBody.toString()}");

      try {
        List<dynamic> values = await apiCallService(
            "/reasons", "POST", responseBody, TheResponseType.list, {}, false);
        Get.back();

        customSnackbar('Success', 'Reason added successfully', 'success');

        reasonNameController.clear();

        await getReasonDetails();
      } catch (e) {
        print("errorr--$e");
      }
    }
  }

  Future deleteReasonDetails(id) async {
    try {
      Map<String, dynamic> result = await apiCallService(
          '/reason/$id', 'DELETE', {}, TheResponseType.map, {}, false);

      customSnackbar(
          'success',
          result['responseString'],
          result['responseString']
                  .toString()
                  .toLowerCase()
                  .contains('could not execute statement')
              ? 'error'
              : "success");

      await getReasonDetails();
    } catch (e) {
      print(e);
    }
  }

  Future deleteLeadCategoryDetails(id) async {
    try {
      Map<String, dynamic> result = await apiCallService(
          '/customerClassification/$id',
          'DELETE',
          {},
          TheResponseType.map,
          {},
          false);

      customSnackbar(
          'success',
          result['responseString'],
          result['responseString']
                  .toString()
                  .toLowerCase()
                  .contains('could not execute statement')
              ? 'error'
              : "success");

      await getLeadCategoryDetails();
    } catch (e) {
      print(e);
    }
  }

  postPartyLeadCategory([bool? isedit, var addedValues]) async {
    if (isedit == true) {
      try {
        List<dynamic> values = await apiCallService("/customerClassifications",
            "POST", addedValues, TheResponseType.list, {}, false);
        Get.back();

        customSnackbar('Success', 'Party/Lead Edited successfully', 'success');

        categoryNameController.clear();

        await getLeadCategoryDetails();
      } catch (e) {
        print("errorr--$e");
      }
    } else {
      CustomerClassificationModel mapDatas = CustomerClassificationModel(
          id: null, name: categoryNameController.text, deleted: "N");
      customer_class_items.add(mapDatas);

      var responseBody =
          customer_class_items.map((element) => element.toJson()).toList();
      print("mapdatas---${responseBody.toString()}");

      try {
        List<dynamic> values = await apiCallService("/customerClassifications",
            "POST", responseBody, TheResponseType.list, {}, false);
        Get.back();

        customSnackbar('Success', 'Party/Lead added successfully', 'success');

        categoryNameController.clear();

        await getLeadCategoryDetails();
      } catch (e) {
        print("errorr--$e");
      }
    }
  }

  Future<List<AreaModel>> getAreaMasterDetails(String value) async {
    try {
      List<dynamic> result = await apiCallService(
          '/area', 'GET', {}, TheResponseType.list, {}, false);
      List<AreaModel> values =
          (result).map((e) => AreaModel.fromJson(e)).toList();

      area_master_items.value = values.reversed.toList();
      area_master_items.refresh();
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return area_master_items;
  }

  Future<List<AreaModel>> postAreaMasterdDetails(int cityid) async {
    AreaModel data = AreaModel(
        id: null, name: areaNameController.text, deleted: null, cityId: cityid);
    try {
      bool isAlreadyHave =
          area_master_items.any((element) => element.name == data.name);
      if (isAlreadyHave == true) {
        customSnackbar('Error', "Area already exist", 'error');
      } else {
        area_master_items.add(data);

        var values =
            area_master_items.map((element) => element.toJson()).toList();

        List<dynamic> result = await apiCallService(
            '/areas', 'POST', values, TheResponseType.list, {}, false);
        Get.back();

        customSnackbar(
            'Success', 'area  details added successfully', 'success');

        areaNameController.clear();
        cityNameController.clear();
        cityId.value = 0;
        cityName.value = "";
      }
      await getAreaMasterDetails("");
    } on DioException catch (e) {
      print(e);
    } finally {}
    return area_master_items;
  }

  Future deleteAreaMasterDetails(id) async {
    try {
      Map<String, dynamic> result = await apiCallService(
          '/area/$id', 'DELETE', {}, TheResponseType.map, {}, false);

      customSnackbar('success', 'deleted successfully',
          result['responseStatus'] == 1 ? 'success' : "error");

      await getAreaMasterDetails("");
    } catch (e) {
      print(e);
    }
  }

  Future<List<AreaModel>> editAreaMasterDetails(
      {required int id, required var delete, required int cityId}) async {
    AreaModel data = AreaModel(
      id: id,
      name: areaNameController.text,
      cityId: cityId,
      deleted: delete,
    );

    print("data-area-$data");

    try {
      area_master_items.add(data);

      var values =
          area_master_items.map((element) => element.toJson()).toList();

      List<dynamic> result = await apiCallService(
          '/areas', 'POST', values, TheResponseType.list, {}, false);

      Get.back();

      customSnackbar('Success', 'Successfully edited', 'success');

      areaNameController.clear();
      cityNameController.clear();
      area_master_items.clear();

      await getAreaMasterDetails("");
    } catch (e) {
      print(e);
    }
    return area_master_items;
  }

  Future<List<CityModel>> getCityMasterDetails(String query) async {
    try {
      List<dynamic> result = await apiCallService(
          '/city', 'GET', {}, TheResponseType.list, {}, false);
      List<CityModel> values =
          (result).map((e) => CityModel.fromJson(e)).toList();

      city_master_items.value = values.reversed.toList();
      city_master_items.refresh();
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return city_master_items;
  }

  Future<List<CityModel>> postCityMasterdDetails(int stateId) async {
    CityModel data = CityModel(
        id: null,
        name: cityNameController.text,
        areas: null,
        stateId: stateId,
        deleted: null);
    try {
      bool isAlreadyHave =
          city_master_items.any((element) => element.name == data.name);
      if (isAlreadyHave == true) {
        customSnackbar('Error', "State already exist", 'error');
      } else {
        city_master_items.add(data);

        var values =
            city_master_items.map((element) => element.toJson()).toList();

        List<dynamic> result = await apiCallService(
            '/cities', 'POST', values, TheResponseType.list, {}, false);
        Get.back();

        customSnackbar(
            'Success', 'foreign state details added successfully', 'success');

        cityNameController.clear();
        foreignStateController.clear();
      }
      await getCityMasterDetails('');
    } on DioException catch (e) {
      print(e);
    } finally {}
    return city_master_items;
  }

  Future deleteCityMasterDetails(id) async {
    try {
      Map<String, dynamic> result = await apiCallService(
          '/city/$id', 'DELETE', {}, TheResponseType.map, {}, false);

      customSnackbar('success', 'deleted successfully',
          result['responseStatus'] == 1 ? 'success' : "error");

      await getCityMasterDetails("");
    } catch (e) {
      print(e);
    }
  }

  Future<List<StateModel>> getForiegnStateDetails() async {
    try {
      List<dynamic> result = await apiCallService(
          '/state', 'GET', {}, TheResponseType.list, {}, false);
      List<StateModel> values =
          (result).map((e) => StateModel.fromJson(e)).toList();
      final filteredList =
          values.where((item) => item.typeStateId == 2).toList();

      foriegn_state_master_items.value = filteredList.reversed.toList();
      foriegn_state_master_items.refresh();
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return foriegn_state_master_items;
  }

  Future<List<StateModel>> postForeignStatedDetails(int countryId) async {
    StateModel data = StateModel(
        id: null,
        name: foreignStateController.text,
        stateCode: '99',
        countryId: countryId,
        deleted: null,
        typeStateId: 2);
    try {
      bool isAlreadyHave = foriegn_state_master_items
          .any((element) => element.name == data.name);
      if (isAlreadyHave == true) {
        customSnackbar('Error', "State already exist", 'error');
      } else {
        foriegn_state_master_items.add(data);

        var values = foriegn_state_master_items
            .map((element) => element.toJson())
            .toList();

        List<dynamic> result = await apiCallService(
            '/allstates', 'POST', values, TheResponseType.list, {}, false);
        Get.back();

        customSnackbar(
            'Success', 'foreign state details added successfully', 'success');

        foreignStateController.clear();
        countryNameController.clear();
      }
      await getForiegnStateDetails();
    } on DioException catch (e) {
      print(e);
    } finally {}
    return foriegn_state_master_items;
  }

  Future deleteForeignStateDetails(id) async {
    try {
      Map<String, dynamic> result = await apiCallService(
          '/state/$id', 'DELETE', {}, TheResponseType.map, {}, false);

      customSnackbar('success', 'deleted successfully',
          result['responseStatus'] == 1 ? 'success' : "error");

      await getForiegnStateDetails();
    } catch (e) {
      print(e);
    }
  }

  Future<List<CityModel>> editCityMasterDetails(
      {required int id, required var delete, required int stateId}) async {
    CityModel data = CityModel(
      id: id,
      name: cityNameController.text,
      stateId: stateId,
      areas: null,
      deleted: delete,
    );

    try {
      city_master_items.add(data);

      var values =
          city_master_items.map((element) => element.toJson()).toList();

      List<dynamic> result = await apiCallService(
          '/cities', 'POST', values, TheResponseType.list, {}, false);

      Get.back();

      customSnackbar('Success', 'Successfully edited', 'success');
      foreignStateController.clear();
      cityNameController.clear();
      city_master_items.clear();

      await getCityMasterDetails('');
    } catch (e) {
      print(e);
    }
    return city_master_items;
  }

  Future<List<StateModel>> getStateDetails(String query) async {
    try {
      List<dynamic> result = await apiCallService(
          '/state', 'GET', {}, TheResponseType.list, {}, false);
      List<StateModel> values =
          (result).map((e) => StateModel.fromJson(e)).toList();

      state_master_items.value = values.reversed.toList();
      state_master_items.refresh();
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return state_master_items;
  }

  Future<List<ExpenseHeadModel>> getExpenseHeadDetails() async {
    try {
      List<dynamic> result = await apiCallService(
          '/expenses', 'GET', {}, TheResponseType.list, {}, false);
      List<ExpenseHeadModel> values =
          (result).map((e) => ExpenseHeadModel.fromJson(e)).toList();

      expense_head_items.value = values.reversed.toList();
      expense_head_items.refresh();
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return expense_head_items;
  }

  Future<List<ExpenseHeadModel>> postExpenseHeadDetails() async {
    ExpenseHeadModel data = ExpenseHeadModel(
      createdBy: null,
      createdDateTime: null,
      updatedBy: null,
      updatedDateTime: null,
      id: null,
      deleted: null,
      name: expenseNameController.text,
    );
    try {
      bool isAlreadyHave =
          expense_head_items.any((element) => element.name == data.name);
      if (isAlreadyHave == true) {
        customSnackbar('Error', "Country already exist", 'error');
      } else {
        expense_head_items.add(data);

        var values =
            expense_head_items.map((element) => element.toJson()).toList();

        List<dynamic> result = await apiCallService(
            '/expenseHeader', 'POST', values, TheResponseType.list, {}, false);
        Get.back();

        customSnackbar(
            'Success', 'Expense details added successfully', 'success');

        expenseNameController.clear();
      }
      await getExpenseHeadDetails();
    } on DioException catch (e) {
      print(e);
    } finally {}
    return expense_head_items;
  }

  Future deleteExpenseHeadDetails(id) async {
    try {
      Map<String, dynamic> result = await apiCallService(
          '/expenseHeader/$id', 'DELETE', {}, TheResponseType.map, {}, false);

      customSnackbar('success', 'deleted successfully',
          result['responseStatus'] == 1 ? 'success' : "error");

      await getExpenseHeadDetails();
    } catch (e) {
      print(e);
    }
  }

  Future<List<ExpenseHeadModel>> editExpenseHeadDetails(
      {required int id, required String delete}) async {
    ExpenseHeadModel data = ExpenseHeadModel(
      id: id,
      name: expenseNameController.text,
      deleted: delete,
      createdDateTime: null,
      createdBy: null,
      updatedDateTime: null,
      updatedBy: null,
    );

    try {
      expense_head_items.add(data);

      var values =
          expense_head_items.map((element) => element.toJson()).toList();

      List<dynamic> result = await apiCallService(
          '/expenseHeader', 'POST', values, TheResponseType.list, {}, false);

      customSnackbar('Success', 'Successfully edited', 'success');

      await getExpenseHeadDetails();
    } catch (e) {
      print(e);
    }
    return expense_head_items;
  }

  Future<List<DepartmentModel>> getDepartmentDetails() async {
    try {
      List<dynamic> result = await apiCallService(
          '/departments', 'GET', {}, TheResponseType.list, {}, false);
      List<DepartmentModel> values =
          (result).map((e) => DepartmentModel.fromJson(e)).toList();

      department_items.value = values.reversed.toList();
      department_items.refresh();
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return department_items;
  }

  Future<List<DepartmentModel>> postDepartmentnDetails() async {
    DepartmentModel data = DepartmentModel(
      id: null,
      deleted: null,
      departmentName: departmentNameController.text,
    );
    try {
      bool isAlreadyHave = department_items
          .any((element) => element.departmentName == data.departmentName);
      if (isAlreadyHave == true) {
        customSnackbar('Error', "Country already exist", 'error');
      } else {
        department_items.add(data);

        var values =
            department_items.map((element) => element.toJson()).toList();

        List<dynamic> result = await apiCallService(
            '/department', 'POST', values, TheResponseType.list, {}, false);
        Get.back();

        customSnackbar(
            'Success', 'Country details added successfully', 'success');

        departmentNameController.clear();
      }
      await getDepartmentDetails();
    } on DioException catch (e) {
      print(e);
    } finally {}
    return department_items;
  }

  Future deleteDepartmentDetails(id) async {
    try {
      Map<String, dynamic> result = await apiCallService(
          '/delete-department/$id',
          'DELETE',
          {},
          TheResponseType.map,
          {},
          false);

      customSnackbar('success', 'deleted successfully',
          result['responseStatus'] == 1 ? 'success' : "error");

      await getDepartmentDetails();
    } catch (e) {
      print(e);
    }
  }

  Future<List<DepartmentModel>> editDepartmentDetails(
      {required int id, required String delete}) async {
    DepartmentModel data = DepartmentModel(
      id: id,
      departmentName: departmentNameController.text,
      deleted: delete,
    );

    try {
      department_items.add(data);

      var values = department_items.map((element) => element.toJson()).toList();

      List<dynamic> result = await apiCallService(
          '/department', 'POST', values, TheResponseType.list, {}, false);

      customSnackbar('Success', 'Successfully edited', 'success');

      await getDepartmentDetails();
    } catch (e) {
      print(e);
    }
    return department_items;
  }

  Future<List<DesignationModel>> getDesignationDetails() async {
    try {
      List<dynamic> result = await apiCallService(
          '/designations', 'GET', {}, TheResponseType.list, {}, false);
      List<DesignationModel> values =
          (result).map((e) => DesignationModel.fromJson(e)).toList();

      designation_items.value = values.reversed.toList();
      designation_items.refresh();
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return designation_items;
  }

  Future<List<DesignationModel>> postDesignationDetails() async {
    DesignationModel data = DesignationModel(
      id: null,
      deleted: null,
      designationName: designationNameController.text,
    );
    try {
      bool isAlreadyHave = designation_items
          .any((element) => element.designationName == data.designationName);
      if (isAlreadyHave == true) {
        customSnackbar('Error', "Country already exist", 'error');
      } else {
        designation_items.add(data);

        var values =
            designation_items.map((element) => element.toJson()).toList();

        List<dynamic> result = await apiCallService(
            '/designation', 'POST', values, TheResponseType.list, {}, false);
        Get.back();

        customSnackbar(
            'Success', 'Country details added successfully', 'success');

        designationNameController.clear();
        // countryNameController.clear();
      }
      await getDesignationDetails();
    } on DioException catch (e) {
      print(e);
    } finally {}
    return designation_items;
  }

  Future deleteDesignationDetails(id) async {
    try {
      Map<String, dynamic> result = await apiCallService(
          '/delete-designation/$id',
          'DELETE',
          {},
          TheResponseType.map,
          {},
          false);

      customSnackbar('success', 'deleted successfully',
          result['responseStatus'] == 1 ? 'success' : "error");

      await getDesignationDetails();
    } catch (e) {
      print(e);
    }
  }

  Future<List<DesignationModel>> editDesignationDetails(
      {required int id, required String delete}) async {
    DesignationModel data = DesignationModel(
      id: id,
      designationName: designationNameController.text,
      deleted: delete,
    );

    try {
      designation_items.add(data);

      var values =
          designation_items.map((element) => element.toJson()).toList();

      List<dynamic> result = await apiCallService(
          '/designation', 'POST', values, TheResponseType.list, {}, false);

      customSnackbar('Success', 'Successfully edited', 'success');

      await getDesignationDetails();
    } catch (e) {
      print(e);
    }
    return designation_items;
  }

  Future<List<CountryMasterModel>> getCountryDetails(String query) async {
    try {
      List<dynamic> result = await apiCallService(
          '/country', 'GET', {}, TheResponseType.list, {}, false);

      List<CountryMasterModel> value =
          (result).map((value) => CountryMasterModel.fromJson(value)).toList();

      country_master_items.value = value.reversed.toList();
      country_master_items.refresh();
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);

      log('Error: $e');
    } finally {}
    return country_master_items;
  }

  Future<List<CountryMasterModel>> postCountryDetails() async {
    CountryMasterModel data = CountryMasterModel(
        id: null,
        name: countryNameController.text,
        deleted: null,
        countryCode: countryCodeController.text);
    try {
      bool isAlreadyHave =
          country_master_items.any((element) => element.name == data.name);
      if (isAlreadyHave == true) {
        customSnackbar('Error', "Country already exist", 'error');
      } else {
        country_master_items.add(data);

        var values =
            country_master_items.map((element) => element.toJson()).toList();

        List<dynamic> result = await apiCallService(
            '/countries', 'POST', values, TheResponseType.list, {}, false);
        Get.back();

        customSnackbar(
            'Success', 'Country details added successfully', 'success');

        countryCodeController.clear();
        countryNameController.clear();
      }
      await getCountryDetails("");
    } on DioException catch (e) {
      print(e);
    } finally {}
    return country_master_items;
  }

  Future deleteCountryDetails(id) async {
    try {
      Map<String, dynamic> result = await apiCallService(
          '/country/$id', 'DELETE', {}, TheResponseType.map, {}, false);

      customSnackbar('success', 'deleted successfully',
          result['responseStatus'] == 1 ? 'success' : "error");

      await getCountryDetails("");
    } catch (e) {
      print(e);
    }
  }

  Future<List<CountryMasterModel>> editCountryDetails(
      {required int id, required String delete}) async {
    CountryMasterModel data = CountryMasterModel(
        id: id,
        name: countryNameController.text,
        deleted: delete,
        countryCode: countryCodeController.text);

    try {
      country_master_items.add(data);

      var values =
          country_master_items.map((element) => element.toJson()).toList();

      List<dynamic> result = await apiCallService(
          '/countries', 'POST', values, TheResponseType.list, {}, false);

      customSnackbar('Success', 'Successfully edited', 'success');

      await getCountryDetails("");
    } catch (e) {
      print(e);
    }
    return country_master_items;
  }

  Future<List<BankModel>> getBankdetails() async {
    print("1223456--");

    try {
      List<dynamic> result = await apiCallService(
          "/banks", 'GET', {}, TheResponseType.list, {}, false);

      List<BankModel> value =
          (result).map((e) => BankModel.fromJson(e)).toList();

      bank_master_items.value = value.reversed.toList();
      bank_master_items.refresh();
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);

      log('Error: $e');
    } finally {}
    return bank_master_items;
  }

  Future deleteBankDetails(id) async {
    try {
      Map<String, dynamic> result = await apiCallService(
          '/bank/$id', 'DELETE', {}, TheResponseType.map, {}, false);

      customSnackbar(result['responseString'], "",
          result['responseStatus'] == 1 ? 'success' : "error");

      await getBankdetails();
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<List<BankModel>> postBankDetails() async {
    BankModel? data = BankModel(
        id: null,
        bankname: bankNameController.text,
        bankAddress: bankAddressController.text,
        deleted: null);
    try {
      bool isAlreadyHave =
          bank_master_items.any((element) => element.bankname == data.bankname);

      bool emptybankadress = bankAddressController.text.isEmpty;
      bool emptybankName = bankNameController.text.isEmpty;

      if (isAlreadyHave == true ||
          emptybankadress == true ||
          emptybankName == true) {
        customSnackbar(
            'Error',
            isAlreadyHave
                ? "Bank name already have"
                : emptybankadress
                    ? "bank address is empty"
                    : "bank name or both is empty",
            'error');
      } else {
        bank_master_items.add(data);

        var valuess =
            bank_master_items.map((element) => element.toJson()).toList();

        List<dynamic> result = await apiCallService(
            '/banks', 'POST', valuess, TheResponseType.list, {}, false);
        Get.back();

        customSnackbar('Success', 'Bank details added successfully', 'success');

        bankAddressController.clear();
        bankNameController.clear();

        await getBankdetails();
      }
    } catch (e) {
      print(" wrongg {$e}");
    }

    return bank_master_items;
  }

  Future<List<BankModel>> editBankDetails(
      {required int id, required String delete}) async {
    BankModel? data = BankModel(
        id: id,
        bankname: bankNameController.text,
        bankAddress: bankAddressController.text,
        deleted: delete);
    try {
      bank_master_items.add(data);

      var valuess =
          bank_master_items.map((element) => element.toJson()).toList();

      List<dynamic> result = await apiCallService(
          '/banks', 'POST', valuess, TheResponseType.list, {}, false);
      customSnackbar('Success', 'Bank details edited successfully', 'success');

      await getBankdetails();
    } catch (e) {
      print(" wrongg {$e}");
    }

    return bank_master_items;
  }

  Future<List<IndustrySegmentModel>> editOrPostCategoryDetails(
      {required dynamic id, required dynamic delete}) async {
    IndustrySegmentModel? data = IndustrySegmentModel(
        id: id, name: CategoryNameController.text, deleted: delete);
    try {
      category_items.add(data);

      var valuess = category_items.map((element) => element.toJson()).toList();

      List<dynamic> result = await apiCallService('/materialCategories', 'POST',
          valuess, TheResponseType.list, {}, false);
      customSnackbar(
          'Success', 'Category details edited successfully', 'success');

      // await getCategoryDetails();
    } catch (e) {
      print("wrongg {$e}");
    }

    return category_items;
  }
}
