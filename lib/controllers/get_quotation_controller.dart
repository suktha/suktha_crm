// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:dio/dio.dart';
// import 'package:suktha/Constants/shared_pref_keys.dart';
// import 'package:suktha/Model/financial_year_all_model.dart';
// import 'package:suktha/Model/financial_year_model.dart';
// import 'package:suktha/Model/global_settings_model.dart';
// import 'package:suktha/Model/response_string_model.dart';
// import 'package:suktha/Model/transaction_numbering_model.dart';
// import 'package:suktha/utils/services/sharedpref_services.dart';
// import 'package:suktha/utils/validations/check_token_expired.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:number_to_words/number_to_words.dart';
// import 'package:flutter/material.dart';
// import 'package:suktha/Controller/global_controller.dart';
// import 'package:suktha/Constants/colors.dart';
// import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:suktha/utils/services/rest_api_services.dart';
// import 'package:suktha/utils/api/quotation.dart';
// import 'package:suktha/utils/api/common_api.dart';
// import 'package:suktha/Model/get_qoutation_list_model.dart';
// import 'package:suktha/Model/login_model.dart';
// import 'package:suktha/Model/transaction_number.dart';
// import 'package:suktha/View/Widgets/pdfview.dart';
// import 'package:work_Force/Constants/colors.dart';
// import 'package:work_Force/Constants/shared_pref_keys.dart';
// import 'package:work_Force/Model/financial_year_all_model.dart';
// import 'package:work_Force/Model/financial_year_model.dart';
// import 'package:work_Force/Model/get_qoutation_list_model.dart';
// import 'package:work_Force/Model/global_settings_model.dart';
// import 'package:work_Force/Model/login_model.dart';
// import 'package:work_Force/Model/response_string_model.dart';
// import 'package:work_Force/Model/transaction_number.dart';
// import 'package:work_Force/Model/transaction_numbering_model.dart';
// import 'package:work_Force/utils/Services/rest_api_services.dart';
// import 'package:work_Force/utils/Services/sharedpref_services.dart';
// import 'package:work_Force/utils/api/common_api.dart';
// import 'package:work_Force/utils/api/quotation.dart';
// import 'package:work_Force/utils/check_token_expired.dart';
// import 'package:work_Force/view/widget/snackbar.dart';
// import '../View/Modules/Transactions/Sales/Sales Items/Quotation/View Quotation/Quotation_list.dart';
// import '../View/Widgets/snackbar.dart';

// class GetQuotationlistController extends GetxController {
//   String? localPath;
//   late bool permissionReady;
//   TargetPlatform? platform;

//   late TextEditingController printHeaderTextController, searchController;

//   RxBool hidefloatingButton = true.obs;

//   final dropdownvalue = 'ORIGINAL'.obs;

//   RxBool materialImageIschecked = false.obs;

//   RxDouble progres = 0.0.obs;

//   RxList<GetQuotationListModel> quotationList = <GetQuotationListModel>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     getFinancialYearList();
//     checkQuotationTransactionNumById();
//     printHeaderTextController = TextEditingController();
//     searchController = TextEditingController();
//     printHeaderTextController.text = "Quotation";
//     // loadings();

//     if (Platform.isAndroid) {
//       platform = TargetPlatform.android;
//     } else {
//       platform = TargetPlatform.iOS;
//     }
//   }

//   RxBool loading = false.obs;
//   RxBool hasMore = true.obs;
//   RxBool listLoad = false.obs;

//   RxBool isSelectedNew = false.obs;
//   RxBool isSelectedCompleted = false.obs;

//   void onNewCheckboxChanged(bool value) {
//     isSelectedNew.value = value;
//   }

//   void onCompletedCheckboxChanged(bool value) {
//     isSelectedCompleted.value = value;
//   }

//   RxString selectedRadio = "".obs;

//   void onRadioSelected(String value) {
//     selectedRadio.value = value;
//   }

