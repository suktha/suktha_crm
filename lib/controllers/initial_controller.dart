// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_Force/Model/transaction_type_model.dart';
import 'package:work_Force/controllers/Home_controller.dart';
import 'package:work_Force/controllers/global_controller.dart';
import 'package:work_Force/controllers/settings_controller.dart';
import 'package:work_Force/view/bottom_navigation/bottom_navigation_mainScreen.dart';
import 'package:work_Force/view/bottom_navigation/navbar_controller.dart';
import 'package:work_Force/view/screens/login/login_screen.dart';
import 'package:work_Force/view/screens/pre_sales/pre_sale_screen.dart';
import 'package:work_Force/view/widget/snackbar.dart';

class InitialController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // getAllRecentActivity();
    // fetchDashboardData();
    checkLastLoginTime();
  }

  // RxList<RxList<RecentActivityModel>> recentItemAllList = <RxList<RecentActivityModel>>[].obs;

  // RxList<RecentActivityModel> salesRecentItemList = <RecentActivityModel>[].obs;
  // RxList<RecentActivityModel> purchaseRecentItemList = <RecentActivityModel>[].obs;
  // RxList<RecentActivityModel> preSalesRecentItemList = <RecentActivityModel>[].obs;
  // RxList<RecentActivityModel> jobworkRecentItemList = <RecentActivityModel>[].obs;
  // RxList<RecentActivityModel> subcontractingRecentItemList = <RecentActivityModel>[].obs;

  // RxList<GraphModel> customerInvoice = <GraphModel>[].obs;
  // RxList<GraphModel> purchaseInvoice = <GraphModel>[].obs;
  // RxList<GraphModel> subContractingInvoice = <GraphModel>[].obs;
  // RxList<GraphModel> jobWorkInvoce = <GraphModel>[].obs;
  // RxList<GraphModel> openQuotation = <GraphModel>[].obs;
  // RxList<GraphModel> openPurchaseOrder = <GraphModel>[].obs;

  // RxList<List<GraphModel>> graphList = <List<GraphModel>>[].obs;
  RxList<String> carouselText = <String>[].obs;

  // RecentActivityModel? recentquotationActivites;

  final dropdownvalue = '3'.obs;

  void setSelected(String value) {
    dropdownvalue.value = value;
    // getInvoicePayment();
  }

  // void initializeLists() {
  //   // recentItemAllList.clear();
  //   recentItemAllList.add(salesRecentItemList);
  //   recentItemAllList.add(purchaseRecentItemList);
  //   recentItemAllList.add(accountsRecentItemList);
  //   recentItemAllList.add(jobworkRecentItemList);
  // }

  // void addToSalesList(int listIndex, Purchase activity) {
  //   recentItemAllList[listIndex].add(activity);

  //   // recentItemAllList[listIndex].sort((a, b) => DateTime.parse(b.transactionCreatedDAte!).compareTo(DateTime.parse(a.transactionCreatedDAte!)));
  // }

  checkLastLoginTime() async {
    print("inside the last login time check");
    final prefs = await SharedPreferences.getInstance();
    final lastLoginTimeString = prefs.getString('_lastLoginTime');
    final value = prefs.getBool('loginsuccess');
    final onboardvalue = prefs.getBool("onboardKey");

    final lastLoginTime = DateTime.parse(lastLoginTimeString ?? DateTime.now().toString());
    final difference = DateTime.now().difference(lastLoginTime);

    print(difference.inHours);

    if (difference.inHours >= 24) {
      await prefs.clear();

      Get.offAll(() =>const LoginPage(), transition: Transition.fade, duration: const Duration(milliseconds: 1000));

      customSnackbar("Session TimeOut", "Please Login Again", "error");
    } else {
      if (value == true) {
        // getMenus();
        // getRecentlyGeneratedData();
        // getInvoicePayment();
        // await transactionType();
        print("navigate to main screen");

        navToMain();
      } else if (onboardvalue == true) {
        navToLogin();
        print("navigate to login screen");
      } else {
        print("navigate to onboard screen");

        navtoOnboard();
      }
    }
  }

  void navToLogin() {
    Future.delayed(const Duration(seconds: 2), () async {
      Get.offAll(() => const LoginPage(), transition: Transition.fade, duration: const Duration(milliseconds: 700));
    });
  }

  navtoOnboard() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("onboardKey", true);

    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => const LoginPage(), transition: Transition.fade, duration: const Duration(milliseconds: 700));
    });
  }

  void navToMain() {
    Get.put(NavigationController());
    Get.put(GlobalController());
    Get.put(SettingsController());
    Get.put(HomeController());

    Future.delayed(const Duration(seconds: 1), () async {
      Get.offAll(
          () => const BottomNavigationMainscreen(
                initialIndex: 1,
              ),
          transition: Transition.fade,
          duration: const Duration(milliseconds: 700));
    });
  }

//   Future getInvoicePayment() async {
//     final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     String? token = sharedPreferences.getString('token');
//     print(token);
//     Dio dio = Dio();

//     var endpoints = int.parse(dropdownvalue.value) - 1;

