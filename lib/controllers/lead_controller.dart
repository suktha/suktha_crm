// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_null_in_if_null_operators

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:suktha_crm/Constants/colors.dart';
import 'package:suktha_crm/Model/Industry_Segment_Model.dart';
import 'package:suktha_crm/Model/Lead_designation_Model.dart';
import 'package:suktha_crm/Model/area_model.dart';
import 'package:suktha_crm/Model/city_model.dart';
import 'package:suktha_crm/Model/customer_model.dart';
import 'package:suktha_crm/Model/financial_year_model.dart';
import 'package:suktha_crm/Model/lead_model.dart';
import 'package:suktha_crm/Model/login_model.dart';
import 'package:suktha_crm/Model/material_models.dart';
import 'package:suktha_crm/Model/name_id_model.dart';
import 'package:suktha_crm/Model/state_model.dart';
import 'package:suktha_crm/Model/status_model.dart';
import 'package:suktha_crm/Model/transaction_number.dart';
import 'package:suktha_crm/Model/transaction_numbering_model.dart';
import 'package:suktha_crm/Model/user_model.dart';
import 'package:suktha_crm/utils/Services/rest_api_services.dart';
import 'package:suktha_crm/utils/Services/sharedpref_services.dart';
import 'package:suktha_crm/utils/api/common_api.dart';
import 'package:suktha_crm/utils/check_token_expired.dart';
import 'package:suktha_crm/utils/Date.dart';
import 'package:suktha_crm/view/screens/pre_sales/card%20reader/MlkitText.dart';
import 'package:suktha_crm/view/screens/pre_sales/card%20reader/RecognitionResponse.dart';
import 'package:suktha_crm/view/screens/pre_sales/card%20reader/card_reader.dart';
import 'package:suktha_crm/view/screens/pre_sales/lead_managment/view_lead_managment/view_lead_management.dart';
import 'package:suktha_crm/view/widget/snackbar.dart';

class LeadController extends GetxController {
  late TextEditingController extractedTextController,
      nameController,
      categoryController,
      designationController,
      companyNameController,
      addressController,
      contactNumberController,
      emailController,
      phoneNumberController,
      leadOwnerController,
      leadDescriptionController,
      websiteController,
      contactPersonController,
      contactNoController,
      mobileNoController,
      intrestedProductController,
      intrestedServiceController,
      sourceController,
      referralNameController,
      priorityController,
      conversionChanceController,
      amountController,
      statusController,
      followUpDateController,
      followUpTimecontroller,
      notConvertedReasonController,
      leadCommentsControler,
      userCommentsController,
      assignController,
      leadGenerationNumController,
      leadDateController,
      areaController,
      cityController,
      stateController,
      leadScoreDetailsController,
      leadScoreController,
      leadsourceDetailsController,
      internalCommentsControler,
      preferredContactTimeController,
      createdDateController,
      whatsappNumController,
      postalCodeController,
      numOfEmployeesControler,
      proposedSolutionControler,
      customerBudgetControler,
      annnualRevenueControler,
      customerPainPointscontroller,
      competitorsController,
      industrySegmentController,
      countryController;

  RxBool isNewcustomer = true.obs;
  RxBool isMoreSelected = false.obs;
  RxBool isInternalAnalysisSelected = false.obs;
  RxBool isContactInfoSelected = false.obs;
  RxBool isAddressInfoSelected = false.obs;
  RxBool isGeneralInfoSelected = true.obs;

  RxBool contactInfoEnable = false.obs;

  // RxString latAndLong = "".obs;

  TextEditingController latAndLong = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getSourceList();
    getReasonConversion();
    getFollowUpTime();
    getDesignation();
    getIndustrySegment();
    getLeadCategory();
    getStatusById();
    getAreaList();
    getCityList();
    getStateList();
    getCountryList();
    getUserList();

    isExtractionCompleted.value = false;
    isStartExtractingText.value = false;