//   RxBool sortDirection = true.obs;

//   void containerOnpressed() {
//     sortDirection.value = !sortDirection.value;
//   }

//   RxList<FinancialYearAllModel> financialYearList = <FinancialYearAllModel>[].obs;

//   RxString financialYearId = "".obs;
//   RxString financialYear = "".obs;

//   Future getFinancialYearList() async {
//     final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     String? token = sharedPreferences.getString('token');
//     // print("----3-----${createproformaItem!.partyName}");
//     final financialYearDetailDEcoded = json.decode(sharedPreferences.getString('financialYear')!);
//     final financialYear = FinancialYearModel.fromJson(financialYearDetailDEcoded);
//     Dio dio = Dio();

//     var apiData = (baseUrl + "/financial-years-all");

//     print(apiData);

//     try {
//       print(11111111);

//       final response = await dio.get(apiData, options: Options(headers: {"Authorization": "Bearer $token"}));

//       print(response.statusCode);

//       await checkTokenExpired(response.statusCode);
//       if (response.statusCode == 200) {
//         print(response.data);

//         List<FinancialYearAllModel> result = (response.data as List).map((e) => FinancialYearAllModel.fromJson(e)).toList();
//         financialYearId.value = financialYear.id.toString();
//         print("finan id  -------------- ${financialYearId}");
//         financialYearList.value = result;
//         financialYearList.refresh();
//         // print("-----------------------------------" + financialYearList.string);

//         // print(response.data);
//       }
//       return financialYearList;
//     } on DioException catch (e) {
//       await checkTokenExpired(e.response!.statusCode);
//     } finally {}
//     return financialYearList;
//   }

//   TransactionNumberingModel? checkAutoNumOrNot;

//   RxInt autoNum = 1.obs;
//   checkQuotationTransactionNumById() async {
//     Map<String, dynamic> responseValue = await apiCallService("/num-range-config/transactionType/12", 'GET', {}, TheResponseType.map, {},
//         false); //--url, Method, body, responsetype, query parameter, isAuth
//     checkAutoNumOrNot = TransactionNumberingModel.fromJson(responseValue);
//     autoNum.value = checkAutoNumOrNot!.autoNumber ?? 0;
//     print("auto nummm- Credit----$autoNum");
//     await quotTransactionNumber();
//   }

//   var finalValue;
//   TransactionNumberModel? quotationTransactionNumber;

//   Future quotTransactionNumber() async {
//     final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

//     String? token = sharedPreferences.getString('token');

//     String apiData = baseUrl + transationNumUrl + customerQuotationUrl;

//     Dio dio = Dio();

//     if (autoNum.value == 0) {
//       print("Auto num false");
//     } else {
//       try {
//         final response = await dio.get(
//           apiData,
//           options: Options(headers: {"Authorization": "Bearer $token", "content-type": "application/json"}),
//         );

//         await checkTokenExpired(response.statusCode);
//         if (response.statusCode == 200) {
//           print("Success");
//           print(response.data);

//           quotationTransactionNumber = TransactionNumberModel.fromJson(response.data);

//           print("Quotation trans number ----------- ${quotationTransactionNumber!.responseString}");
//         }
//       } on DioException catch (e) {
//         await checkTokenExpired(e.response!.statusCode);
//         print(e);
//       }
//     }
//   }

//   RxString searchValue = "".obs;

//   Future<List<GetQuotationListModel>> getQuotationList(
//       String search, int page, String sortDirection, String sortWith, String filter, bool isFilter, String finYearId) async {
//     final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

//     final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
//     final loginDetails = LoginModel.fromJson(logindecoded);

//     await quotTransactionNumber();

//     print(loginDetails.token);

//     const limit = 5;

//     Dio dio = Dio();

//     var apiData = baseUrl + "/quotation/recent/12/$finYearId/$sortWith/$sortDirection/$page/$limit?searchText=$search";