//     var apiDataforQuot = (baseUrl + openQuotationMonthUrl + endpoints.toString());

//     var apiDataforinvoice = (baseUrl + invoicePaymentMonthsUrl + endpoints.toString());

//     var apiDataforOpenPO = (baseUrl + openPurchaseOrderMonthUrl + endpoints.toString());

//     print(apiDataforQuot);

//     try {
//       final response = await dio.get(apiDataforinvoice, options: Options(headers: {"Authorization": "Bearer $token"}));

//       final responseforquot = await dio.get(apiDataforQuot, options: Options(headers: {"Authorization": "Bearer $token"}));

//       final responseforOpenPO = await dio.get(apiDataforOpenPO, options: Options(headers: {"Authorization": "Bearer $token"}));

//       await checkTokenExpired(response.statusCode);
//       if (response.statusCode == 200) {
//         List<GraphModel> result = (response.data as List).map((e) => GraphModel.fromJson(e)).toList();

//         customerInvoice.clear();
//         purchaseInvoice.clear();
//         subContractingInvoice.clear();
//         jobWorkInvoce.clear();
//         openPurchaseOrder.clear();
//         openQuotation.clear();

//         for (var i = 0; i < result.length; i++) {
//           if (result[i].transactionName == "Customer Invoice") {
//             customerInvoice.add(result[i]);
//             customerInvoice.refresh();
//             customerInvoice.toSet().toList();
//           } else if (result[i].transactionName == "Purchase Invoice") {
//             purchaseInvoice.add(result[i]);
//             purchaseInvoice.refresh();
//             purchaseInvoice.toSet().toList();
//           } else if (result[i].transactionName == "Subcontracting Invoice") {
//             subContractingInvoice.add(result[i]);
//             subContractingInvoice.refresh();
//             subContractingInvoice.toSet().toList();
//           } else if (result[i].transactionName == "Jobwork Invoice") {
//             jobWorkInvoce.add(result[i]);

//             jobWorkInvoce.toSet().toList();
//             jobWorkInvoce.refresh();
//           }
//         }
//         print("cusotmer invoice $customerInvoice");
//         print("purchase invoice $purchaseInvoice");
//         print("subcont invoice $subContractingInvoice");
//         print("jobwo invoice $jobWorkInvoce");
//       }

//       if (responseforquot.statusCode == 200) {
//         List<GraphModel> resultforQuot = (responseforquot.data as List).map((e) => GraphModel.fromJson(e)).toList();

//         openQuotation.value = resultforQuot;
//         openQuotation.refresh();
//         openQuotation.toSet().toList();
//       }

//       if (responseforOpenPO.statusCode == 200) {
//         List<GraphModel> resultForPO = (responseforOpenPO.data as List).map((e) => GraphModel.fromJson(e)).toList();

//         openPurchaseOrder.value = resultForPO;
//         openPurchaseOrder.refresh();
//         openPurchaseOrder.toSet().toList();
//       }
//       print("open quot invoice $openQuotation");
//       print("purchase order invoice $openPurchaseOrder");
//     } on DioException catch (e) {
//       await checkTokenExpired(e.response!.statusCode);
//     } finally {}
//   }

//   RxMap<String, List<RecentActivityModel>> dataMap = <String, List<RecentActivityModel>>{}.obs;

//   Future<void> fetchDashboardData() async {
//     try {
//       Map<String, dynamic> result = await apiCallService('/recent-dashboard-data', 'GET', {}, TheResponseType.map, {}, false);

//       Map<String, List<RecentActivityModel>> tempDataMap = {};

//       result.forEach((key, values) {
//         List<RecentActivityModel> items = (values as List).map((e) => RecentActivityModel.fromJson(e)).toList();
//         tempDataMap[key] = items;
//       });

//       dataMap.value = tempDataMap;

//       print("dataMap: $dataMap");
//     } catch (e) {
//       print("Error fetching data: $e");
//     }
//   }

  RxList<TransactionTypeModel> transactionTypeList = <TransactionTypeModel>[].obs;

//   Future<List<TransactionTypeModel>> transactionType() async {
//     Dio dio = Dio();

//     final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     String? token = sharedPreferences.getString('token');

//     var apiData = (baseUrl + transactionTypeUrl);

//     try {
//       final response = await dio.get(apiData, options: Options(headers: {"Authorization": "Bearer $token"}));

//       if (response.statusCode == 200) {
//         List<TransactionTypeModel> result = (response.data as List).map((e) => TransactionTypeModel.fromJson(e)).toList();

//         transactionTypeList.value = result;
//         transactionTypeList.refresh();
//         log(transactionTypeList.map((e) => e.toJson()).toList().toString());
//       } else {
//         throw Exception('Failed to load transaction types');
//       }
//     } on DioException catch (e) {
//       await checkTokenExpired(e.response!.statusCode);
//     }
//     return transactionTypeList;
//   }

//   checkTransType(int typeId, String transactionName) async {
//     print(typeId);
// //

//     await transactionType();

//     var matchingItem = transactionTypeList.firstWhere(
//       (item) => item.id == typeId,
//     );

//     String typeName = matchingItem.name!;