    _recognizer = MLkitTextRecognizer();
    referralNameController = TextEditingController();
    categoryController = TextEditingController();
    numOfEmployeesControler = TextEditingController();
    proposedSolutionControler = TextEditingController();
    customerBudgetControler = TextEditingController();
    annnualRevenueControler = TextEditingController();
    customerPainPointscontroller = TextEditingController();
    competitorsController = TextEditingController();
    whatsappNumController = TextEditingController();
    extractedTextController = TextEditingController();
    phoneNumberController = TextEditingController();
    postalCodeController = TextEditingController();
    leadScoreDetailsController = TextEditingController();
    leadScoreController = TextEditingController();
    internalCommentsControler = TextEditingController();
    preferredContactTimeController = TextEditingController();
    createdDateController = TextEditingController();
    nameController = TextEditingController();
    designationController = TextEditingController();
    companyNameController = TextEditingController();
    addressController = TextEditingController();
    contactNumberController = TextEditingController();
    emailController = TextEditingController();
    websiteController = TextEditingController();
    contactPersonController = TextEditingController();
    contactNoController = TextEditingController();
    mobileNoController = TextEditingController();
    leadsourceDetailsController = TextEditingController();
    intrestedProductController = TextEditingController();
    intrestedServiceController = TextEditingController();
    sourceController = TextEditingController();
    priorityController = TextEditingController();
    notConvertedReasonController = TextEditingController();
    industrySegmentController = TextEditingController();
    conversionChanceController = TextEditingController();
    amountController = TextEditingController();
    statusController = TextEditingController();
    followUpDateController = TextEditingController();
    followUpTimecontroller = TextEditingController();
    leadCommentsControler = TextEditingController();
    userCommentsController = TextEditingController();
    assignController = TextEditingController();
    leadGenerationNumController = TextEditingController();
    leadDateController = TextEditingController();
    areaController = TextEditingController();
    cityController = TextEditingController();
    stateController = TextEditingController();
    countryController = TextEditingController();
    leadOwnerController = TextEditingController();
    leadDescriptionController = TextEditingController();

    initialSetup();

    leadDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.clear();
  }

  IndustrySegmentModel selectedindusSegmentValue = IndustrySegmentModel();
  IndustrySegmentModel selectedCategoryuValue = IndustrySegmentModel();
  IndustrySegmentModel selectedReasonConversionValue = IndustrySegmentModel();
  LeadDesignationModel selectedDesignationValue = LeadDesignationModel();

  StatusModel selectedStatusValue = StatusModel();
  NameIdModel selectedSourceValue = NameIdModel();
  NameIdModel selectedPriorityValue = NameIdModel();
  NameIdModel selectedConversionChanceValue = NameIdModel();
  StateModel selectedCountryValue = StateModel();
  StateModel selectedStateValue = StateModel();
  CityModel selectedCityValue = CityModel();
  AreaModel selectedAreaValue = AreaModel();
  UserModel selectedUserValue = UserModel();
  CustomerModel selectedCustomerValue = CustomerModel();

  RxInt followUpId = 0.obs;
  RxInt preferredContactTimeId = 0.obs;

  RxInt statusId = 0.obs;

  RxList<MaterialModel> selectedMaterialItem = <MaterialModel>[].obs; // Create a list to store selected services
  RxList<MaterialModel> selectedServiceItem = <MaterialModel>[].obs; // Create a list to store selected services

  var numberField;
  List<String> phoneNumbers = [];
  Set<String> nameList = Set();
  Set<String> designationList = Set();
  Set<String> companyNameList = Set();

  RxBool isStartExtractingText = false.obs;
  RxBool isExtractionCompleted = false.obs;
  RxBool isPageLoading = false.obs;
  RxBool quickLeadisSelected = true.obs;

  final ImagePicker _picker = ImagePicker();
  late ITextRecognizer _recognizer;
  RecognitionResponse? _response;

  RxString showSource = "".obs;
  RxString showPriority = "".obs;
  RxString showConversionChange = "".obs;

  RxString materialNames = "".obs;
  RxString serviceNames = "".obs;

  initialSetup() {
    statusController.text = "New";
    selectedStatusValue = StatusModel(id: 176);

    priorityController.text = "High";
    selectedPriorityValue = NameIdModel(id: 1);

    conversionChanceController.text = "Low";
    selectedConversionChanceValue = NameIdModel(id: 1);

    sourceController.text = "Internet";
    selectedSourceValue = NameIdModel(id: 1);
  }

  Future<String?> obtainImage({required ImageSource source}) async {
    final file = await _picker.pickImage(
      source: source,
    );

    if (file != null) {
      var croppedImgae = await _cropImage(File(file.path));
      return croppedImgae;
    }
    return null;
  }

  Future<String> _cropImage(File imageFile) async {
    var croppedImgae = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: CropAspectRatio(ratioX: 85, ratioY: 54), // Credit card aspect ratio
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: kColorwhite,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ]);

    if (croppedImgae!.path.isNotEmpty) {}

    return croppedImgae.path;
  }

  void processImage({required String imgPath}) async {
    final recognizedText = await _recognizer.processImage(imgPath);

    _response = RecognitionResponse(imgPath: imgPath, recognizedText: recognizedText.text);

    log(recognizedText.text);

    phoneNumbers.clear();
    nameList.clear();
    designationList.clear();
    nameController.clear();
    designationController.clear();
    companyNameController.clear();
    addressController.clear();
    contactNumberController.clear();
    emailController.clear();
    websiteController.clear();

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        categorizeAndAssignFields(line.text, block.text);
      }
    }

    if (designationList.isNotEmpty && designationList.length <= 1) {
      designationController.text = designationList.join(', ');
    }
    if (nameList.isNotEmpty && nameList.length <= 1) {
      designationController.text = nameList.join(', ');
    }
  }

  void categorizeAndAssignFields(String textLine, String blockText) {
    final numberRegex = RegExp(r'\b(?:\+?\d{1,3}\s*)?[0-9\- ]{9,}\b');

    final emailRegex = RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b');
    final websiteRegex = RegExp(r'^www\.[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    final addressRegex = RegExp(r'.*,.*');
    final nameRegex = RegExp(r'^(?!.*(?:limited|private|ltd|pvt))[A-Za-z\s]+$', caseSensitive: false);
    final designationRegex = RegExp(r'^(?!.*\b(?:limited|private|ltd|pvt)\b)[&a-zA-Z0-9\- ()]*$', caseSensitive: false);
    RegExp companyNameRegex = RegExp(r'\b(?:limited|private|ltd|pvt)\b', caseSensitive: false);

    if (numberRegex.hasMatch(textLine)) {
      print("number - " + textLine);
      mobileNoController.text = textLine;
    } else if (emailRegex.hasMatch(textLine)) {
      Iterable<RegExpMatch> matches = emailRegex.allMatches(textLine);
      List<String> emails = matches.map((match) => match.group(0)!).toList();

      emailController.text = emails.join(', ');
    } else if (websiteRegex.hasMatch(textLine)) {
      websiteController.text = textLine;
    } else if (addressRegex.hasMatch(blockText)) {
      addressController.text = blockText;
    } else if (nameRegex.hasMatch(textLine)) {
      Iterable<RegExpMatch> matches = nameRegex.allMatches(textLine);
      Set<String> name = matches.map((match) => match.group(0)!).toSet();
      print("name -" + name.toString());

      nameList.addAll(name);
    } else if (designationRegex.hasMatch(textLine)) {
      Iterable<RegExpMatch> matches = designationRegex.allMatches(textLine);
      Set<String> designation = matches.map((match) => match.group(0)!).toSet();

      print("designation -" + designation.toString());
      designationList.addAll(designation);
    } else if (companyNameRegex.hasMatch(textLine)) {
      print("company -" + textLine.toString());

      nameController.text = textLine;
    }
  }

  TransactionNumberModel? transactionNumber;
  TransactionNumberingModel? checkAutoNumOrNot;

  RxInt autoNum = 1.obs;
  checkLeadNumById() async {
    Map<String, dynamic> responseValue =
        await apiCallService("/num-range-config/transactionType/35", 'GET', {}, TheResponseType.map, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
    checkAutoNumOrNot = TransactionNumberingModel.fromJson(responseValue);
    autoNum.value = checkAutoNumOrNot!.autoNumber ?? 0;
    print("auto nummm-----$autoNum");
    await getLeadTransactionNumber();
  }

  getLeadTransactionNumber() async {
    if (autoNum == 0) {
      print("Auto num is null");
    } else {
      Map<String, dynamic> responseValue =
          await apiCallService(transactionNumberUrl + leadGenerationUrl, 'GET', {}, TheResponseType.map, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
      transactionNumber = TransactionNumberModel.fromJson(responseValue);
      leadGenerationNumController.text = transactionNumber!.responseString ?? "";
      print("trans num--lead -${leadGenerationNumController.text}");
    }
  }

  RxList<IndustrySegmentModel> industrySegmentList = <IndustrySegmentModel>[].obs;
  RxList<IndustrySegmentModel> leadCategoryList = <IndustrySegmentModel>[].obs;
  RxList<IndustrySegmentModel> reasonConversionList = <IndustrySegmentModel>[].obs;
  RxList<LeadDesignationModel> leadDesignationList = <LeadDesignationModel>[].obs;

  getDesignation() async {
    List<dynamic> responseValue = await apiCallService("/designations", "GET", {}, TheResponseType.list, {}, false);
    List<LeadDesignationModel> leadDesignation = (responseValue).map((e) => LeadDesignationModel.fromJson(e)).toList();
    leadDesignationList.value = leadDesignation.toList();
    leadDesignationList.refresh();
  }

  getReasonConversion() async {
    List<dynamic> responseValue = await apiCallService("/get-all-reasons", "GET", {}, TheResponseType.list, {}, false);
    List<IndustrySegmentModel> reasonConversion = (responseValue).map((e) => IndustrySegmentModel.fromJson(e)).toList();
    reasonConversionList.value = reasonConversion.toList();
    reasonConversionList.refresh();
  }

  getLeadCategory() async {
    List<dynamic> responseValue = await apiCallService("/customerClassification", "GET", {}, TheResponseType.list, {}, false);
    List<IndustrySegmentModel> leadCategory = (responseValue).map((e) => IndustrySegmentModel.fromJson(e)).toList();
    leadCategoryList.value = leadCategory.toList();
    leadCategoryList.refresh();
  }

  getIndustrySegment() async {
    List<dynamic> responseValue = await apiCallService("/get-all-industrySegment", "GET", {}, TheResponseType.list, {}, false);
    List<IndustrySegmentModel> industrySegment = (responseValue).map((e) => IndustrySegmentModel.fromJson(e)).toList();
    industrySegmentList.value = industrySegment.toList();
    industrySegmentList.refresh();
  }

  RxList<StatusModel> statusList = <StatusModel>[].obs;

  getStatusById() async {
    //35 is the transationtype id of the lead management
    List<dynamic> responseValue = await apiCallService(statusByIdUrl + "/35", 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
    List<StatusModel> status = (responseValue).map((e) => StatusModel.fromJson(e)).toList();
    statusList.value = status.toList();
    statusList.refresh();
  }

  RxList<dynamic> followUpTimeList = <dynamic>[].obs;

  getFollowUpTime() async {
    try {
      List<dynamic> timeList = await apiCallService(followUpTimeUrl, 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth

      followUpTimeList.value = timeList;
      print("follow up details --- ${followUpTimeList.toString()}");
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      log('Error: $e');
    } finally {}
  }

  RxList<MaterialModel> filteredItems = <MaterialModel>[].obs;

  void materialSearchResults({required String query, required List<MaterialModel> materialLists}) {
    // Filter items based on the search query
    filteredItems.assignAll(materialLists.where((item) => item.name!.toLowerCase().contains(query.toLowerCase())).toList());
  }

  void serviceSearchResults({required String query, required List<MaterialModel> serviceLists}) {
    // Filter items based on the search query
    filteredItems.assignAll(serviceLists.where((item) => item.name!.toLowerCase().contains(query.toLowerCase())).toList());
  }

  // RxList<MaterialModel> materialLists = <MaterialModel>[].obs;
  // RxList<MaterialModel> serviceLists = <MaterialModel>[].obs;

  // getMaterialsList() async {
  //   try {
  //     List<dynamic> materialList = await apiCallService(
  //         materialNameUrl, 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth

  //     List<MaterialModel> materialListvalue = (materialList).map((e) => MaterialModel.fromJson(e)).toList();

  //     materialLists.clear();

  //     for (var i = 0; i < materialListvalue.length; i++) {
  //       if (materialListvalue[i].supplyTypeId == 1) {
  //         materialLists.add(materialListvalue[i]);
  //         materialLists.refresh();
  //       } else {
  //         serviceLists.add(materialListvalue[i]);
  //         serviceLists.refresh();
  //       }
  //     }
  //   } on DioException catch (e) {
  //     await checkTokenExpired(e.response!.statusCode);
  //     log('Error: $e');
  //   } finally {}
  // }

  RxList<NameIdModel> sourceList = <NameIdModel>[].obs;
  RxList<NameIdModel> priorityList = <NameIdModel>[].obs;
  RxList<NameIdModel> conversionChanceList = <NameIdModel>[].obs;

  Future<List<NameIdModel>> getSourceList() async {
    try {
      List<dynamic> sourceResult = await apiCallService(sourceUrl, 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth

      List<NameIdModel> sourceValue = (sourceResult).map((e) => NameIdModel.fromJson(e)).toList();
      sourceList.value = sourceValue.reversed.toList();
      sourceList.refresh();

      List<dynamic> priorityResult = await apiCallService(priorityUrl, 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth

      List<NameIdModel> priorityValue = (priorityResult).map((e) => NameIdModel.fromJson(e)).toList();
      priorityList.value = priorityValue.reversed.toList();
      priorityList.refresh();

      List<dynamic> conversionResult = await apiCallService(conversionChanceUrl, 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth

      List<NameIdModel> conversionValue = (conversionResult).map((e) => NameIdModel.fromJson(e)).toList();
      conversionChanceList.value = conversionValue.reversed.toList();
      conversionChanceList.refresh();
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      log('Error: $e');
    } finally {}
    return sourceList;
  }

  RxList<UserModel> userList = <UserModel>[].obs;
  getUserList() async {
    List<dynamic> responseValue = await apiCallService("/users", 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
    List<UserModel> user = (responseValue).map((e) => UserModel.fromJson(e)).toList();

    userList.value = user;
    userList.refresh();

    return userList;
  }

  RxList<AreaModel> areaList = <AreaModel>[].obs;
  RxList<StateModel> stateList = <StateModel>[].obs;
  RxList<CityModel> cityList = <CityModel>[].obs;
  RxList<StateModel> countryList = <StateModel>[].obs;

  getCountryList() async {
    List<dynamic> responseValue = await apiCallService("/country", 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
    List<StateModel> country = (responseValue).map((e) => StateModel.fromJson(e)).toList();

    countryList.value = country;
    countryList.refresh();

    return countryList;
  }

  getStateList() async {
    List<dynamic> responseValue = await apiCallService("/state", 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
    List<StateModel> state = (responseValue).map((e) => StateModel.fromJson(e)).toList();

    stateList.value = state;
    stateList.refresh();

    return stateList;
  }

  getCityList() async {
    List<dynamic> responseValue = await apiCallService("/city", 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
    List<CityModel> city = (responseValue).map((e) => CityModel.fromJson(e)).toList();

    cityList.value = city;
    cityList.refresh();

    return cityList;
  }

  getAreaList() async {
    List<dynamic> responseValue = await apiCallService("/area", 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
    List<AreaModel> area = (responseValue).map((e) => AreaModel.fromJson(e)).toList();

    areaList.value = area;
    areaList.refresh();

    return areaList;
  }

  RxList<CustomerModel> customerList = <CustomerModel>[].obs;

  Future<List<CustomerModel>> getCustomerList(String query) async {
    print("query - inside get customer list - $query");
    List<dynamic> response = await apiCallService(searchPartyUrl + "/ALL?searchText=$query", "GET", {}, TheResponseType.list, {}, false);

    List<CustomerModel> result = (response).map((e) => CustomerModel.fromJson(e)).toList();

    customerList.value = result;
    customerList.refresh();
    // print(customerList);
    return customerList;
  }

  saveLead({required bool isEdit, LeadModel? leadValues, TextEditingController? latLong}) async {
    isPageLoading.value = true;
    var prefs = SharedPreferencesService.instance;

    final logindecoded = json.decode(prefs.getValue('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    final financialYearDetailDEcoded = json.decode(prefs.getValue('financialYear')!);
    final financialYear = FinancialYearModel.fromJson(financialYearDetailDEcoded);

    var leadData = LeadModel(
        address: addressController.text.isNotEmpty ? addressController.text : null,
        amount: amountController.text.isNotEmpty ? double.tryParse(amountController.text) ?? null : null,
        areaId: selectedAreaValue.id,
        assignedToId: selectedUserValue.id,
        cityId: selectedCityValue.id,
        comments: userCommentsController.text.isNotEmpty ? userCommentsController.text : null,
        companyId: loginDetails.user?.company?.id,
        contactPerson: contactPersonController.text.isNotEmpty ? contactPersonController.text : null,
        contactPersonNo: contactNumberController.text.isNotEmpty ? contactNumberController.text : null,
        conversionChanceId: selectedConversionChanceValue.id,
        countryId: selectedCountryValue.id,
        deleted: "N",
        email: emailController.text.isNotEmpty ? emailController.text : null,
        financialYearId: financialYear.id,
        followUpDate: followUpDateController.text.isNotEmpty ? DateClass().parseDate(followUpDateController.text) : null,
        followUpTime: followUpId.value != 0 ? followUpId.value : null,
        id: isEdit ? leadValues!.id : null,
        interestedProductId: selectedMaterialItem.isNotEmpty ? selectedMaterialItem.map<int>((material) => material.id ?? 0).toList() : null,
        isExistingCustomer: isNewcustomer.value ? 0 : 1,
        leadComments: leadCommentsControler.text.isNotEmpty ? leadCommentsControler.text : null,
        leadGenerationDate: leadDateController.text.isNotEmpty ? DateClass().parseDate(leadDateController.text) : null,
        leadGenerationId: isEdit ? leadValues!.leadGenerationId : null,
        leadGenerationNumber: isEdit ? leadValues!.leadGenerationNumber : null,
        leadGenerationType: 35,
        leadName: nameController.text.isNotEmpty ? nameController.text : null,
        mobileNo: mobileNoController.text.isNotEmpty ? mobileNoController.text : null,
        partyId: selectedCustomerValue.id,
        partyName: nameController.text.isNotEmpty ? nameController.text : null,
        priorityId: selectedPriorityValue.id,
        productName: intrestedProductController.text.isNotEmpty ? intrestedProductController.text : null,
        sourceId: selectedSourceValue.id,
        stateId: selectedStateValue.id,
        statusId: selectedStatusValue.id,
        statusName: statusController.text.isNotEmpty ? statusController.text : null,
        userComments: internalCommentsControler.text.isNotEmpty ? internalCommentsControler.text : null,
        annualTurnOver: annnualRevenueControler.text.isNotEmpty ? annnualRevenueControler.text : null,
        leadGeoLocation: latLong?.text.isNotEmpty == true ? latLong!.text : null,
        interestedServiceId: selectedServiceItem.isNotEmpty ? selectedServiceItem.map<int>((material) => material.id ?? 0).toList() : null,
        competitors: competitorsController.text.isNotEmpty ? competitorsController.text : null,
        createdDate: isEdit ? leadValues!.createdDate : (leadDateController.text.isNotEmpty ? DateClass().parseDate(leadDateController.text) : null),
        customerBudget: customerBudgetControler.text.isNotEmpty ? customerBudgetControler.text : null,
        customerPainPoints: customerPainPointscontroller.text.isNotEmpty ? customerPainPointscontroller.text : null,
        designationId: selectedDesignationValue.id,
        industrySegmentId: selectedindusSegmentValue.id,
        leadCategoryId: selectedCategoryuValue.id,
        leadCompanyName: companyNameController.text.isNotEmpty ? companyNameController.text : null,
        leadDescription: leadDescriptionController.text.isNotEmpty ? leadDescriptionController.text : null,
        leadOwnerId: selectedUserValue.id,
        leadScore: leadScoreController.text.isNotEmpty ? int.tryParse(leadScoreController.text) : null,
        leadSourceDetails: leadsourceDetailsController.text.isNotEmpty ? leadsourceDetailsController.text : null,
        numberOfEmployees: numOfEmployeesControler.text.isNotEmpty ? numOfEmployeesControler.text : null,
        pincode: postalCodeController.text.isNotEmpty ? postalCodeController.text : null,
        preferredContactTime: preferredContactTimeId.value != 0 ? preferredContactTimeId.value.toString() : null,
        proposedSolution: proposedSolutionControler.text.isNotEmpty ? proposedSolutionControler.text : null,
        quickLead: quickLeadisSelected.value == true ? 1 : 0,
        reasonId: selectedReasonConversionValue.id,
        referralName: referralNameController.text.isNotEmpty ? referralNameController.text : null,
        userId: loginDetails.user?.id,
        website: websiteController.text.isNotEmpty ? websiteController.text : null,
        whatsappNumber: whatsappNumController.text.isNotEmpty ? whatsappNumController.text : null,
        updatedDate: isEdit ? DateClass().parseDate(DateFormat('dd/MM/yyyy').format(DateTime.now()).toString()) : null);

    String nextFollowUp = followUpDateController.text.isEmpty ? "" : DateClass().parseDate(followUpDateController.text);

    Map<String, dynamic> params = {
      "nextFollowUp": nextFollowUp,
      "userComments": internalCommentsControler.text,
      "leadComments": leadCommentsControler.text,
    };

    log(leadData.toJson().toString());

    try {
      Map<String, dynamic> response = await apiCallService("/saveLeadGen", "POST", leadData.toJson(), TheResponseType.map, params, false); //--url, Method, body, responsetype, query parameter, isAuth

      customSnackbar("Success", "Lead Saved Successfully", "success");

      Get.offAll(LeadManagementListScreen());
    } catch (e) {
      isPageLoading.value = false;
    } finally {
      isPageLoading.value = false;
    }
  }

  UpdateLead({required bool isLeadGenEdit, LeadModel? leadGenValues, LeadModel? leadvalues, String? longitude, String? latitude}) async {
    var prefs = SharedPreferencesService.instance;

    final logindecoded = json.decode(prefs.getValue('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    final financialYearDetailDEcoded = json.decode(prefs.getValue('financialYear')!);
    final financialYear = FinancialYearModel.fromJson(financialYearDetailDEcoded);
    isPageLoading.value = true;

    var locationLatNdLang = "${longitude},${latitude}";

    print("latandlong - $locationLatNdLang");

    var leadData = LeadModel(
      address: addressController.text.isNotEmpty ? addressController.text : null,
      amount: amountController.text.isNotEmpty ? double.tryParse(amountController.text) ?? null : null,
      areaId: selectedAreaValue.id ?? null,
      assignedToId: selectedUserValue.id ?? null,
      cityId: selectedCityValue.id ?? null,
      comments: userCommentsController.text.isNotEmpty ? userCommentsController.text : null,
      companyId: loginDetails.user?.company?.id ?? null,
      contactPerson: contactPersonController.text.isNotEmpty ? contactPersonController.text : null,
      contactPersonNo: contactNumberController.text.isNotEmpty ? contactNumberController.text : null,
      conversionChanceId: selectedConversionChanceValue.id ?? null,
      countryId: selectedCountryValue.id ?? null,
      deleted: "N",
      email: emailController.text.isNotEmpty ? emailController.text : null,
      financialYearId: financialYear.id ?? null,
      followUpDate: leadvalues?.followUpDate == null ? null : DateClass().parseDate(leadvalues!.followUpDate!),
      followUpTime: followUpId.value != 0 ? followUpId.value : null,
      id: isLeadGenEdit == true ? leadGenValues?.id : leadvalues?.id,
      interestedProductId: selectedMaterialItem.isNotEmpty ? selectedMaterialItem.map<int>((material) => material.id!).toList() : null,
      isExistingCustomer: isNewcustomer.value ? 0 : 1,
      leadComments: leadCommentsControler.text.isNotEmpty ? leadCommentsControler.text : null,
      leadGenerationDate: leadDateController.text.isNotEmpty ? DateClass().parseDate(leadDateController.text) : null,
      leadGenerationId: null,
      leadGenerationNumber: isLeadGenEdit == true ? leadGenValues?.leadGenerationNumber : leadvalues?.leadGenerationNumber,
      leadGenerationType: 35,
      leadName: nameController.text.isNotEmpty ? nameController.text : null,
      mobileNo: mobileNoController.text.isNotEmpty ? mobileNoController.text : null,
      partyId: selectedCustomerValue.id ?? null,
      partyName: nameController.text.isNotEmpty ? nameController.text : null,
      priorityId: selectedPriorityValue.id ?? null,
      productName: intrestedProductController.text.isNotEmpty ? intrestedProductController.text : null,
      sourceId: selectedSourceValue.id ?? null,
      stateId: selectedStateValue.id ?? null,
      statusId: selectedStatusValue.id ?? null,
      statusName: statusController.text.isNotEmpty ? statusController.text : null,
      userComments: internalCommentsControler.text.isNotEmpty ? internalCommentsControler.text : null,
      annualTurnOver: annnualRevenueControler.text.isNotEmpty ? annnualRevenueControler.text : null,
      leadGeoLocation: locationLatNdLang.isNotEmpty == true ? locationLatNdLang : null,
      interestedServiceId: selectedServiceItem.isNotEmpty ? selectedServiceItem.map<int>((material) => material.id!).toList() : null,
      competitors: competitorsController.text.isNotEmpty ? competitorsController.text : null,
      createdDate: leadvalues?.createdDate == null ? null : DateClass().parseDate(leadvalues!.createdDate!),
      customerBudget: customerBudgetControler.text.isNotEmpty ? customerBudgetControler.text : null,
      customerPainPoints: customerPainPointscontroller.text.isNotEmpty ? customerPainPointscontroller.text : null,
      designationId: selectedDesignationValue.id ?? null,
      industrySegmentId: selectedindusSegmentValue.id ?? null,
      leadCategoryId: selectedCategoryuValue.id ?? null,
      leadCompanyName: leadvalues?.leadCompanyName == null ? null : leadvalues!.leadCompanyName,
      leadDescription: leadDescriptionController.text.isNotEmpty ? leadDescriptionController.text : null,
      leadOwnerId: selectedUserValue.id ?? null,
      leadScore: leadScoreController.text.isNotEmpty ? int.tryParse(leadScoreController.text) : null,
      leadSourceDetails: leadsourceDetailsController.text.isNotEmpty ? leadsourceDetailsController.text : null,
      numberOfEmployees: numOfEmployeesControler.text.isNotEmpty ? numOfEmployeesControler.text : null,
      pincode: postalCodeController.text.isNotEmpty ? postalCodeController.text : null,
      preferredContactTime: preferredContactTimeId.value != 0 ? preferredContactTimeId.value.toString() : null,
      proposedSolution: proposedSolutionControler.text.isNotEmpty ? proposedSolutionControler.text : null,
      quickLead: quickLeadisSelected.value == true ? 1 : 0,
      reasonId: selectedReasonConversionValue.id ?? null,
      referralName: referralNameController.text.isNotEmpty ? referralNameController.text : null,
      userId: selectedUserValue.id ?? loginDetails.user?.id ?? null,
      website: websiteController.text.isNotEmpty ? websiteController.text : null,
      whatsappNumber: whatsappNumController.text.isNotEmpty ? whatsappNumController.text : null,
      updatedDate: DateClass().parseDate(
        DateFormat('dd/MM/yyyy').format(DateTime.now()).toString(),
      ),
    );

    Map<String, dynamic> params = {
      "nextFollowUp": followUpDateController.text,
      "userComments": internalCommentsControler.text,
      "leadComments": leadCommentsControler.text,
    };

    log(leadData.toJson().toString());

    print("follow date ${leadvalues!.followUpDate == null ? "" : leadvalues.followUpDate}");

    try {
      Map<String, dynamic> response = await apiCallService("/saveLeadGen", "POST", leadData.toJson(), TheResponseType.map, params, false); //--url, Method, body, responsetype, query parameter, isAuth
      print("response---${response.toString()}");
      customSnackbar("Success", "Lead Saved Successfully", "success");

      Get.offAll(LeadManagementListScreen());
    } catch (e) {
      isPageLoading.value = false;
    } finally {
      isPageLoading.value = false;
    }
  }

  getMaterialsList() {}
}
