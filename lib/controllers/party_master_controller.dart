// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_Force/Model/Document_wallet_model.dart';
import 'package:work_Force/Model/advance_receipt_model.dart';
import 'package:work_Force/Model/company_profile_model.dart';
import 'package:work_Force/Model/customer_model.dart';
import 'package:work_Force/Model/dc_model.dart';
import 'package:work_Force/Model/department_model.dart';
import 'package:work_Force/Model/designation_model.dart';
import 'package:work_Force/Model/financial_year_all_model.dart';
import 'package:work_Force/Model/get_cusotmer_receipt_list_model.dart';
import 'package:work_Force/Model/get_po_model.dart';
import 'package:work_Force/Model/get_qoutation_list_model.dart';
import 'package:work_Force/Model/invoice_model.dart';
import 'package:work_Force/Model/material_models.dart';
import 'package:work_Force/Model/material_price_model.dart';
import 'package:work_Force/Model/party_contact_model.dart';
import 'package:work_Force/Model/party_service_details_model.dart';
import 'package:work_Force/Model/transaction_type_model.dart';
import 'package:work_Force/utils/Services/rest_api_services.dart';
import 'package:work_Force/utils/api/common_api.dart';
import 'package:work_Force/utils/api/invoice.dart';
import 'package:work_Force/utils/api/po.dart';
import 'package:work_Force/utils/check_token_expired.dart';
import 'package:work_Force/view/screens/settings_module/Masters/Masters%20Items/Party%20Master/View%20Party%20Master/list_party_master.dart';
import 'package:work_Force/view/screens/settings_module/Masters/Masters%20Items/Party%20Master/View%20Party%20Master/open_party_master.dart';
import 'package:work_Force/view/widget/snackbar.dart';
import '../../../../../../../Model/type_model.dart';
import '../Model/area_model.dart';
import '../Model/bank_model.dart';
import '../Model/city_model.dart';
import '../Model/financial_year_model.dart';
import '../Model/get_party_master_model.dart';
import '../Model/login_model.dart';
import '../Model/materialPriceListModel.dart';
import '../Model/state_model.dart';
import '../Model/transaction_number.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

class PartyMasterController extends GetxController {
  final TextEditingController branchController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController aCController = TextEditingController();
  final TextEditingController openingBalanceController =
      TextEditingController();
  TextEditingController searchController = TextEditingController();

  final TextEditingController materialNumController = TextEditingController();
  final TextEditingController currentSellingPriceController =
      TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();
  final TextEditingController materialTypePriceController =
      TextEditingController();
  final TextEditingController materialNamePriceController =
      TextEditingController();
  final TextEditingController filtercontrollerInvoice = TextEditingController();
  final TextEditingController filtercontrollerQuot = TextEditingController();
  final TextEditingController filtercontrollerReceipt = TextEditingController();
  final TextEditingController filtercontrollerDC = TextEditingController();
  final TextEditingController filtercontrollerPO = TextEditingController();
  final TextEditingController filtercontrollerAdvance = TextEditingController();

  final TextEditingController POTypeController = TextEditingController();
  final TextEditingController receiptTypeController = TextEditingController();
  final TextEditingController dcTypeController = TextEditingController();
  final TextEditingController advanceTypeController = TextEditingController();
  final TextEditingController newTransactionTypeController =
      TextEditingController();

  RxList<DesignationModel> designationList = <DesignationModel>[].obs;

  RxList<DepartmentModel> departmentList = <DepartmentModel>[].obs;

  RxList<TransactionTypeModel> invoicetypeList = <TransactionTypeModel>[].obs;
  RxString selectedtransactiontypeId = "1".obs;

  RxList<TransactionTypeModel> quotationTypeList = <TransactionTypeModel>[].obs;
  RxString quotationtypeId = "12".obs;

  RxList<TransactionTypeModel> poTypeList = <TransactionTypeModel>[].obs;
  RxString potypeId = "11".obs;

  RxList<TransactionTypeModel> receiptTypeList = <TransactionTypeModel>[].obs;
  RxString receiptTypeId = "3".obs;

  RxList<TransactionTypeModel> DCTypeList = <TransactionTypeModel>[].obs;
  RxString dcTypeId = "7".obs;

  RxList<TransactionTypeModel> advanceTypeList = <TransactionTypeModel>[].obs;
  RxString advanceTypeId = "34".obs;

  RxList<TransactionTypeModel> createNewTramsactionList =
      <TransactionTypeModel>[].obs;
  RxString newTranTypeId = "".obs;

