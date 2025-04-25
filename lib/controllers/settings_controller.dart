import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suktha_crm/Model/Document_wallet_model.dart';
import 'package:suktha_crm/Model/bank_model.dart';
import 'package:suktha_crm/Model/city_model.dart';
import 'package:suktha_crm/Model/company_model.dart';
import 'package:suktha_crm/Model/company_profile_model.dart';
import 'package:suktha_crm/Model/currency_model.dart';
import 'package:suktha_crm/Model/department_model.dart';
import 'package:suktha_crm/Model/designation_model.dart';
import 'package:suktha_crm/Model/login_model.dart';
import 'package:suktha_crm/Model/response_string_model.dart';
import 'package:suktha_crm/Model/transaction_number.dart';
import 'package:suktha_crm/Model/user_model.dart';
import 'package:suktha_crm/Model/user_role_model.dart';
import 'package:suktha_crm/controllers/global_controller.dart';
import 'package:suktha_crm/utils/api/common_api.dart';
import 'package:suktha_crm/utils/api/login.dart';
import 'package:suktha_crm/utils/check_token_expired.dart';
import 'package:suktha_crm/view/screens/login/login_screen.dart';
import 'package:suktha_crm/view/widget/snackbar.dart';
import '../../../../../Model/login_model.dart' as login;
import '../../../Constants/shared_pref_keys.dart';
import '../../../utils/Services/rest_api_services.dart';

class SettingsController extends GetxController {
  @override
  void onInit() async {
    print("settings controller init");
    super.onInit();
    // getCompanyDetails();
    getPartyBankDetails();
    getCompanyCertificationImage();
    getcurrencyDetails();
    getCityList();
    getBranchAdminList();
    getCompanyQrCode();
    getCompanySignatureImage();
  }

  TextEditingController primaryMobNumController = TextEditingController();
  TextEditingController seconMobileController = TextEditingController();
  TextEditingController contactPersonNumController = TextEditingController();
  TextEditingController contactPersonController = TextEditingController();
  TextEditingController primaryTelephoneNumController = TextEditingController();
  TextEditingController secondaryTelephoneNumController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController faxNumController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController taglineController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController printFooterController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController panNumController = TextEditingController();
  TextEditingController iecCodeController = TextEditingController();
  TextEditingController msmeNumController = TextEditingController();
  TextEditingController cinNumController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController aCController = TextEditingController();
  TextEditingController bankADCode = TextEditingController();
  TextEditingController swiftCode = TextEditingController();
  TextEditingController deleteACreasonController = TextEditingController();
  TextEditingController branchAdminController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController namecontactListController = TextEditingController();
  TextEditingController emailContactListController = TextEditingController();
  TextEditingController primaryPhoneNumontactListController = TextEditingController();
  TextEditingController secPhoneNumontactListController = TextEditingController();
  TextEditingController remarkContactController = TextEditingController();

  RxBool contactListExpand = false.obs;
  RxBool moreDetailsExpand = false.obs;
  RxBool companyLegalInfoExpand = false.obs;
  RxBool isDefault = false.obs;
  RxBool isFromSettings = false.obs;

  CompanyModel? companyDetailsValue;

  getCompanyDetails() async {
    print("1223456");
    Map<String, dynamic> response = await apiCallService("/company/1", "GET", {}, TheResponseType.map, {}, false);

    companyDetailsValue = CompanyModel.fromJson(response);

    print(companyDetailsValue!.address ?? "");
  }

  RxInt isalreadyDefault = 0.obs;

  RxList<PartyBankMapDTOList> partyBankList = <PartyBankMapDTOList>[].obs;