//     print(apiData);
//     try {
//       final response = await dio.get(apiData, options: Options(headers: {"Authorization": "Bearer ${loginDetails.token}"}));
//       print(response.statusCode);
//       await checkTokenExpired(response.statusCode);
//       if (response.statusCode == 200) {
//         page == 1 ? quotationList.clear() : null;

//         page++;

//         loading.value = true;
//         hasMore.value = true;

//         Map<String, dynamic> data = response.data;

//         List<dynamic> headers = data['quotationHeaders'];

//         listLoad.value = false;
//         if (headers.length < limit) {
//           hasMore.value = false;
//           print("length--2 false limit-${quotationList.length}");
//         }

//         List<GetQuotationListModel> newQuotationList = headers.map((header) => GetQuotationListModel.fromJson(header)).toList();

//         if (isFilter == true) {
//           newQuotationList = newQuotationList.where((e) => e.statusName == filter).toList();
//         }
//         quotationList.addAll(newQuotationList);

//         quotationList.refresh();

//         print("length---${quotationList.length}");
//       }
//     } on DioException catch (e) {
//       await checkTokenExpired(e.response!.statusCode);
//       await checkTokenExpired(e.response!.statusCode);
//     } finally {
//       isPageLoading.value = false;
//     }
//     return quotationList;
//   }

//   Future<bool> _checkPermission() async {
//     if (platform == TargetPlatform.android) {
//       DeviceInfoPlugin plugin = DeviceInfoPlugin();
//       AndroidDeviceInfo android = await plugin.androidInfo;

//       if (android.version.sdkInt < 33) {
//         final status = await Permission.storage.status;
//         if (status != PermissionStatus.granted) {
//           final result = await Permission.storage.request();
//           if (result == PermissionStatus.granted) {
//             return true;
//           }
//         } else {
//           return true;
//         }
//       } else {
//         return true;
//       }
//     }
//     return false;
//   }

//   Future<String?> _findLocalPath() async {
//     if (platform == TargetPlatform.android) {
//       return "/sdcard/download/";
//     } else {
//       var directory = await getApplicationDocumentsDirectory();
//       return directory.path + Platform.pathSeparator + 'Download';
//     }
//   }

//   Future<void> _prepareSaveDir() async {
//     localPath = (await _findLocalPath())!;

//     print(localPath);
//     final savedDir = Directory(localPath!);
//     bool hasExisted = await savedDir.exists();
//     if (!hasExisted) {
//       savedDir.create();
//     }
//   }

//   openPdf(String headerText, File file, String url, String typeId, String partyId, String amount, String id, String transType) =>
//       Get.to(() => PdfViewerPage(
//           headerText: headerText, typeId: typeId, file: file, url: url, id: id, partyId: partyId, transType: transType, Amount: amount));

//   RxBool isPageLoading = false.obs;

//   Future<File> loadPdf(
//     int typeId,
//     String id,
//     String transType,
//     String amount,
//     String? printHeaderText,
//     int? materialImage,
//     String? printCopies,
//     bool isdownloadPdf,
//   ) async {
//     print("amount ---------${amount}");

//     final globalSettingsDecoded = json.decode(SharedPreferencesService.instance.getValue(SharedPrefKeys().settingsKey)!);

//     print(SharedPrefKeys().settingsKey);
//     print(globalSettingsDecoded);

//     final globalSettings = SettingsModel.fromJson(globalSettingsDecoded);

//     String? jasperFileName;

//     isPageLoading.value = true;

//     print(globalSettings.numberRangeConfigurations!.length);

//     try {
//       jasperFileName =
//           globalSettings.numberRangeConfigurations!.firstWhere((element) => element.transactionTypeId == typeId).jasperFileName ??
//               transType;
//     } on DioException catch (e) {
//       isPageLoading.value = false;
//       await checkTokenExpired(e.response!.statusCode);
//     }

//     log("jasper file name -- $jasperFileName");