  getNewCustomerTransactionItems() {
    print("customer transaction list");
    var ItemList = [
      TransactionTypeModel(id: 1, description: null, name: "Customer Invoice"),
      TransactionTypeModel(id: 15, description: null, name: "Jobwork Invoice"),
      TransactionTypeModel(
          id: 18, description: null, name: "Subcontracting Invoice"),
      TransactionTypeModel(id: 19, description: null, name: "Proforma Invoice"),
      TransactionTypeModel(
          id: 32, description: null, name: "Jobwork Proforma Invoice"),
      TransactionTypeModel(
          id: 33, description: null, name: "Subcontracting Proforma Invoice"),
      TransactionTypeModel(id: 7, description: null, name: "Customer DC"),
      TransactionTypeModel(id: 14, description: null, name: "Jobwork Out DC"),
      TransactionTypeModel(id: 13, description: null, name: "Jobwork In DC"),
      TransactionTypeModel(
          id: 16, description: null, name: "Subcontracting Out DC"),
      TransactionTypeModel(
          id: 17, description: null, name: "Subcontracting In DC"),
      TransactionTypeModel(id: 3, description: null, name: "Customer Receipts"),
      TransactionTypeModel(id: 11, description: null, name: "Customer PO"),
      TransactionTypeModel(id: 20, description: null, name: "Jobwork PO"),
      TransactionTypeModel(
          id: 21, description: null, name: "Subcontracting PO"),
      TransactionTypeModel(id: 22, description: null, name: "Cash Voucher"),
      TransactionTypeModel(id: 23, description: null, name: "Cheque Voucher"),
      TransactionTypeModel(id: 9, description: null, name: "Credit Note"),
      TransactionTypeModel(
          id: 28, description: null, name: "Jobwork Credit Note"),
      TransactionTypeModel(
          id: 29, description: null, name: "Subcontract Debit Note"),
      TransactionTypeModel(
          id: 12, description: null, name: "Customer Quotation"),
      TransactionTypeModel(
          id: 30, description: null, name: "Jobwork Quotation"),
      TransactionTypeModel(
          id: 31, description: null, name: "Subcontracting Quotation"),
    ];
    createNewTramsactionList.assignAll(ItemList);
  }

  getNewSupplierTransactionItems() {
    print("Supplier transaction list");

    var ItemList = [
      TransactionTypeModel(id: 4, description: null, name: "Supplier Payments"),
      TransactionTypeModel(id: 2, description: null, name: "Supplier PO"),
      TransactionTypeModel(id: 5, description: null, name: "Purchase Invoice"),
      TransactionTypeModel(id: 15, description: null, name: "Jobwork Invoice"),
      TransactionTypeModel(
          id: 32, description: null, name: "Jobwork Proforma Invoice"),
      TransactionTypeModel(
          id: 33, description: null, name: "Subcontracting Proforma Invoice"),
      TransactionTypeModel(id: 14, description: null, name: "Jobwork Out DC"),
      TransactionTypeModel(id: 13, description: null, name: "Jobwork In DC"),
      TransactionTypeModel(
          id: 16, description: null, name: "Subcontracting Out DC"),
      TransactionTypeModel(
          id: 17, description: null, name: "Subcontracting In DC"),
      TransactionTypeModel(id: 20, description: null, name: "Jobwork PO"),
      TransactionTypeModel(
          id: 21, description: null, name: "Subcontracting PO"),
      TransactionTypeModel(id: 6, description: null, name: "Incoming DC"),
      TransactionTypeModel(id: 10, description: null, name: "Debit Note"),
      TransactionTypeModel(
          id: 30, description: null, name: "Jobwork Quotation"),
      TransactionTypeModel(
          id: 31, description: null, name: "Subcontracting Quotation"),
    ];
    createNewTramsactionList.assignAll(ItemList);
  }

  getAdvanceItems() {
    var ItemList = [
      TransactionTypeModel(id: 34, description: null, name: "Advance Receipt"),
    ];
    advanceTypeList.assignAll(ItemList);
  }

  getCustomerDCItems() {
    print("dc inside-----------------------------------------eee");
    var ItemList = [
      TransactionTypeModel(id: 7, description: null, name: "Customer DC"),
      TransactionTypeModel(id: 14, description: null, name: "Jobwork Out DC"),
      TransactionTypeModel(id: 13, description: null, name: "Jobwork In DC"),
      TransactionTypeModel(
          id: 16, description: null, name: "Subcontracting Out DC"),
      TransactionTypeModel(
          id: 17, description: null, name: "Subcontracting In DC"),
    ];
    DCTypeList.assignAll(ItemList);
  }

  getSupplierDCItems() {
    print("dc inside-----------------------------------------eee");
    var ItemList = [
      TransactionTypeModel(id: 6, description: null, name: "Incoming DC"),
      TransactionTypeModel(id: 14, description: null, name: "Jobwork Out DC"),
      TransactionTypeModel(id: 13, description: null, name: "Jobwork In DC"),
      TransactionTypeModel(
          id: 16, description: null, name: "Subcontracting Out DC"),
      TransactionTypeModel(
          id: 17, description: null, name: "Subcontracting In DC"),
    ];
    DCTypeList.assignAll(ItemList);
  }

  getCustomerReceiptItems() {
    var ItemList = [
      TransactionTypeModel(id: 3, description: null, name: "Customer Receipts"),
    ];
    receiptTypeList.assignAll(ItemList);
  }

  getSupplierReceiptItems() {
    var ItemList = [
      TransactionTypeModel(id: 4, description: null, name: "Supplier Payments"),
    ];
    receiptTypeList.assignAll(ItemList);
  }

  getCustmerPOItems() {
    var ItemList = [
      TransactionTypeModel(id: 11, description: null, name: "Customer PO"),
      TransactionTypeModel(id: 20, description: null, name: "Jobwork PO"),
      TransactionTypeModel(
          id: 21, description: null, name: "Subcontracting PO"),
    ];
    poTypeList.assignAll(ItemList);
  }

  getSupplierPOItems() {
    var ItemList = [
      TransactionTypeModel(id: 2, description: null, name: "Supplier PO"),
      TransactionTypeModel(id: 20, description: null, name: "Jobwork PO"),
      TransactionTypeModel(
          id: 21, description: null, name: "Subcontracting PO"),
    ];
    poTypeList.assignAll(ItemList);
  }

  getCustomerQuotationItems() {
    var ItemList = [
      TransactionTypeModel(
          id: 12, description: null, name: "Customer Quotation"),
      TransactionTypeModel(
          id: 30, description: null, name: "Jobwork Quotation"),
      TransactionTypeModel(
          id: 31, description: null, name: "Subcontracting Quotation"),
    ];
    quotationTypeList.assignAll(ItemList);
  }

