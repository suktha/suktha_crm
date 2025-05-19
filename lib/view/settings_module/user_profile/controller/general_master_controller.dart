import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_Force/Model/area_model.dart';
import 'package:work_Force/Model/city_model.dart';
import 'package:work_Force/Model/country_master_model.dart';
import 'package:work_Force/Model/state_model.dart';
import 'package:work_Force/utils/Services/rest_api_services.dart';
import 'package:work_Force/utils/check_token_expired.dart';

class GeneralMasterController extends GetxController {
  RxList<CountryMasterModel> country_master_items = <CountryMasterModel>[].obs;
  RxList<StateModel> state_master_items = <StateModel>[].obs;

  RxList<CityModel> city_master_items = <CityModel>[].obs;
  RxList<AreaModel> area_master_items = <AreaModel>[].obs;

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

    getCountryDetails("");
    getAreaMasterDetails("");
    getCityMasterDetails("");
    getStateDetails("");
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
}
