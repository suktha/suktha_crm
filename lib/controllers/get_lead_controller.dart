// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suktha_crm/Model/Document_wallet_model.dart';
import 'package:suktha_crm/Model/financial_year_all_model.dart';
import 'package:suktha_crm/Model/financial_year_model.dart';
import 'package:suktha_crm/Model/lead_history_model.dart';
import 'package:suktha_crm/Model/lead_model.dart';
import 'package:suktha_crm/Model/login_model.dart';
import 'package:suktha_crm/Model/material_models.dart';
import 'package:suktha_crm/Model/missed_followUp_model.dart';
import 'package:suktha_crm/Model/shared_doc_model.dart';
import 'package:suktha_crm/Model/status_model.dart';
import 'package:suktha_crm/utils/Services/rest_api_services.dart';
import 'package:suktha_crm/utils/api/common_api.dart';
import 'package:suktha_crm/utils/check_token_expired.dart';
import 'package:suktha_crm/view/widget/snackbar.dart';

import '../Model/user_model.dart';

class GetLeadController extends GetxController {
  TextEditingController searchController = TextEditingController();

  RxBool loading = false.obs;
  RxBool isPageLoading = false.obs;
  RxBool hasMore = true.obs;
  RxBool listLoad = false.obs;
  RxBool isSelectedNew = false.obs;
  RxBool isSelectedConverted = false.obs;
  RxBool isSelectedNotConverted = false.obs;
  RxBool isSelectedFollowUpDate = false.obs;
  List isStatusSelected = <bool>[].obs;
  var selectedIndex = (-1).obs;

  RxString selectedStatusId = "0".obs;
  RxString currentMonth = "".obs;
  RxString TodayDate = "".obs;
  RxString TodayDateNumber = "".obs;
  RxString searchValue = "".obs;

  var selectedMulitStatuses = <int>[].obs;
  // var status = <int>[].obs;

  RxBool isHaveLocation = false.obs;