  getSupplierQuotationItems() {
    var ItemList = [
      TransactionTypeModel(
          id: 30, description: null, name: "Jobwork Quotation"),
      TransactionTypeModel(
          id: 31, description: null, name: "Subcontracting Quotation"),
    ];
    quotationTypeList.assignAll(ItemList);
  }

  geCustomertInvoiceItems() {
    var ItemList = [
      TransactionTypeModel(id: 1, description: null, name: "Customer Invoice"),
      TransactionTypeModel(id: 15, description: null, name: "Jobwork Invoice"),
      TransactionTypeModel(
          id: 18, description: null, name: "Subcontracting Invoice"),
      TransactionTypeModel(id: 19, description: null, name: "Proforma Invoice"),
      TransactionTypeModel(
          id: 32, description: null, name: "Jobwork Proforma Invoice"),
      TransactionTypeModel(
          id: 33, description: null, name: "Subcontracting Proforma Invoice"),
    ];
    invoicetypeList.assignAll(ItemList);
  }

  getSupplierInvoiceItems() {
    var ItemList = [
      TransactionTypeModel(id: 5, description: null, name: "Purchase Invoice"),
      TransactionTypeModel(id: 15, description: null, name: "Jobwork Invoice"),
      TransactionTypeModel(
          id: 18, description: null, name: "Subcontracting Invoice"),
      TransactionTypeModel(id: 19, description: null, name: "Proforma Invoice"),
      TransactionTypeModel(
          id: 32, description: null, name: "Jobwork Proforma Invoice"),
      TransactionTypeModel(
          id: 33, description: null, name: "Subcontracting Proforma Invoice"),
    ];
    invoicetypeList.assignAll(ItemList);
  }

  RxString departmentId = "".obs;
  RxString designationId = "".obs;

  String? documentWalletId;

  BankModel? bankValue;
  TransactionTypeModel? transactionType;

  RxString transactionTypeId = "".obs;

  late TextEditingController partyTypeController,
      inputtranscationTypeController,
      partyCodeController,
      partyNameController,
      vendercodeController,
      contactNumberController,
      pincodeController,
      areaController,
      cityController,
      stateController,
      countryController,
      primaryTelephoneController,
      secondaryTelephoneController,
      primaryMobileController,
      secondaryMobileController,
      emailController,
      websiteController,
      contactPersonController,
      billToAddressController,
      shipToAddressLine1Controller,
      shipToAddressLine2Controller,
      paymentDuedaysLimitController,
      currencyController,
      gstRegistrationTypeController,
      gstNumberController,
      panNumberController,
      materialTypeController,
      materialNameController,
      bankNameController,
      transcationTypeController,
      termsNdConditionController,
      NametermsNdConditionController,
      slNoController,
      materialTypeitemController,
      materialNameitemController,
      materialNumberitemController,
      currentSellingPriceitemController,
      sellingPriceitemController,
      designationController,
      invoiceTypeController,
      quotationTypeController,
      departmentController,
      commentsItemController;

  @override
  void onInit() {
    super.onInit();
    getFinancialYearList();
    getAdvanceItems();
    getMaterialNameList("");
    getDepartmentList();
    getDesignationList();

    //

    designationController = TextEditingController();

    quotationTypeController = TextEditingController();
    invoiceTypeController = TextEditingController();

    NametermsNdConditionController = TextEditingController();

    departmentController = TextEditingController();
    transcationTypeController = TextEditingController();

    inputtranscationTypeController = TextEditingController();
    partyTypeController = TextEditingController();
    partyCodeController = TextEditingController();
    partyNameController = TextEditingController();
    vendercodeController = TextEditingController();
    contactNumberController = TextEditingController();
    pincodeController = TextEditingController();
    termsNdConditionController = TextEditingController();

    areaController = TextEditingController();
    cityController = TextEditingController();
    stateController = TextEditingController();
    countryController = TextEditingController();
    primaryTelephoneController = TextEditingController();
    secondaryTelephoneController = TextEditingController();
    primaryMobileController = TextEditingController();
    secondaryMobileController = TextEditingController();
    emailController = TextEditingController();
    websiteController = TextEditingController();
    contactPersonController = TextEditingController();
    billToAddressController = TextEditingController();
    shipToAddressLine1Controller = TextEditingController();
    shipToAddressLine2Controller = TextEditingController();
    paymentDuedaysLimitController = TextEditingController();
    currencyController = TextEditingController();
    gstRegistrationTypeController = TextEditingController();
    gstNumberController = TextEditingController();
    panNumberController = TextEditingController();

    materialTypeController = TextEditingController();
    materialNameController = TextEditingController();

    slNoController = TextEditingController();
    materialTypeitemController = TextEditingController();
    materialNameitemController = TextEditingController();
    materialNumberitemController = TextEditingController();
    currentSellingPriceitemController = TextEditingController();
    sellingPriceitemController = TextEditingController();
    commentsItemController = TextEditingController();

    bankNameController = TextEditingController();
  }

  TextEditingController namecontactListController = TextEditingController();
  TextEditingController emailContactListController = TextEditingController();
  TextEditingController primaryPhoneNumontactListController =
      TextEditingController();
  TextEditingController secPhoneNumontactListController =
      TextEditingController();
  TextEditingController remarkContactController = TextEditingController();