  getPartyBankDetails() async {
    Map<String, dynamic> response = await apiCallService("/company-with-bank/1", "GET", {}, TheResponseType.map, {}, false);
    print(response);

    List<dynamic> bankJson = response["partyBankMapDTOList"];
    List<dynamic> branchJson = response["branchDTOList"];

    List<BranchDTOList> branchDetails = branchJson.map((e) => BranchDTOList.fromJson(e)).toList();
    partyBranchItems.value = branchDetails;
    List<PartyBankMapDTOList> bankDetails = bankJson.map((e) => PartyBankMapDTOList.fromJson(e)).toList();
    partyBankList.value = bankDetails;
    print("bank details ---- $partyBankList");
    partyBranchItems.value = branchDetails;
    print("branch details ---- $partyBranchItems");
    partyBranchItems.refresh();
    partyBankList.refresh();
  }

  RxList<CurrencyModel> currencyList = <CurrencyModel>[].obs;
  RxList<BankModel> bankList = <BankModel>[].obs;
  RxList<DesignationModel> designationList = <DesignationModel>[].obs;

  RxList<DepartmentModel> departmentList = <DepartmentModel>[].obs;
  RxList<DocumentWalletModel> documentWalletList = <DocumentWalletModel>[].obs;

  RxBool checkboxValue1 = false.obs;
  RxBool checkboxValue2 = false.obs;
  RxBool checkboxValue3 = false.obs;
  RxBool checkboxValue4 = false.obs;
  RxBool checkboxValue5 = false.obs;
  RxBool checkboxValue6 = false.obs;
  RxBool otherClicked = false.obs;

  RxString documentwallertId = "".obs;
  RxString selectedValue = ''.obs;

  RxString currencyId = "".obs;
  RxString currencyName = "".obs;
  RxString shortName = "".obs;
  RxList<CityModel> cityList = <CityModel>[].obs;
  RxString cityId = "".obs;
  RxString cityName = "".obs;
  RxString departmentId = "".obs;
  RxString designationId = "".obs;
  RxString branchId = "".obs;
  RxString selectedBranchId = "".obs;

  RxBool isLoading = false.obs;

  BankModel? bankValue;
  DepartmentModel? departmentValue;
  DesignationModel? designationValue;

  login.LoginModel? loginDetails;

  RxInt roleTypeId = 0.obs;

  // getLoginDetails() async {
  //   final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   final logindecoded = json.decode(sharedPreferences.getString("userMap")!);
  //   loginDetails = login.LoginModel.fromJson(logindecoded);
  //   print("User ID: ${loginDetails!.user!.id}");

  //   if (loginDetails!.user!.roles != null) {
  //     for (var role in loginDetails!.user!.roles!) {
  //       print("user role id---1--${role.roleType!.id}");

  //       roleTypeId.value = role.roleType!.id!;
  //     }
  //   }
  // }