//     final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     var response;

//     final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
//     final loginDetails = LoginModel.fromJson(logindecoded);


//     var signValue = loginDetails.user!.company!.signatureImagePath == null ? 0 : 1;
//     var qrCodeValue = loginDetails.user!.company!.qRCodeImagePath == null ? 0 : 1;
    

//     String value = NumberToWord().convert('en-in', int.parse(amount.split(".").first));
//     final amountToWords = value.toUpperCase();

//     String url =
//         "$baseUrl/jasper-print/$signValue/$qrCodeValue/0/$materialImage/0?id=$id&reportName=$jasperFileName&copyText=$printCopies&amountInWords=$amountToWords RUPEES  ONLY&printHeaderText=$printHeaderText";

//     print("url-----$url");

//     try {
//       if (isdownloadPdf == false) {
//         response = await Dio()
//             .get(url, options: Options(responseType: ResponseType.bytes, headers: {"Authorization": "Bearer ${loginDetails.token}"}));
//       } else {
//         await downloadPdf(url, loginDetails, jasperFileName!);
//       }
//     } on DioException catch (e) {
//       isPageLoading.value = false;
//       await checkTokenExpired(e.response!.statusCode);
//       print("Error in loadPdf: $e");
//       customSnackbar("Failed to Load", "Something Went Wrong ", "error");
//     } finally {
//       // Turn off loading indicator
//       isPageLoading.value = false;
//     }

//     return storeFile(url, response.data, printHeaderText!);
//   }

//   downloadPdf(String url, LoginModel loginDetails, String transType) async {
//     var time = DateTime.now().millisecond;

//     permissionReady = await _checkPermission();

//     if (permissionReady) {
//       await _prepareSaveDir();


//       final response = await Dio().download(url, "${localPath!}/${transType + time.toString()}.pdf", onReceiveProgress: (received, total) {
//         if (total != -1) {
//           double progress = (received / total) * 100;
//           progres.value = progress;
//           update();
//         }
//       }, options: Options(headers: {"Authorization": "Bearer ${loginDetails.token}"}));

//       await checkTokenExpired(response.statusCode);
//       if (response.statusCode == 200) {
//         print("downloaded");

//         customSnackbar("Success", "Downloaded Successfully", "success");
//       }
//     }
//   }

//   Future<File> storeFile(String url, List<int> bytes, String name) async {
//     var time = DateTime.now().millisecond;

//     final filename = "${name}.${time.toString()}.pdf";

//     final dir = await getApplicationDocumentsDirectory();

//     final file = File('${dir.path}/$filename');

//     await file.writeAsBytes(bytes, flush: true);

//     print(file);

//     return file;
//   }

//   sendMail(String partyId, String transactionID, String transactionTypeId) async {
//     // isPageLoading.value = true;
//     final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

//     Fluttertoast.showToast(
//         msg: "Sending...",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         textColor: kColorblack,
//         backgroundColor: kColorgreyShade300);

//     final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
//     final loginDetails = LoginModel.fromJson(logindecoded);

//     Dio dio = Dio();

//     var apiData = "${baseUrl + sendEmailUrl + partyId}/$transactionID/$transactionTypeId";

//     print(apiData);

//     try {
//       final response = await dio.get(apiData, options: Options(headers: {"Authorization": "Bearer ${loginDetails.token}"}));

//       print(response.data);
//       print(response.statusCode);

//       // Assuming that the API response is in JSON format and has 'responseStatus' key
//       final responseData = response.data as Map<String, dynamic>;
//       final responseStatus = responseData['responseStatus'] as int;

//       if (responseStatus == 1) {
//         print("success");
//         customSnackbar("Success", "${responseData['responseString']}", "success");
//       } else {
//         customSnackbar("Error", "${responseData['responseString']}", "error");
//       }
//     } on DioException catch (e) {
//       await checkTokenExpired(e.response!.statusCode);
//       await checkTokenExpired(e.response!.statusCode);
//       print(e.response!.data);
//       isPageLoading.value = false;
//     } finally {
//       isPageLoading.value = false;
//     }
//   }