  RxList<TypeModel> partyTypeList = <TypeModel>[].obs;
  RxList<AreaModel> areaList = <AreaModel>[].obs;
  RxList<StateModel> stateList = <StateModel>[].obs;
  RxList<CityModel> cityList = <CityModel>[].obs;
  RxList<StateModel> countryList = <StateModel>[].obs;
  RxList<String> stateName = <String>[].obs;
  RxList<String> CountryName = <String>[].obs;
  RxList<PurchaseOrderItems> currencyList = <PurchaseOrderItems>[].obs;
  RxList<PurchaseOrderItems> gstRegistrationTypeList =
      <PurchaseOrderItems>[].obs;
  RxList<BankModel> bankList = <BankModel>[].obs;
  RxList<TypeModel> materailTypeList = <TypeModel>[].obs;
  RxList<MaterialModel> materialNameList = <MaterialModel>[].obs;

  RxList<MaterialModel> materialNameFilteredList = <MaterialModel>[].obs;

  RxList<MaterialPriceListDTOList> materialPriceItem =
      <MaterialPriceListDTOList>[].obs;
  RxList<PartyContactDetails> contactListItem = <PartyContactDetails>[].obs;

  RxList<PartyBankMapDTOList> materialBankItem = <PartyBankMapDTOList>[].obs;
  RxList<TransactionTypeModel> transcationItem = <TransactionTypeModel>[].obs;
  RxList<TermsAndConditions> termsNdconditionItem = <TermsAndConditions>[].obs;
  RxList<InvoiceModel> invoiceListItems = <InvoiceModel>[].obs;
  RxList<PartyServiceDetailsModel> serviceListItems =
      <PartyServiceDetailsModel>[].obs;

  CustomerModel? partyMasterModelValue;

  TransactionNumberModel? purchaseOrderTransactionNumber;

  MaterialPriceListModel? materialpriceValue;

  Map? mapvalue;

  RxBool supplyType = false.obs;
  RxBool inclusiveTaxIschecked = false.obs;
  RxString taxeS = "".obs;
  RxDouble taxRate = 0.0.obs;
  int? taxid;
  int? gstRegistrationTypeId;
  RxString inclusiveTaxAmount = "".obs;
  RxString inclusiveTaxRate = "".obs;
  RxBool nocustomerFound = false.obs;
  RxBool customerSelected = false.obs;
  RxBool panNumberVisible = false.obs;
  RxBool gstNumberVisible = false.obs;
  RxBool ifAreaSelected = false.obs;
  RxBool ifCitySelected = false.obs;

  RxBool isPageLoading = false.obs;

  RxBool isEmailAvailable = false.obs;
  RxBool isNumberAvailable = false.obs;
  RxBool isGstAvailable = false.obs;

  RxString poParty = "".obs;
  RxString poid = "".obs;
  RxString gstType = "".obs;

  String? currencyVal;
  RxBool isOpenEnded = false.obs;

  RxList<DocumentWalletModel> documentWalletList = <DocumentWalletModel>[].obs;
  RxList<FinancialYearAllModel> financialYearList =
      <FinancialYearAllModel>[].obs;
  RxList<GetQuotationListModel> quotationListItems =
      <GetQuotationListModel>[].obs;
  RxList<GetPOlistModel> poListItems = <GetPOlistModel>[].obs;
  RxList<PayReceiveModel> receiptListItems = <PayReceiveModel>[].obs;
  RxList<DCModel> dcListItems = <DCModel>[].obs;
  RxList<AdvanceReceiptModel> advanceListItems = <AdvanceReceiptModel>[].obs;

  List<dynamic> statusOptions = [
    {'id': -1, 'name': 'All'},
    {'id': 1, 'name': 'Upcoming'},
    {'id': 2, 'name': 'Active'},
    {"id": 3, 'name': 'Expired'}
  ];

  var selectedStatusId = "-1".obs;
  var selectedStatus = "All".obs;

  RxString documentwallertId = "".obs;
  RxString financialYearIdInvoice = "".obs;
  RxString financialYearIdQuot = "".obs;
  RxString financialYearIdPO = "".obs;
  RxString financialYearIdReceipt = "".obs;
  RxString financialYearIdDC = "".obs;
  RxString financialYearIdAdvance = "".obs;

  RxString financialYear = "".obs;
  RxString financialYearId = "".obs;

  RxString planStatus = "".obs;

  RxBool isLoading = false.obs;
  RxBool isDefault = false.obs;

  String getPlanStatus(
      {required DateTime startDate, required DateTime endDate}) {
    if (startDate == null || endDate == null) return "Unknown";

    DateTime currentDate = DateTime.now();

    if (currentDate.isBefore(startDate)) {
      return "Upcoming";
    } else if (currentDate.isAfter(endDate)) {
      return "Expired";
    } else {
      return "Active";
    }
  }

  Map<String, Color> getPlanStatuss(
      {required DateTime startDate, required DateTime endDate}) {
    DateTime currentDate = DateTime.now();

    if (currentDate.isBefore(startDate)) {
      return {"Upcoming": Colors.blue}; // Blue for upcoming
    } else if (currentDate.isAfter(endDate)) {
      return {"Expired": Colors.red}; // Red for expired
    } else {
      return {"Active": Colors.green}; // Green for active
    }
  }

  Future<List<DocumentWalletModel>> getDocumentWalletList(
      documentWalletId) async {
    isLoading.value = true;
    List<dynamic> responseValue = await apiCallService(
        "/files/multipleFile/$documentWalletId",
        'GET',
        {},
        TheResponseType.list,
        {},
        false); //--url, Method, body, responsetype, query parameter, isAuth
    List<DocumentWalletModel> documentWallet =
        (responseValue).map((e) => DocumentWalletModel.fromJson(e)).toList();
    isLoading.value = false;
    documentWalletList.value = documentWallet;
    documentWalletList.refresh();

    return documentWalletList;
  }