  RxBool isToday = false.obs;
  RxBool isSelected = false.obs;
  TextEditingController followUpDateController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    fetchAllData();
    generateDateList();
    todayDate();
    fetchDataForDate(selectedDate.value);
    tomorrowDate();
    yesterdayDate();
    lastWeekDates();
    NextWeekDates();
    thisWeekDates();
    lastMonthDates();
    thisMonthDates();
  }

  Future<void> fetchAllData() async {
    print("fetchAllData called");
    try {
      isPageLoading(true);
      // Parallel API calls
      await Future.wait([
        getStatusById(),
        getFinancialYearList(),
        getMaterialsList(),
        getUserList(),
        getNewCount(),
        getConvretedCount(),
        getNotConvertedCount(),
        getFollowUpRequiredCount(),
        getMissedFollowUp(),
        getInterestedCount(),
      ]);
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Failed to load data');
    } finally {
      isPageLoading(false);
    }
  }

  DateTime yesterday = DateTime.now().add(Duration(days: -1));
  RxString yesterdayFormatted = "".obs;
  RxString yesterdaydate = "".obs;

  yesterdayDate() {
    yesterdayFormatted.value = DateFormat('dd MMMM yyyy').format(yesterday);
    yesterdaydate.value = DateFormat('dd/MM/yyyy').format(yesterday);

    print("yesterday's date: ${yesterdayFormatted.value}");
    print("yesterday's date: ${yesterdaydate}");
  }

  // date Tomorrow
  DateTime tomorrow = DateTime.now().add(Duration(days: 1));
  RxString tomorrowFormatted = "".obs;
  RxString tomorrowdate = "".obs;

  tomorrowDate() {
    tomorrowFormatted.value = DateFormat('dd MMMM yyyy').format(tomorrow);
    tomorrowdate.value = DateFormat('dd/MM/yyyy').format(tomorrow);

    print("Tomorrow's date: ${tomorrowFormatted.value}");
    print("Tomorrow's date: ${tomorrowdate}");
  }

  todayDate() {
    TodayDate.value = DateFormat('dd MMMM yyyy').format(DateTime.now());
    TodayDateNumber.value = DateFormat('dd/MM/yyyy').format(DateTime.now());
    currentMonth.value = TodayDate.value;
  }

  //Last Week

  RxString lastWeekStartFormatted = "".obs;
  RxString lastWeekEndFormatted = "".obs;

  RxString lastWeekStartDate = "".obs;
  RxString lastWeekEndDate = "".obs;

  lastWeekDates() {
    DateTime today = DateTime.now();
    int currentWeekday = today.weekday; // Monday is 1, Sunday is 7

    // Calculate last week's Monday (first day)
    DateTime lastWeekStart = today.subtract(Duration(days: currentWeekday + 6));

    // Calculate last week's Sunday (last day)
    DateTime lastWeekEnd = lastWeekStart.add(Duration(days: 6));

    lastWeekStartFormatted.value = DateFormat('dd MMMM yyyy').format(lastWeekStart);
    lastWeekEndFormatted.value = DateFormat('dd MMMM yyyy').format(lastWeekEnd);
    lastWeekStartDate.value = DateFormat('dd/MM/yyyy').format(lastWeekStart);
    lastWeekEndDate.value = DateFormat('dd/MM/yyyy').format(lastWeekEnd);

    print("Last week's start date: $lastWeekStartFormatted");
    print("Last week's end date: $lastWeekEndFormatted");
  }

  RxString nextWeekStartFormatted = "".obs;
  RxString nextWeekEndFormatted = "".obs;
  RxString nextWeekStartDate = "".obs;
  RxString nextWeekEndDate = "".obs;

  NextWeekDates() {
    DateTime today = DateTime.now();
    int currentWeekday = today.weekday; // Monday is 1, Sunday is 7

// Calculate next week's Monday (first day)
    DateTime nextWeekStart = today.add(Duration(days: (8 - currentWeekday)));

// Calculate next week's Sunday (last day)
    DateTime nextWeekEnd = nextWeekStart.add(Duration(days: 6));

    nextWeekStartFormatted.value = DateFormat('dd MMMM yyyy').format(nextWeekStart);
    nextWeekEndFormatted.value = DateFormat('dd MMMM yyyy').format(nextWeekEnd);
    nextWeekStartDate.value = DateFormat('dd/MM/yyyy').format(nextWeekStart);
    nextWeekEndDate.value = DateFormat('dd/MM/yyyy').format(nextWeekEnd);

    print("Next week's start date: $nextWeekStartFormatted");
    print("Next week's end date: $nextWeekEndFormatted");
  }

  RxString thisWeekStartFormatted = "".obs;
  RxString thisWeekEndFormatted = "".obs;
  RxString thisWeekStartDate = "".obs;
  RxString thisWeekEndDate = "".obs;

  thisWeekDates() {
    DateTime today = DateTime.now();
    int currentWeekday = today.weekday; // Monday is 1, Sunday is 7

    // This week's Monday (first day)
    DateTime thisWeekStart = today.subtract(Duration(days: currentWeekday - 1));
    // This week's Sunday (last day)
    DateTime thisWeekEnd = thisWeekStart.add(Duration(days: 6));

    thisWeekStartFormatted.value = DateFormat('dd MMMM yyyy').format(thisWeekStart);
    thisWeekEndFormatted.value = DateFormat('dd MMMM yyyy').format(thisWeekEnd);
    thisWeekStartDate.value = DateFormat('dd/MM/yyyy').format(thisWeekStart);
    thisWeekEndDate.value = DateFormat('dd/MM/yyyy').format(thisWeekEnd);

    print("This week's start date: $thisWeekStartFormatted");
    print("This week's end date: $thisWeekEndFormatted");
  }

  RxString lastMonthStartFormatted = "".obs;
  RxString lastMonthEndFormatted = "".obs;
  RxString lastMonthStartDate = "".obs;
  RxString lastMonthEndDate = "".obs;

  void lastMonthDates() {
    DateTime today = DateTime.now();

    // Last month's first day
    DateTime lastMonthStart = DateTime(today.year, today.month - 1, 1);
    // Last month's last day
    DateTime lastMonthEnd = DateTime(today.year, today.month, 0);

    lastMonthStartFormatted.value = DateFormat('dd MMMM yyyy').format(lastMonthStart);
    lastMonthEndFormatted.value = DateFormat('dd MMMM yyyy').format(lastMonthEnd);
    lastMonthStartDate.value = DateFormat('dd/MM/yyyy').format(lastMonthStart);
    lastMonthEndDate.value = DateFormat('dd/MM/yyyy').format(lastMonthEnd);

    print("Last month's start date: $lastMonthStartFormatted");
    print("Last month's end date: $lastMonthEndFormatted");
  }

  RxString thisMonthStartFormatted = "".obs;
  RxString thisMonthEndFormatted = "".obs;
  RxString thisMonthStartDate = "".obs;
  RxString thisMonthEndDate = "".obs;

  void thisMonthDates() {
    DateTime today = DateTime.now();

    // This month's first day
    DateTime thisMonthStart = DateTime(today.year, today.month, 1);
    // This month's last day
    DateTime thisMonthEnd = DateTime(today.year, today.month + 1, 0);

    thisMonthStartFormatted.value = DateFormat('dd MMMM yyyy').format(thisMonthStart);
    thisMonthEndFormatted.value = DateFormat('dd MMMM yyyy').format(thisMonthEnd);
    thisMonthStartDate.value = DateFormat('dd/MM/yyyy').format(thisMonthStart);
    thisMonthEndDate.value = DateFormat('dd/MM/yyyy').format(thisMonthEnd);

    print("This month's start date: $thisMonthStartFormatted");
    print("This month's end date: $thisMonthEndFormatted");
  }

  var selectedDate = DateTime.now().obs;
  var dateList = <DateTime>[].obs;
  var dataForSelectedDate = ''.obs; // Replace with your data type
  DateTime today = DateTime.now();

  void generateDateList() {
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    dateList.clear();
    for (int i = 0; i <= lastDayOfMonth.day - 1; i++) {
      dateList.add(firstDayOfMonth.add(Duration(days: i)));
    }
  }

  ScrollController scrollController = ScrollController();

  void scrollToToday() {
    int todayIndex = dateList.indexWhere((date) => date.year == today.year && date.month == today.month && date.day == today.day);

    if (todayIndex != -1) {
      scrollController.animateTo(
        todayIndex * 60.0, // Assumes each date box is 60px wide + margin (8px)
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void fetchDataForDate(DateTime date) {
    // Fetch data based on the selected date (replace with your API or logic)
    dataForSelectedDate.value = DateFormat('dd/MM/yyyy').format(date);
  }

  void onDateSelected(DateTime date) {
    selectedDate.value = date;
    fetchDataForDate(date);
  }

  void onStatusCheckboxChanged(int index, bool value) {
    if (selectedIndex.value != -1) {
      isStatusSelected[selectedIndex.value] = false;
    }

    // Select the new index
    isStatusSelected[index] = true;
    selectedIndex.value = index;
  }

  RxString selectedRadio = "".obs;

  void onRadioSelected(String value) {
    selectedRadio.value = value;
  }

  RxBool sortDirection = true.obs;
  RxBool isSelectedToday = true.obs;
  RxBool isSelectedTomorrow = false.obs;
  RxBool isSelectedyesterday = false.obs;
  RxBool isSelectedThisWeek = false.obs;
  RxBool isSelectedThisMonth = false.obs;
  RxBool isSelectedLastMonth = false.obs;

  RxBool isSelectedLastWeek = false.obs;
  RxBool isSelectedNextWeek = false.obs;
  RxBool isSelectedCustom = false.obs;
  RxString selectedFilters = "Today".obs;
  RxString sortdirection = "desc".obs;
  RxString sortwith = "leadGenerationDate".obs;
  RxString filter = "".obs;
  RxBool isFilter = false.obs;
  RxBool isDocUploaded = false.obs;
  RxList<bool> isSelectedDocuments = List.generate(5, (index) => false).obs;

  int get selectedItemCount => isSelectedDocuments.where((selected) => selected).length;

  RxList<DocumentWalletModel> documentWalletList = <DocumentWalletModel>[].obs;
  RxList<MissedFollowUpModel> missedFollowUpList = <MissedFollowUpModel>[].obs;

  var multiSelectMode = false.obs;

  void containerOnpressed() {
    sortDirection.value = !sortDirection.value;
  }

  RxList<StatusModel> statusList = <StatusModel>[].obs;

  Future getStatusById() async {
    //35 is the transationtype id of the lead management
    List<dynamic> responseValue = await apiCallService(statusByIdUrl + "/35", 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
    List<StatusModel> status = (responseValue).map((e) => StatusModel.fromJson(e)).toList();
    statusList.value = status.toList();
    // selectedMulitStatuses.value = statusList.map((status) => status.id!).toList();

    statusList.refresh();
  }

  RxList<FinancialYearAllModel> financialYearList = <FinancialYearAllModel>[].obs;

  RxString financialYearId = "".obs;
  RxString financialYear = "".obs;

  Future getFinancialYearList() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    print("token ---- $token");

    final financialYearDetailDEcoded = json.decode(sharedPreferences.getString('financialYear')!);
    final financialYear = FinancialYearModel.fromJson(financialYearDetailDEcoded);
    Dio dio = Dio();

    var apiData = (baseUrl + "/financial-years-all");

    print(apiData);

    try {
      print(11111111);

      final response = await dio.get(apiData, options: Options(headers: {"Authorization": "Bearer $token"}));

      print(response.statusCode);

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);

        List<FinancialYearAllModel> result = (response.data as List).map((e) => FinancialYearAllModel.fromJson(e)).toList();
        financialYearId.value = financialYear.id.toString();
        print("finan id  -------------- ${financialYearId}");
        financialYearList.value = result;
        financialYearList.refresh();
        // print("-----------------------------------" + financialYearList.string);

        // print(response.data);
      }
      return financialYearList;
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return financialYearList;
  }

  RxList<LeadModel> leadList = <LeadModel>[].obs;
  RxList<LeadModel> filteredLeadList = <LeadModel>[].obs;
  RxInt totalLeadAmt = 0.obs;

  RxInt totalLeadCount = 0.obs;
  RxInt totalNewLeadsCount = 0.obs;
  RxInt convertedCount = 0.obs;
  RxInt interestedCount = 0.obs;
  RxInt notConvertedCount = 0.obs;
  RxInt followUpRequiredCount = 0.obs;
  RxInt missedFollowUpCount = 0.obs;

  RxInt nextFollowUpCount = 0.obs;
  RxList<LeadModel> followUpdatasleadList = <LeadModel>[].obs;

  getFollowUpList() async {
    print("inside--------------");
    await getStatusById();

    var apiData = "/lead-gen/recent/35/0/176,177,178,179,180/leadGenerationDate/desc/1/5?searchText=";
    try {
      Map<String, dynamic>? result = await apiCallService(apiData, 'GET', {}, TheResponseType.map, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
      List<dynamic> header = (result!["leadGenerations"]);
      List<LeadModel> newLeadList = header.map((header) => LeadModel.fromJson(header)).toList();
      followUpdatasleadList.addAll(newLeadList);

      followUpdatasleadList.refresh();
      print("folloup required-data--${followUpdatasleadList}");
    } catch (e) {
      print("erooorrr--$e");
    }
  }

  Future getFollowUpRequiredCount() async {
    var apiData = "/lead-gen/recent/35/0/179/1000/leadGenerationDate/desc/1/5?searchText=";
    try {
      Map<String, dynamic> result = await apiCallService(apiData, 'GET', {}, TheResponseType.map, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
      followUpRequiredCount.value = result["totalCount"];
      print("folloup required---${followUpRequiredCount.value}");
    } catch (e) {
      print("erooorrr--$e");
    }
  }

  Future getMissedFollowUp() async {
    var apiData = "/getLeadFollowUpMissed/1000";
    try {
      List<dynamic> response = await apiCallService(apiData, 'GET', {}, TheResponseType.map, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
      List<MissedFollowUpModel> result = response
          .map(
            (e) => MissedFollowUpModel.fromJson(e),
          )
          .toList();

      missedFollowUpCount.value = result.length;
      missedFollowUpList.value = result;
      print("MissedFollowUpModel---${missedFollowUpCount.value}");
    } catch (e) {
      print("erooorrr--$e");
    }
  }

  Future getNewCount() async {
    var apiData = "/lead-gen/recent/35/0/176/1000/leadGenerationDate/desc/1/5?searchText=";
    try {
      Map<String, dynamic>? result = await apiCallService(apiData, 'GET', {}, TheResponseType.map, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
      totalNewLeadsCount.value = result!["totalCount"];
      print("new status count---${totalNewLeadsCount.value}");
    } catch (e) {
      print("erooorrr--$e");
    }
  }

  Future getNotConvertedCount() async {
    var apiData = "/lead-gen/recent/35/0/178/1000/leadGenerationDate/desc/1/5?searchText=";
    try {
      Map<String, dynamic>? result = await apiCallService(apiData, 'GET', {}, TheResponseType.map, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
      notConvertedCount.value = result!["totalCount"];
      print("Notconverted status count---${notConvertedCount.value}");
    } catch (e) {
      print("erooorrr--$e");
    }
  }

  Future getConvretedCount() async {
    var apiData = "/lead-gen/recent/35/0/177/1000/leadGenerationDate/desc/1/5?searchText=";
    try {
      Map<String, dynamic>? result = await apiCallService(apiData, 'GET', {}, TheResponseType.map, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
      convertedCount.value = result!["totalCount"];
      print("new status count---${convertedCount.value}");
    } catch (e) {
      print("erooorrr--$e");
    }
  }

  Future getInterestedCount() async {
    var apiData = "/lead-gen/recent/35/0/180/1000/leadGenerationDate/desc/1/5?searchText=";
    try {
      Map<String, dynamic>? result = await apiCallService(apiData, 'GET', {}, TheResponseType.map, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
      interestedCount.value = result!["totalCount"];
      print("new status count---${interestedCount.value}");
    } catch (e) {
      print("erooorrr--$e");
    }
  }

  RxBool fromPreSalesScreen = false.obs;
  RxBool StatusfromPreSalesScreen = false.obs;
  RxString selectedStatus = "".obs;
  RxBool isCalledGetAllLeads = false.obs;

  getAllLead() async {
    try {
      var apiData = "/leadGeneration";
      Map<String, dynamic>? result = await apiCallService(apiData, 'GET', {}, TheResponseType.map, {}, false); //--url, Method, body, responsetype, query parameter, isAuth

      List<dynamic> headers = result!['leadGenerations'];
      totalLeadCount.value = result["totalCount"];
      print("total count----- $totalLeadCount");
      listLoad.value = false;
      hasMore.value = true;

      List<LeadModel> newLeadList = headers.map((header) => LeadModel.fromJson(header)).toList();

      leadList.addAll(newLeadList);

      loading.value = true;

      leadList.refresh();
    } catch (e) {}
  }

  Future<List<LeadModel>> getLeadList(
    String string,
    int page,
    String sortDirection,
    String sortWith,
    String filter,
    bool isFilter,
    String finYearId,
    String statusId,
    String id,
  ) async {
    final limit = fromPreSalesScreen.value == true ? 100 : 5;

    //25 - type id
    print("Search---filterrr---$string");

    await getStatusById();

    var status = isFilter ? selectedMulitStatuses.join(',') : statusList.map((status) => status.id!).toList().join(',');

    if (selectedStatus.value != "") {
      print("selected status name -- ${selectedStatus.value}");
      status = statusList
          .firstWhere(
            (element) => element.name == selectedStatus.value,
          )
          .id
          .toString();
      print("selected status --${status}");
    }

    StatusfromPreSalesScreen.value == true ? status = "176" : status;
    var apiData = isCalledGetAllLeads.value == true ? "/leadGeneration" : "/lead-gen/recent/35/$finYearId/$status/1000/$sortWith/$sortDirection/$page/$limit?searchText=$string";
    print("apidata --$apiData");
    try {
      if (isCalledGetAllLeads.value == true) {
        List<dynamic> result = await apiCallService(apiData, 'GET', {}, TheResponseType.map, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
        // List<dynamic> headers = result!['leadGenerations'];
        List<LeadModel> newLeadList = result.map((header) => LeadModel.fromJson(header)).toList();

        leadList.value = newLeadList
            .where(
              (element) => element.id == id,
            )
            .toList();
      } else {
        Map<String, dynamic>? result = await apiCallService(apiData, 'GET', {}, TheResponseType.map, {}, false); //--url, Method, body, responsetype, query parameter, isAuth

        page == 1 ? leadList.clear() : null;
        page++;
        loading.value = true;
        List<dynamic> headers = result!['leadGenerations'];
        totalLeadCount.value = result["totalCount"];
        print("total count----- $totalLeadCount");
        listLoad.value = false;
        hasMore.value = true;

        List<LeadModel> newLeadList = headers.map((header) => LeadModel.fromJson(header)).toList();

        if (headers.length < limit) {
          hasMore.value = false;
          print('limit fulll');
        }
        leadList.addAll(newLeadList);

        loading.value = true;

        leadList.refresh();
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {
      isPageLoading.value = false;

      print("ispage loading value -- ${isPageLoading.value}");
    }

    return leadList;
  }

  RxList<MaterialModel> materialLists = <MaterialModel>[].obs;
  RxList<MaterialModel> serviceLists = <MaterialModel>[].obs;
  RxList<LeadHistoryModel> LeadHistoryLists = <LeadHistoryModel>[].obs;

  deleteLead(String id) async {
    try {
      Map<String, dynamic> response = await apiCallService("/leadGen-delete/$id", "DELETE", {}, TheResponseType.map, {}, false);
      print("response ---- delete trans num---$response");
      Get.back();
      if (response["responseStatus"] == 1) {
        customSnackbar("Success", "Successfully Deleted", "success");
      } else {
        customSnackbar("Error", "Lead is been used you can/'t delete!!", "error");
      }
      await getLeadList("", 1, "desc", "leadGenerationDate", "", false, "0", "0", "");
    } catch (e) {
      print("ERRORRR --- NUM DELETE -- $e");
    }
  }

  Future getMaterialsList() async {
    try {
      List<dynamic> materialList = await apiCallService(materialNameUrl, 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth

      List<MaterialModel> materialListvalue = (materialList).map((e) => MaterialModel.fromJson(e)).toList();

      materialLists.clear();

      for (var i = 0; i < materialListvalue.length; i++) {
        if (materialListvalue[i].supplyTypeId == 1) {
          materialLists.add(materialListvalue[i]);
          materialLists.refresh();
        } else {
          serviceLists.add(materialListvalue[i]);
          serviceLists.refresh();
        }
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      log('Error: $e');
    } finally {}
  }

  getLeadHistory(String leadId) async {
    try {
      List<dynamic> response = await apiCallService("/leadHistory/$leadId", "GET", {}, TheResponseType.list, {}, false);
      List<LeadHistoryModel> HistoryList = response
          .map(
            (e) => LeadHistoryModel.fromJson(e),
          )
          .toList();
      LeadHistoryLists.value = HistoryList;
      LeadHistoryLists.refresh();
    } catch (e) {}
  }

  RxList<UserModel> userList = <UserModel>[].obs;
  Future getUserList() async {
    List<dynamic> responseValue = await apiCallService("/users", 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
    List<UserModel> user = (responseValue).map((e) => UserModel.fromJson(e)).toList();

    userList.value = user;
    userList.refresh();

    return userList;
  }

  /////-------------------Upload documetns ----------------------------------------------------------------/////////////////////////
  ///
  ///
  ///
  ///
  ///
  ///

  TextEditingController subjectController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  RxBool isFileAttached = false.obs;
  RxString sharedDocName = "".obs;
  File? sharedDocFile;

  final Map<String, String> fileIcons = {
    'pdf': "assets/Images/pdf.png",
    'png': "assets/Icons/image_icon.png",
    'jpg': "assets/Icons/image_icon.png",
    'jpeg': "assets/Icons/image_icon.png",
    'mp3': "assets/Icons/mp3_icon.png",
    'mp4': "assets/Icons/mp4_icon.png",
    'doc': "assets/Icons/doc_icon.png",
    'docx': "assets/Icons/doc_icon.png",
    'txt': "assets/Icons/txt.png",
    'default': "assets/Icons/unknown_file_icon.png", // Fallback icon
  };

  String getFileIcon(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    return fileIcons[extension] ?? fileIcons['default']!;
  }

  Future<void> uploadDocumentWalletPdf(File file, String id) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // Decode user data from SharedPreferences
    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    // Define the URL
    String url = baseUrl + '/files/handleMultipleFileForLead';

    print("url ---- $url");

    // Prepare parameters and filename
    var fileName = file.path.split('/').last;
    print("Filename: $fileName");

    // Prepare FormData
    FormData formData = FormData.fromMap({
      'Documents': await MultipartFile.fromFile(file.path, filename: fileName, contentType: MediaType('application', 'pdf')),
      "leadId": id,
    });

    Dio dio = Dio();

    print("id ------------ $id");
    print("Token: ${loginDetails.token}");

    try {
      // Send the POST request
      final response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data', "Authorization": "Bearer ${loginDetails.token}"},
        ),
      );

      print(response.data);

      await getDocumentWalletList(leadId: id);
      customSnackbar("Success", "uploaded successfully", "success");

      print("Upload completed.");

      // Check token expiry or handle the response
      await checkTokenExpired(response.statusCode);
      documentWalletList.refresh();

      print("Response: ${response.data}");
    } catch (e) {
      print("Error occurred during upload:");
      print("Error: $e");
    }
  }

  Future<List<DocumentWalletModel>> getDocumentWalletList({required String leadId}) async {
    // isLoading.value = true;
    List<dynamic> responseValue = await apiCallService("/files/multipleFileForLead/$leadId", 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
    List<DocumentWalletModel> documentWallet = (responseValue).map((e) => DocumentWalletModel.fromJson(e)).toList();
    // isLoading.value = false;
    documentWalletList.value = documentWallet;
    isDocUploaded.value = true;
    documentWalletList.refresh();

    return documentWalletList;
  }

  Future<File?> pickFile({required FileType type}) async {
    print(type);
    final result = await FilePicker.platform.pickFiles(type: type, allowedExtensions: type == FileType.custom ? ['pdf'] : null, allowMultiple: false);
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.single;

      final fileSizeInBytes = File(file.path!).lengthSync();
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (fileSizeInMB > 1) {
        customSnackbar("Error", "File size cannot exceed 1MB", "error");
      } else {
        return File(file.path!);
      }
    }

    update();
    return null;

    // final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf'], allowMultiple: false);
    // if (result != null && result.files.isNotEmpty) {
    //   final file = result.files.single;

    //   if (file.extension == 'pdf' || file.extension == 'PDF' || file.extension == 'application/pdf' || file.extension == 'APPLICATION/PDF') {
    //     return File(file.path!);
    //     // Selected file is a PDF, proceed with further processing
    //     // Access the file using file.path or file.bytes
    //   } else {
    //     customSnackbar("Selected File is Not pdf", "Please Select a Pdf File", "error");
    //     // Selected file is not a PDF, show an error message or prompt user to select a valid PDF file
    //   }
  }

  deleteDocument(List<String> payload, String id) async {
    String url = "/files-multipleFileDelete";

    print('URL: $url');

    var data = json.encode(payload);
    print('Payload: $data');

    try {
      var response = await apiCallService(url, "POST", data, TheResponseType.map, {}, false);

      print(response);
      await getDocumentWalletList(leadId: id);
    } catch (e) {
      print("error ---- $e");
    }
  }

  RxList<SharedDocHistoryModel> sharedDocHistoryList = <SharedDocHistoryModel>[].obs;

  getSharedDocHistory({required String leadId}) async {
    List<dynamic> responseValue = await apiCallService(sharedDocumentHistoryUrl + "/$leadId", 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
    List<SharedDocHistoryModel> history = (responseValue).map((e) => SharedDocHistoryModel.fromJson(e)).toList();
    sharedDocHistoryList.value = history;
    sharedDocHistoryList.refresh();
  }

  sendLqeadMail({required String leadId}) async {
    Map<String, dynamic>? responseValue =
        await apiCallService(sendMailLeadUrl + "/$leadId" + "/35", 'POST', {}, TheResponseType.map, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
  }

  Future<void> sendLeadMail(File file, String id) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // Decode user data from SharedPreferences
    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    // Define the URL
    String url = baseUrl + '/send-Email-Lead' + '/$id' + '/$id' + '/35';

    print("url ---- $url");

    // Prepare parameters and filename
    var fileName = file.path.split('/').last;
    print("Filename: $fileName");

    // Prepare FormData
    FormData formData = FormData.fromMap({
      'files': await MultipartFile.fromFile(file.path, filename: fileName, contentType: MediaType('application', 'pdf')),
      'id': id,
      "transactionId": id,
      "transactionType": 35,
      "emailSubject": subjectController.text,
      "emailContent": contentController.text,
    });

    Dio dio = Dio();
    print("FormData: ${formData.fields}");
    print("FormData: ${formData.files}");

    print("id ------------ $formData");
    print("Token: ${loginDetails.token}");

    try {
      // Send the POST request
      final response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data', "Authorization": "Bearer ${loginDetails.token}"},
        ),
      );

      print(response.data);

      await getSharedDocHistory(leadId: id);
      customSnackbar("Success", "uploaded successfully", "success");

      print("Upload completed.");

      isFileAttached.value = false;
      sharedDocFile = null;
      subjectController.clear();
      contentController.clear();

      // Check token expiry or handle the response
      await checkTokenExpired(response.statusCode);

      print("Response: ${response.data}");
    } catch (e) {
      print("Error occurred during upload:");
      print("Error: $e");
    }
  }
}