//   deleteQuotationList(
//     bool isPopup,
//     GetQuotationListModel? SavedQuotationResult,
//   ) async {
//     final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

//     final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
//     final loginDetails = LoginModel.fromJson(logindecoded);

//     var item = SavedQuotationResult!.id;

//     Dio dio = Dio();

//     var apiData = baseUrl + quotationUrl + "/" + item!;

//     print(apiData);

//     try {
//       final response = await dio.delete(apiData, options: Options(headers: {"Authorization": "Bearer ${loginDetails.token}"}));

//       await checkTokenExpired(response.statusCode);
//       if (response.statusCode == 200) {
//         // isPopup == true ? Get.off(() => QuotationScreen(), transition: Transition.fade, duration: Duration(milliseconds: 600)) : null;
//         print("successfully deleted");
//         customSnackbar("Deleted", "Quotation has been deleted", "success");

//         getQuotationList("", 1, "desc", "quotationDate", "", false, financialYearId.value);
//       }
//       print(response.statusCode);
//     } on DioException catch (e) {
//       await checkTokenExpired(e.response!.statusCode);
//       print(e);
//     }
//   }

//   //------------------------------------------------this commented code is not working---------------------------------

//   //get image from the material

//   // Future<Uint8List> getMaterialImage1() async {

//   //   // var imageName = getMaterialImage(materialId);

//   //   String imageUrl = 'https://api.test.brainibooks.com/core-erp/api/files/material/default-product-image.png';

//   //   try {
//   //     dynamic imageResponse = await apiCallService(imageUrl, 'GET', {}, TheResponseType.bytes, false);

//   //     Uint8List imageData = Uint8List.fromList(imageResponse);

//   //     print('Image data received successfully');
//   //     return imageData;
//   //   } catch (e) {
//   //     // Handle errors and return an empty Uint8List or null based on your requirements
//   //     print('Error fetching image data: $e');
//   //     return Uint8List(0); // or return null;
//   //   }
//   // }

//   bool isDefaultImage = false;
//   Future<Uint8List> getMaterialImage(int MaterialId) async {
//     final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

//     final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
//     final loginDetails = LoginModel.fromJson(logindecoded);

//     String imageName = await getMaterialImageName(MaterialId);

//     String imageUrl = baseUrl + '/files/material/$imageName';

//     try {
//       final response = await Dio().get(imageUrl,
//           options: Options(
//               responseType: ResponseType.bytes,
//               headers: {"Authorization": "Bearer ${loginDetails.token}", "content-type": "application/json"}));

//       // Assuming that 'imageData' is the key in your response containing image data
//       Uint8List imageData = Uint8List.fromList(response.data);
//       print('Image data received successfully');
//       return imageData;
//     } catch (e) {
//       // Handle errors and return an empty Uint8List or null based on your requirements
//       print('Error fetching image data: $e');
//       return Uint8List(0); // or return null;
//     }
//   }

//   getMaterialImageName(int materialId) async {
//     String? responseValue;

//     var api = materialImageNameUrl + "/$materialId";

//     try {
//       Map<String, dynamic> result =
//           await apiCallService(api, 'GET', {}, TheResponseType.map, {}, false); //--url, Method, body, responsetype, query parameter, isAuth

//       log("reponse   --- $result");
//       var value = ResponseStringModel.fromJson(result);

//       responseValue = value.responseString!;

//       if (responseValue == "default-product-image.png") {
//         isDefaultImage = true;
//       } else {
//         isDefaultImage = false;
//       }

//       log(responseValue);
//     } on DioException catch (e) {
//       await checkTokenExpired(e.response!.statusCode);
//       print('Error: $e');
//     }
//     return responseValue;
//   }
// }