//     switch (typeName) {
//       case "Customer Invoice":
//         Get.to(TaxInvoiceScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         break;
//       case "Lead Generation":
//         Get.to(LeadManagementListScreen(
//           isFromHomeScreen: true,
//           quotationNumber: transactionName,
//         ));
//         break;
//       case "Supplier PO":
//         Get.to(SupplierPoScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));

//         // Navigate to Supplier PO screen
//         break;
//       case "Customer Receipts":
//         Get.to(CustomerReceiptsScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));

//         // Navigate to Customer Receipts screen
//         break;
//       case "Supplier Payments":
//         Get.to(SupplierPaymentScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));

//         // Navigate to Supplier Payments screen
//         break;
//       case "Purchase Invoice":
//         Get.to(PurchaseInvoiceScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));

//         // Navigate to Purchase Invoice screen
//         break;
//       case "Incoming DC":
//         Get.to(IncomingDcScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));

//         // Navigate to Incoming DC screen
//         break;
//       case "Customer DC":
//         Get.to(DcScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to Customer DC screen
//         break;
//       case "GRN":
//         Get.to(GrnScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to GRN screen
//         break;
//       case "Credit Note":
//         Get.to(CreditNoteScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to Credit Note screen
//         break;
//       case "Debit Note":
//         Get.to(DebitNoteScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));

//         // Navigate to Debit Note screen
//         break;
//       case "Customer PO":
//         Get.to(PurchaseOrderSalesScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         Get.to(PurchaseOrderSalesScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to Customer PO screen
//         break;
//       case "Customer Quotation":
//         Get.to(QuotationScreen(
//           isFromHomeScreen: true,
//           quotationNumber: transactionName,
//         ));
//         Get.to(QuotationScreen(
//           isFromHomeScreen: true,
//           quotationNumber: transactionName,
//         ));
//         // Navigate to Customer Quotation screen
//         break;
//       case "Jobwork In DC":
//         Get.to(JobWorkInDcScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         Get.to(JobWorkInDcScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to Jobwork In DC screen
//         break;
//       case "Jobwork out DC":
//         Get.to(JobWorkOutDcScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         Get.to(JobWorkOutDcScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to Jobwork Out DC screen
//         break;
//       case "Jobwork Invoice":
//         Get.to(JobworkInvoiceScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to Jobwork Invoice screen
//         break;
//       case "Subcontracting out DC":
//         Get.to(SubcontractingOutDcScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to Subcontracting Out DC screen
//         break;
//       case "Subcontracting In DC":
//         Get.to(SubcontractingInDcScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to Subcontracting In DC screen
//         break;
//       case "Subcontracting Invoice":
//         Get.to(SubcontractingInvoiceScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to Subcontracting Invoice screen
//         break;
//       case "Proforma Invoice":
//         Get.to(ProfromaInvoiceScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to Proforma Invoice screen
//         break;
//       case "Jobwork PO":
//         Get.to(JobworkPurchaseOrderScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to Jobwork PO screen
//         break;
//       case "Subcontracting PO":
//         Get.to(SubcontractingPurchaseOrderScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to Subcontracting PO screen
//         break;
//       case "Cash Voucher":
//         Get.to(CashVoucherScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to Cash Voucher screen
//         break;
//       case "Cheque Voucher":
//         Get.to(ChequeVoucherScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to Cheque Voucher screen
//         break;
//       case "Petty Cash":
//         Get.to(DcScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to Petty Cash screen
//         break;
//       case "Customer Code":
//         Get.to(DcScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to Customer Code screen
//         break;
//       case "Supplier Code":
//         Get.to(DcScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to Supplier Code screen
//         break;
//       case "Jobwork Credit Note":
//         Get.to(JobWorkCreditNoteScreen(
//           isFromHomeScreen: true,
//           creditTransactionNumber: transactionName,
//         ));
//         // Navigate to Jobwork Credit Note screen
//         break;
//       case "Subcontract Debit Note":
//         Get.to(SubcontractDebitNoteScreen(
//           isFromHomeScreen: true,
//           debitTransactionNumber: transactionName,
//         ));
//         // Navigate to Subcontract Debit Note screen
//         break;
//       case "Jobwork Quotation":
//         Get.to(JobWorkQuotationScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to Jobwork Quotation screen
//         break;
//       case "Subcontracting Quotation":
//         Get.to(SubcontractingQuotationScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to Subcontracting Quotation screen
//         break;
//       case "Jobwork Proforma Invoice":
//         Get.to(JobworkProformaInvoiceScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to Jobwork Proforma Invoice screen
//         break;
//       case "Subcontracting Proforma Invoice":
//         Get.to(SubcontractingProformaInvoiceScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to Subcontracting Proforma Invoice screen
//         break;
//       case "Advance Receipt":
//         Get.to(AdvanceReceiptScreen(
//           isFromHomeScreen: true,
//           transactionNumber: transactionName,
//         ));
//         // Navigate to Advance Receipt screen
//         break;
//       default:
//         // Handle the case where the selected string doesn't match any cases
//         break;
//     }
//   }
}