  Future getFinancialYearList() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    // print("----3-----${createproformaItem!.partyName}");
    final financialYearDetailDEcoded =
        json.decode(sharedPreferences.getString('financialYear')!);
    final financialYear =
        FinancialYearModel.fromJson(financialYearDetailDEcoded);
    Dio dio = Dio();

    var apiData = ("$baseUrl/financial-years-all");

    print(apiData);

    try {
      print(11111111);

      final response = await dio.get(apiData,
          options: Options(headers: {"Authorization": "Bearer $token"}));

      print(response.statusCode);

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);

        List<FinancialYearAllModel> result = (response.data as List)
            .map((e) => FinancialYearAllModel.fromJson(e))
            .toList();
        financialYearId.value = result
            .firstWhere(
              (element) => element.isActive == 1,
            )
            .id
            .toString();

        print("year id --- ${financialYearId.value}");

        financialYearList.value = result;
        financialYearIdInvoice.value = financialYear.id.toString();
        print("finan id 1 -------------- $financialYearIdInvoice");
        financialYearIdQuot.value = financialYear.id.toString();
        print("finan id 2 -------------- $financialYearIdQuot");
        financialYearIdPO.value = financialYear.id.toString();
        print("finan id 3 -------------- $financialYearIdPO");
        financialYearIdReceipt.value = financialYear.id.toString();
        print("finan id 4 -------------- $financialYearIdReceipt");
        financialYearIdDC.value = financialYear.id.toString();
        print("finan id 5 -------------- $financialYearIdDC");
        financialYearIdAdvance.value = financialYear.id.toString();
        print("finan id  6-------------- $financialYearIdAdvance");
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

  Future<List<AdvanceReceiptModel>> getAdvancesList(
      transactionTypeId, financialyearId, partyId, searchText) async {
    isLoading.value = true;
    Map<String, dynamic> responseValue = await apiCallService(
        "/adv-recpt/recent-party/$transactionTypeId/$financialyearId/$partyId/advanceReceiptDate/desc/1/1000?searchText=$searchText",
        'GET',
        {},
        TheResponseType.map,
        {},
        false); //--url, Method, body, responsetype, query parameter, isAuth
    List<dynamic> data = responseValue['advanceReciepts'];

    List<AdvanceReceiptModel> advanceList =
        data.map((e) => AdvanceReceiptModel.fromJson(e)).toList();
    isLoading.value = false;
    advanceListItems.value = advanceList;
    advanceListItems.refresh();

    return advanceListItems;
  }

  Future<List<DCModel>> getDCsList(
      transactionTypeId, financialyearId, partyId, searchText) async {
    isLoading.value = true;
    Map<String, dynamic> responseValue = await apiCallService(
        "/dc/recent-party/$transactionTypeId/$financialyearId/$partyId/deliveryChallanDate/desc/1/1000?searchText=$searchText",
        'GET',
        {},
        TheResponseType.map,
        {},
        false); //--url, Method, body, responsetype, query parameter, isAuth
    List<dynamic> data = responseValue['deliveryChallanHeaders'];

    List<DCModel> DCList = data.map((e) => DCModel.fromJson(e)).toList();
    isLoading.value = false;
    dcListItems.value = DCList;
    dcListItems.refresh();

    return dcListItems;
  }

  Future<List<PayReceiveModel>> getReceiptsList(
      transactionTypeId, financialyearId, partyId, searchText) async {
    isLoading.value = true;
    Map<String, dynamic> responseValue = await apiCallService(
        "/pay-receive/recent-party/$transactionTypeId/$financialyearId/$partyId/payReferenceDate/desc/1/1000?searchText=$searchText",
        'GET',
        {},
        TheResponseType.map,
        {},
        false); //--url, Method, body, responsetype, query parameter, isAuth
    List<dynamic> data = responseValue['payableReceivableHeaders'];

    List<PayReceiveModel> receiptList =
        data.map((e) => PayReceiveModel.fromJson(e)).toList();
    isLoading.value = false;
    receiptListItems.value = receiptList;
    receiptListItems.refresh();

    return receiptListItems;
  }

  Future<List<GetPOlistModel>> getPOsList(
      transactionTypeId, financialyearId, partyId, searchText) async {
    isLoading.value = true;
    String apiUrl =
        "/po/recent-party/$transactionTypeId/$financialyearId/$partyId/purchaseOrderDate/desc/1/1000?searchText=$searchText";

    Map<String, dynamic> responseValue = await apiCallService(
        apiUrl,
        'GET',
        {},
        TheResponseType.map,
        {},
        false); //--url, Method, body, responsetype, query parameter, isAuth
    print(responseValue.toString());
    List<dynamic> data = responseValue['purchaseOrderHeaders'];

    List<GetPOlistModel> poList =
        data.map((e) => GetPOlistModel.fromJson(e)).toList();
    isLoading.value = false;
    poListItems.value = poList;
    poListItems.refresh();

    return poListItems;
  }

  GetPOlistModel? itemDataquotation;

  Future<List<GetPOlistModel>> getPOdetails(String id) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    print(loginDetails.token);

    Dio dio = Dio();

    var apiData = baseUrl + PurchaseOrderUrl + "/$id";