  Future<List<DocumentWalletModel>> getDocumentWalletList() async {
    isLoading.value = true;
    List<dynamic> responseValue = await apiCallService("/files/multipleFile/0", 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
    List<DocumentWalletModel> documentWallet = (responseValue).map((e) => DocumentWalletModel.fromJson(e)).toList();
    isLoading.value = false;
    documentWalletList.value = documentWallet;
    documentWalletList.refresh();
    return documentWalletList;
  }

  Future<List<DesignationModel>> getDesignationList() async {
    List<dynamic> responseValue = await apiCallService("/designations", 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
    List<DesignationModel> designation = (responseValue).map((e) => DesignationModel.fromJson(e)).toList();
    designationList.value = designation;
    designationList.refresh();

    return designationList;
  }

  Future<List<DepartmentModel>> getDepartmentList() async {
    List<dynamic> responseValue = await apiCallService("/departments", 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
    List<DepartmentModel> department = (responseValue).map((e) => DepartmentModel.fromJson(e)).toList();

    departmentList.value = department;
    departmentList.refresh();

    return departmentList;
  }

  Future<List<BankModel>> getBankList(String query) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    print(token);

    Dio dio = Dio();

    var apiData = (baseUrl + '/banks');

    try {
      final response = await dio.get(apiData, options: Options(headers: {"Authorization": "Bearer $token"}));

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        List<BankModel> result = (response.data as List).map((e) => BankModel.fromJson(e)).toList();

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

  getcurrencyDetails() async {
    List<dynamic> response = await apiCallService("/currency", "GET", {}, TheResponseType.list, {}, false);
    List<CurrencyModel> result = response.map((e) => CurrencyModel.fromJson(e)).toList();
    currencyList.value = result.toList();
    print("result currency----- $currencyList");
    currencyList.refresh();
  }

  getCityList() async {
    List<dynamic> responseValue = await apiCallService("/city", 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
    List<CityModel> city = (responseValue).map((e) => CityModel.fromJson(e)).toList();

    cityList.value = city;
    cityList.refresh();

    return cityList;
  }

  RxList<UserModel> userList = <UserModel>[].obs;
//ALSO FOR LEAD- OWNER
  getUserList() async {
    print("role id of branch admin --${roleTypeIds}");
    List<dynamic> responseValue = await apiCallService("/users", 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
    List<UserModel> user = (responseValue).map((e) => UserModel.fromJson(e)).toList();

    userList.value = user.where((element) => element.roleIds!.any((roleId) => roleTypeIds.contains(roleId))).toList();
    userList.refresh();
    print("user list---${userList.length}");

    return userList;
  }

  RxList<UserRoleModel> branchList = <UserRoleModel>[].obs;
  RxList<int> roleTypeIds = <int>[].obs; // Store multiple role IDs

  getBranchAdminList() async {
    List<dynamic> responseValue = await apiCallService("/user-roles", 'GET', {}, TheResponseType.list, {}, false); //--url, Method, body, responsetype, query parameter, isAuth
    List<UserRoleModel> branch = (responseValue).map((e) => UserRoleModel.fromJson(e)).toList();
    print("role type ---$roleTypeId");
    roleTypeIds.value = branch.where((element) => element.roleTypeId == 4).map((element) => element.id!).toList();
    print("branch admin dETAILS--${roleTypeIds}");

    await getUserList();
    // branchList.refresh();

    // return branchList;
  }

  RxList<CompanyyProfileDetailsModel> saveCompanyItems = <CompanyyProfileDetailsModel>[].obs;
  RxList<PartyContactDetails> partyContactItems = <PartyContactDetails>[].obs;
  RxList<BranchDTOList> partyBranchItems = <BranchDTOList>[].obs;
  RxList<int> deletedbranchIds = <int>[].obs;
  Future<List<CompanyyProfileDetailsModel>> saveCompanyDetails(List<int> deletedIds) async {
    String apiUrl = "/company";

    print("apiUrl-----------save----- $apiUrl");
    print("bank-----------save----- $partyBankList");
    print("company-----------save----- ${companyDetailsValue?.toJson() ?? ""}");

    Map mapdatas = {
      "companyDTO": companyDetailsValue?.toJson() ?? [],
      "contactDeletedIds": [],
      "partyBankMapDTOList": partyBankList,
      "partyBankMapListDeletedIds": [],
      "partyContactDetails": partyContactItems,
      "branchDTOList": partyBranchItems,
      "branchDeletedIds": deletedIds
    };

    print("mapdatas-----$mapdatas");
    try {
      // var value = saveCompanyItems.map((element) => element.toJson()).toList();
      Map<String, dynamic> response = await apiCallService(apiUrl, "POST", mapdatas, TheResponseType.map, {}, false);
      await getCompanyDetails();
      // await getPartyBankDetails();

      print("save response----------$response");
      Get.back();
      customSnackbar("Sucessful", "Successfully saved", "success");
      deletedbranchIds.value = [];
    } catch (e) {
      customSnackbar("Error", "$e", "error");

      print(e);
    }
    return saveCompanyItems;
  }

  final ImagePicker _picker = ImagePicker();

  Future<XFile?> obtainImage({required ImageSource source}) async {
    final file = await _picker.pickImage(
      source: source,
    );

    return file;
  }

  Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf'], allowMultiple: false);
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.single;

      if (file.extension == 'pdf') {
        return File(file.path!);
        // Selected file is a PDF, proceed with further processing
        // Access the file using file.path or file.bytes
      } else {
        customSnackbar("Selected File is Not pdf", "Please Select a Pdf File", "error");
        // Selected file is not a PDF, show an error message or prompt user to select a valid PDF file
      }
    }

    update();
    return null;
  }

  Future<void> uploadDocumentWalletPdf(File file, String id) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // Decode user data from SharedPreferences
    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    // Define the URL
    String url = baseUrl + '/files/handleMultipleFile';

    print("url ---- $url");

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
      "id": 0,
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
          headers: {'Content-Type': 'multipart/form-data', "Authorization": "Bearer ${loginDetails.token}"},
        ),
      );

      print(response.data);

      await getDocumentWalletList();
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

  deleteDocument(List<String> payload) async {
    String url = "/files-multipleFileDelete";

    print('URL: $url');

    var data = json.encode(payload);
    print('Payload: $data');

    try {
      var response = await apiCallService(url, "POST", data, TheResponseType.map, {}, false);

      print(response);
      await getDocumentWalletList();
    } catch (e) {
      print("error ---- $e");
    }
  }

  uploadCompanyLogo(XFile file) async {
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        file.path,
        filename: file.name,
      ),
    });

    Map<String, dynamic> response = await apiCallService("/files/company", "POST", formData, TheResponseType.map, {}, false);

    print(response);

    await getCompanyLogoName();
  }

  getCompanyLogoName() async {
    String url = '/company/logo/1';

    try {
      Map<String, dynamic> response = await apiCallService(url, "GET", {}, TheResponseType.map, {}, false);

      final value = TransactionNumberModel.fromJson(response);

      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

      value.responseString == null ? sharedPreferences.remove(SharedPrefKeys().CompanyLogoKey) : null;

      var imageValue = await getMaterialImageName(value.responseString!);

      companyLogo.value = base64.decode(imageValue);

      String base64S = uint8ListToBase64(companyLogo.value!);

      print("logo --- setting settings controller");

      sharedPreferences.setString(SharedPrefKeys().CompanyLogoKey, base64S);
    } catch (e) {
      return Uint8List(0);
    }
  }

  uploadCertificationImage(XFile file) async {
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        file.path,
        filename: file.name,
      ),
    });

    Map<String, dynamic> response = await apiCallService("/files/company-cert-image", "POST", formData, TheResponseType.map, {}, false);

    print(response);

    await getCompanyCertificationImage();
  }

  final Rx<Uint8List?> certificateImage = Rx<Uint8List?>(null);
  getCompanyCertificationImage() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String url = '/company/cert-image/1';

    Map<String, dynamic>? response;

    try {
      response = await apiCallService(url, "GET", {}, TheResponseType.map, {}, false);
    } catch (e) {
      return Uint8List(0);
    }

    final value = TransactionNumberModel.fromJson(response!);

    if (value.responseString == null) {
      sharedPreferences.remove(SharedPrefKeys().CompanyCertificateImageKey);
    } else {
      certificateImageName.value = value.responseString ?? "";
      var imageValue = await getMaterialImageName(value.responseString!);

      certificateImage.value = base64.decode(imageValue);

      print("printing certificateImage ${certificateImage.value}");

      String base64S = uint8ListToBase64(certificateImage.value!);

      sharedPreferences.setString(SharedPrefKeys().CompanyCertificateImageKey, base64S);
    }
  }

  uploadQRcode(XFile file) async {
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        file.path,
        filename: file.name,
      ),
    });

    Map<String, dynamic> response = await apiCallService("/files/qrcode-image", "POST", formData, TheResponseType.map, {}, false);

    print(response);

    await getCompanyQrCode();
  }

  final Rx<Uint8List?> qrCodeImage = Rx<Uint8List?>(null);
  getCompanyQrCode() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String url = '/company/qr-code/1';

    Map<String, dynamic>? response;

    try {
      response = await apiCallService(url, "GET", {}, TheResponseType.map, {}, false);
    } catch (e) {
      return Uint8List(0);
    }

    final value = TransactionNumberModel.fromJson(response!);

    if (value.responseString == null) {
      sharedPreferences.remove(SharedPrefKeys().CompanyQrCodeKey);
    } else {
      qrCodeImageName.value = value.responseString ?? "";
      var imageValue = await getMaterialImageName(value.responseString!);

      qrCodeImage.value = base64.decode(imageValue);

      print("printing qrCodeImage ${qrCodeImage.value}");

      String base64S = uint8ListToBase64(qrCodeImage.value!);

      sharedPreferences.setString(SharedPrefKeys().CompanyQrCodeKey, base64S);
    }
  }

  uploadSignatureImage(XFile file) async {
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        file.path,
        filename: file.name,
      ),
    });

    Map<String, dynamic> response = await apiCallService("/files/signature-image", "POST", formData, TheResponseType.map, {}, false);

    print(response);

    await getCompanySignatureImage();
  }

  final Rx<Uint8List?> signatureImage = Rx<Uint8List?>(null);
  getCompanySignatureImage() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String url = '/company/signature-image/1';

    Map<String, dynamic>? response;

    try {
      response = await apiCallService(url, "GET", {}, TheResponseType.map, {}, false);
    } catch (e) {
      return Uint8List(0);
    }

    final value = TransactionNumberModel.fromJson(response!);

    if (value.responseString == null) {
      sharedPreferences.remove(SharedPrefKeys().CompanySignatureImageKey);
    } else {
      signatureImageName.value = value.responseString ?? "";
      var imageValue = await getMaterialImageName(value.responseString!);

      signatureImage.value = base64.decode(imageValue);

      print("printing signatureImage ${signatureImage.value}");

      String base64S = uint8ListToBase64(signatureImage.value!);

      sharedPreferences.setString(SharedPrefKeys().CompanySignatureImageKey, base64S);
    }
  }

  String uint8ListToBase64(Uint8List uint8List) {
    return base64Encode(uint8List);
  }

  final Rx<Uint8List?> companyLogo = Rx<Uint8List?>(null);

  Future<String> getMaterialImageName(String imageName) async {
    RxString base64String = "".obs;

    log("-image api-$imageName");

    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    String api = baseUrl + '/files/company-base64/$imageName';

    print(api);

    Dio dio = Dio();

    try {
      var response = await dio.get(api, options: Options(headers: {"Authorization": "Bearer ${loginDetails.token}", "content-type": "application/json"}));

      var value = ResponseStringModel.fromJson(response.data);
      var responseValue = value.responseString!;

      base64String.value = responseValue.split(',').last;
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    }
    return base64String.value;
  }

  RxString certificateImageName = "".obs;
  RxString signatureImageName = "".obs;
  RxString qrCodeImageName = "".obs;

  DeleteImages({required bool isCertificate, required bool isSignature, required bool isQRcode}) async {
    print("delete certificates");
    String apiUrl = isCertificate
        ? "/files-delete/company-cert/${certificateImageName.value}/1"
        : isSignature
            ? "/files-delete/signature-image/${signatureImageName.value}/1"
            : isQRcode
                ? "/files-delete/qr-code/${qrCodeImageName.value}/1"
                : "";

    Map<String, dynamic>? response;

    try {
      response = await apiCallService(apiUrl, "DELETE", {}, TheResponseType.map, {}, false);
    } catch (e) {}

    ResponseStringModel responsevalue = ResponseStringModel.fromJson(response!);

    print(responsevalue.responseString);

    if (responsevalue.responseStatus == 1) {}
  }

  DeleteAccount({required String username}) async {
    Map<String, dynamic> responseValue =
        await apiCallService(deleteAccountUrl + "/$username", 'DELETE', {}, TheResponseType.map, {}, true); //--url, Method, body, responsetype, query parameter, isAuth

    print(responseValue['responseString']);

    await deleteCacheDir();
    await deleteAppDir();

    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.clear();

    sharedPreferences.setBool("onboardKey", true);

    customSnackbar("Success", "Your account successfully deleted", "success");

    Get.offAll(() => LoginPage(), transition: Transition.fade, duration: const Duration(milliseconds: 1000));
  }

  Future<void> deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  /// this will delete app's storage
  Future<void> deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }

  Future logoutData() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);

    Dio dio = Dio();
    var apiData = (baseUrl + "/logout");

    print("${loginDetails.token}");
    print(apiData);

    try {
      final response = await dio.get(apiData, options: Options(headers: {"Authorization": "Bearer ${loginDetails.token}"}));

      print("statuscode${response.statusCode}");
      print("statuscode${response.data}");

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        /// this will delete cache

        customSnackbar("Logout Success", "You have been successfully logged Out", "success");

        print(response.data);

        await deleteCacheDir();
        await deleteAppDir();

        await sharedPreferences.clear();

        sharedPreferences.setBool("onboardKey", true);

        Get.offAll(() => LoginPage(), transition: Transition.fade, duration: const Duration(milliseconds: 1000));
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      await checkTokenExpired(e.response!.statusCode);
      print(e);
    } finally {}
  }

  final GlobalController globalController = Get.find<GlobalController>();

  RxList<dynamic> selectedSettingsName = <dynamic>[].obs;

  Set<String?> settingsName = {};

  final settingsItem = [
    // {
    //   "title": "Global Settings",
    //   "icon": Icons.settings,
    //   "screen": GlobalSettingsScreen(),
    // },
    // {
    //   "title": "Financial Year Master",
    //   "icon": Icons.calendar_month,
    //   "screen": FinancialYearScreen(),
    // },
    // {
    //   "title": "User Roles",
    //   "icon": Icons.account_circle_sharp,
    //   "screen": UserRoleScreen(),
    // },
    // {
    //   "title": "Privacy Policy",
    //   "icon": Icons.privacy_tip_rounded,
    //   "screen": WebViewScreen(
    //     title: "Privacy Policy",
    //     url: "https://suktha.com/privacy-policy/",
    //   ),
    // },
    // {
    //   "title": "Terms & Conditions",
    //   "icon": Icons.menu_book_rounded,
    //   "screen": WebViewScreen(
    //     title: "Terms & Conditions",
    //     url: "https://suktha.com/terms-conditions/",
    //   ),
    // },
    // {
    //   "title": "About Us",
    //   "icon": Icons.supervisor_account_sharp,
    //   "screen": WebViewScreen(
    //     title: "About Us",
    //     url: "https://suktha.com/about-us/",
    //   ),
    // },
  ];

  FetchTransactionItems() {
    settingsName.clear();
    for (var menuItem in globalController.menuList) {
      // print("menuitem.name ${menuItem.name}");
      if (menuItem.name == "Settings") {
        if (menuItem.activities != null) {
          for (var activity in menuItem.activities!) {
            print("activity -- ${activity.name}");
            settingsName.add(activity.name);
          }
        }
      }
    }

    selectedSettingsName.value = settingsItem.where((item) => settingsName.contains(item['title'])).toList();

    selectedSettingsName.addAll(
      settingsItem.where((item) => item['title'] == "Privacy Policy" || item['title'] == "Terms & Conditions" || item['title'] == "About Us").toList(),
    );

    print("reports item - ${selectedSettingsName}");
  }
}