    try {
      final response = await dio.get(apiData,
          options: Options(
              headers: {"Authorization": "Bearer ${loginDetails.token}"}));

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        print("Status code - ${response.statusCode}");

        itemDataquotation = GetPOlistModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      print("fjdlsfjslfjsljfslflfj$e");
    } finally {
      isPageLoading.value = false;
    }
    return poListItems;
  }

  Future<List<GetQuotationListModel>> getQuotationsList(
      transactionTypeId, financialyearId, partyId, searchText) async {
    isLoading.value = true;
    Map<String, dynamic> responseValue = await apiCallService(
        "/quotation/recent-byParty/$transactionTypeId/$financialyearId/$partyId/quotationDate/desc/1/1000?searchText=$searchText",
        'GET',
        {},
        TheResponseType.map,
        {},
        false); //--url, Method, body, responsetype, query parameter, isAuth
    List<dynamic> data = responseValue['quotationHeaders'];

    List<GetQuotationListModel> quotationList =
        data.map((e) => GetQuotationListModel.fromJson(e)).toList();
    isLoading.value = false;
    quotationListItems.value = quotationList;
    quotationListItems.refresh();

    return quotationListItems;
  }

  InvoiceModel? itemDatas;

  Future getInvoicedetails(String id) async {
    print("id ----------------$id");
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    print(loginDetails.token);

    Dio dio = Dio();

    var apiData = baseUrl + invoiceUrl + "/$id";

    print("apidata =========== $apiData");

    try {
      final response = await dio.get(apiData,
          options: Options(
              headers: {"Authorization": "Bearer ${loginDetails.token}"}));

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        print("Status code - ${response.statusCode}");

        itemDatas = InvoiceModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      print("fjdlsfjslfjsljfslflfj$e");
    } finally {
      isPageLoading.value = false;
    }
    return itemDatas;
  }

  Future<List<InvoiceModel>> getInvoicesList(
      transactionTypeId, financialyearId, partyId, searchText) async {
    isLoading.value = true;
    Map<String, dynamic> responseValue = await apiCallService(
        "/invoice/recent-party/$transactionTypeId/$financialyearId/$partyId/invoiceDate/desc/1/500?searchText=$searchText",
        'GET',
        {},
        TheResponseType.map,
        {},
        false); //--url, Method, body, responsetype, query parameter, isAuth
    List<dynamic> data = responseValue['invoiceHeaders'];

    List<InvoiceModel> invoicesList =
        data.map((e) => InvoiceModel.fromJson(e)).toList();
    isLoading.value = false;
    invoiceListItems.value = invoicesList;
    invoiceListItems.refresh();

    await getServiceList(
        transactionTypeId, financialyearId, partyId, searchText, "-1");
    return invoiceListItems;
  }

  Future<List<PartyServiceDetailsModel>> getServiceList(
      transactionTypeId, financialyearId, partyId, searchText, filterId) async {
    isLoading.value = true;
    String api =
        "/service-invoice/recent-party/$transactionTypeId/$financialyearId/$partyId/$filterId/invoiceDate/desc/1/500?searchText=$searchText";
    try {
      var responseValue = await apiCallService(
          api,
          'GET',
          {},
          TheResponseType.list,
          {},
          false); //--url, Method, body, responsetype, query parameter, isAuth
      List<dynamic> data = responseValue['subscriptionServiceDTOS'];

      List<PartyServiceDetailsModel> serviceList =
          data.map((e) => PartyServiceDetailsModel.fromJson(e)).toList();
      isLoading.value = false;
      serviceListItems.value = serviceList;
      serviceListItems.refresh();

      return serviceListItems;
    } catch (e) {
      print("service list --$e");
    }
    return serviceListItems;
  }

  // Future<List<TransactionTypeModel>> gettransacstionTypeList() async {
  //   isLoading.value = true;
  //   List<dynamic> responseValue = await apiCallService("/transaction-type", 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
  //   List<TransactionTypeModel> transactionTypeValue = (responseValue).map((e) => TransactionTypeModel.fromJson(e)).toList();
  //   isLoading.value = false;
  //   transcationItem.value = transactionTypeValue;
  //   transcationItem.refresh();

  //   return transcationItem;
  // }

  Future<List<TransactionTypeModel>> gettransactionTypeList(
      String query) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    print(token);

    Dio dio = Dio();

    var apiData = ('$baseUrl/transaction-type');

    try {
      final response = await dio.get(apiData,
          options: Options(headers: {"Authorization": "Bearer $token"}));

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        List<TransactionTypeModel> result = (response.data as List)
            .map((e) => TransactionTypeModel.fromJson(e))
            .toList();

        transcationItem.value = result;
        transcationItem.refresh();

        transcationItem.sort(
          (a, b) => a.name!.toLowerCase().toString().compareTo(
                b.name!.toLowerCase().toString(),
              ),
        );
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return transcationItem;
  }

  deleteDocument(List<String> payload, var partyId) async {
    String url = "/files-multipleFileDelete";

    print('URL: $url');

    var data = json.encode(payload);
    print('Payload: $data');
    print('partyId: $partyId');

    try {
      var response = await apiCallService(
          url, "POST", data, TheResponseType.map, {}, false);

      print(response);
      await getDocumentWalletList(partyId);
    } catch (e) {
      print("error ---- $e");
    }
  }

  Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false);
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.single;

      if (file.extension == 'pdf') {
        return File(file.path!);
        // Selected file is a PDF, proceed with further processing
        // Access the file using file.path or file.bytes
      } else {
        customSnackbar(
            "Selected File is Not pdf", "Please Select a Pdf File", "error");
        // Selected file is not a PDF, show an error message or prompt user to select a valid PDF file
      }
    }

    update();
    return null;
  }

  Future<void> uploadDocumentWalletPdf(File file, String id) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    // Decode user data from SharedPreferences
    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    // Define the URL
    String url = '$baseUrl/files/handleMultipleFile';

    print("url ---- $url");
    print("id ------1st------ $id");

    // Prepare parameters and filename
    var fileName = file.path.split('/').last;
    print("Filename: $fileName");

    // Prepare FormData

    FormData formData = FormData.fromMap({
      'Documents': await MultipartFile.fromFile(
        file.path,
        filename: fileName,
        contentType: MediaType('application', 'pdf'),
      ),
      "id": id,
    });

    // Create Dio instance
    Dio dio = Dio();

    print("id ------------ $id");

    try {
      // Send the POST request
      final response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            "Authorization": "Bearer ${loginDetails.token}"
          },
        ),
      );

      print(response.data);

      await getDocumentWalletList(id);
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

  Future<List<DesignationModel>> getDesignationList() async {
    List<dynamic> responseValue = await apiCallService(
        "/designations",
        'GET',
        {},
        TheResponseType.list,
        {},
        false); //--url, Method, body, responsetype, query parameter, isAuth
    List<DesignationModel> designation =
        (responseValue).map((e) => DesignationModel.fromJson(e)).toList();
    designationList.value = designation;
    designationList.refresh();

    return designationList;
  }

  Future<List<DepartmentModel>> getDepartmentList() async {
    List<dynamic> responseValue = await apiCallService(
        "/departments",
        'GET',
        {},
        TheResponseType.list,
        {},
        false); //--url, Method, body, responsetype, query parameter, isAuth
    List<DepartmentModel> department =
        (responseValue).map((e) => DepartmentModel.fromJson(e)).toList();

    departmentList.value = department;
    departmentList.refresh();

    return departmentList;
  }

  Future<List<TypeModel>> getPartyTypeLists(String query) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    print(loginDetails.token);

    Dio dio = Dio();

    var apiData = baseUrl + partyTyepUrl;

    try {
      final response = await dio.get(apiData,
          options: Options(
              headers: {"Authorization": "Bearer ${loginDetails.token}"}));
      print(response.data);
      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);

        List<TypeModel> result =
            (response.data as List).map((e) => TypeModel.fromJson(e)).toList();

        // partyTypeList.clear();
        partyTypeList.value = result;

        partyTypeList.refresh();

        // quotationList.value = result;
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      await checkTokenExpired(e.response!.statusCode);
    }
    return partyTypeList;
  }

  Future<List<StateModel>> getStateList(String query) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    print(token);

    Dio dio = Dio();

    var apiData = ('$baseUrl/state');

    try {
      final response = await dio.get(apiData,
          options: Options(headers: {"Authorization": "Bearer $token"}));

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        List<StateModel> result =
            (response.data as List).map((e) => StateModel.fromJson(e)).toList();

        stateList.value = result;
        stateList.refresh();

        for (int i = 0; i < stateList.length; i++) {
          stateName.add(stateList[i].name!);
          stateName.sort((a, b) =>
              a.toLowerCase().toString().compareTo(b.toLowerCase().toString()));
          stateName.refresh();
        }
      }
      return stateList;
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return stateList;
  }

  Future<List<StateModel>> getCountryList(String query) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    print(token);

    Dio dio = Dio();

    var apiData = ('$baseUrl/country');

    try {
      final response = await dio.get(apiData,
          options: Options(headers: {"Authorization": "Bearer $token"}));

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        List<StateModel> result =
            (response.data as List).map((e) => StateModel.fromJson(e)).toList();

        countryList.value = result;
        countryList.refresh();

        for (int i = 0; i < countryList.length; i++) {
          CountryName.add(countryList[i].name!);
          CountryName.sort((a, b) =>
              a.toLowerCase().toString().compareTo(b.toLowerCase().toString()));
          CountryName.refresh();
        }
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return countryList;
  }

  Future<List<AreaModel>> getAreaList(String query) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    print(token);

    Dio dio = Dio();

    var apiData = ('$baseUrl/area');

    try {
      final response = await dio.get(apiData,
          options: Options(headers: {"Authorization": "Bearer $token"}));

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        List<AreaModel> result =
            (response.data as List).map((e) => AreaModel.fromJson(e)).toList();

        areaList.value = result;
        areaList.refresh();

        areaList.sort(
          (a, b) => a.name!.toLowerCase().toString().compareTo(
                b.name!.toLowerCase().toString(),
              ),
        );
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return areaList;
  }

  Future<List<CityModel>> getCityList(String query) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    print(token);

    Dio dio = Dio();

    var apiData = ('$baseUrl/city');

    try {
      final response = await dio.get(apiData,
          options: Options(headers: {"Authorization": "Bearer $token"}));

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        List<CityModel> result =
            (response.data as List).map((e) => CityModel.fromJson(e)).toList();

        cityList.value = result;
        cityList.refresh();

        cityList.sort(
          (a, b) => a.name!.toLowerCase().toString().compareTo(
                b.name!.toLowerCase().toString(),
              ),
        );
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return cityList;
  }

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

  RxInt materialId = 0.obs;

  filterMaterialName(String query) {
    // getMaterialNameList();
    materialNameFilteredList.value = materialNameList.where((item) {
      final materialName = item.name!.toLowerCase();
      final searchName = query.toLowerCase();
      return materialName.contains(searchName);
    }).toList();
  }

  Future<List<MaterialModel>> getMaterialNameList(String query) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    print(token);

    Dio dio = Dio();

    var apiData = ('$baseUrl/material/material-type/${materialId.value}');

    try {
      final response = await dio.get(apiData,
          options: Options(headers: {"Authorization": "Bearer $token"}));

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        materialNameFilteredList.clear();
        materialNameList.clear();
        List<MaterialModel> result = (response.data as List)
            .map((e) => MaterialModel.fromJson(e))
            .toList();

        materialNameList.value = result;

        materialNameList.sort((a, b) => a.name!
            .toLowerCase()
            .toString()
            .compareTo(b.name!.toLowerCase().toString()));

            
if (query.isNotEmpty) {
          materialNameFilteredList.value = materialNameList.where((item) {
            final materialName = item.name!.toLowerCase();
            final searchName = query.toLowerCase();
            return materialName.contains(searchName);
          }).toList();
        } else {
          materialNameFilteredList.value = materialNameList;
  
}
        materialNameList.refresh();
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return materialNameFilteredList;
  }

  Future<List<BankModel>> getBankList(String query) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    print(token);

    Dio dio = Dio();

    var apiData = ('$baseUrl/banks');

    try {
      final response = await dio.get(apiData,
          options: Options(headers: {"Authorization": "Bearer $token"}));

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        List<BankModel> result =
            (response.data as List).map((e) => BankModel.fromJson(e)).toList();

        bankList.value = result;
        bankList.refresh();

        bankList.sort(
          (a, b) => a.bankname!.toLowerCase().toString().compareTo(
                b.bankname!.toLowerCase().toString(),
              ),
        );
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return bankList;
  }

  Future savePartyMaster(bool? IsEdit) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString('token');

    Map map = partyMasterModelValue!.toJson();

    var mapdatas = jsonEncode({
      "partyDTO": map,
      "materialPriceListDTOList": materialPriceItem,
      "materialPriceListDeletedIds": [],
      "partyBankMapDTOList": materialBankItem,
      "partyBankMapDeletedIds": [],
      "partyContactDetails": contactListItem,
      "contactDeletedIds": [],
      "termsAndConditions": termsNdconditionItem,
      "termsAndConditionDTOS": [],
    });

    print("ajith-----------sending dataaaa-------------${mapdatas.toString()}");

    // Dio dio = Dio();

    var apiData = "$baseUrl/party";

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

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        PartyWithPriceLists value = PartyWithPriceLists.fromJson(jsonResponse);

        // print("--------0000 ----- " + value.partyDTO!.name.toString() ?? "");

        if (value.partyDTO != null) {
          Get.offAll(
              () => OpenPartyMasterScreen(
                    partyMasterSavedValue: value,
                  ),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 600));
        } else {
          customSnackbar(
              "If Party is already used in a transaction, state cannot be updated",
              "",
              "error");
        }
      } else {
        customSnackbar("error", "Party Master is not Saved", "error");
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

  Future<bool> checkEmail(String query) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');

    print(token);

    Dio dio = Dio();

    isEmailAvailable.value = false;

    var apiData = ('$baseUrl/party/check-email/$query');

    try {
      final response = await dio.get(apiData,
          options: Options(headers: {"Authorization": "Bearer $token"}));

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        TransactionNumberModel value =
            TransactionNumberModel.fromJson(response.data);

        value.responseStatus == 1 ? isEmailAvailable.value = true : false;
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    }
    return isEmailAvailable.value;
  }

  Future<bool> checkgst(String query) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    print(token);

    Dio dio = Dio();
    isGstAvailable.value = false;
    var apiData = ('$baseUrl/party/check-gst/$query');

    try {
      final response = await dio.get(apiData,
          options: Options(headers: {"Authorization": "Bearer $token"}));

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        TransactionNumberModel value =
            TransactionNumberModel.fromJson(response.data);

        value.responseStatus == 1 ? isGstAvailable.value = true : false;
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    }
    return isGstAvailable.value;
  }

  Future<bool> checkNumber(int query) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    print(token);

    Dio dio = Dio();
    isNumberAvailable.value = false;
    var apiData = ('$baseUrl/party/check-number/$query');

    try {
      final response = await dio.get(apiData,
          options: Options(headers: {"Authorization": "Bearer $token"}));

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        TransactionNumberModel value =
            TransactionNumberModel.fromJson(response.data);

        value.responseStatus == 1 ? isNumberAvailable.value = true : false;
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    }
    return isNumberAvailable.value;
  }

  Future updatePurchaseOrder(GetPOlistModel? poSavedValue,
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

        Get.offAll(() => PartyMasterScreen(),
            transition: Transition.fade, duration: const Duration(milliseconds: 600));
      } else {
        customSnackbar("error", "Purchase Order is not Saved", "error");
        print(response.statusCode);
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      await checkTokenExpired(e.response!.statusCode);
      print("step 5");
      print(e.response!.data);
    }
  }

  Future transactionNumber(int id) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString('token');

    var type = id == 1 ? "Customer" : "Supplier";

    String apiData = "$baseUrl$transationNumUrl/$type Code";

    Dio dio = Dio();

    try {
      var response = await dio.get(apiData,
          options: Options(headers: {
            "Authorization": "Bearer $token",
            "content-type": "application/json"
          }));

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        print("Success");
        print("transasfslfslfjlsfslfjsfjs===${response.data}");

        purchaseOrderTransactionNumber =
            TransactionNumberModel.fromJson(response.data);

        print(
            "po trans number ----------- ${purchaseOrderTransactionNumber!.responseString}");

        partyCodeController.text =
            purchaseOrderTransactionNumber!.responseString!;
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      print(e);
    }
  }
}
