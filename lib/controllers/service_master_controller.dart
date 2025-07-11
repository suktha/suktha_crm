// ignore_for_file: sort_child_properties_last, use_build_context_synchronously, avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work_Force/Model/UOM_model.dart';
import 'package:work_Force/Model/login_model.dart';
import 'package:work_Force/Model/serviceStatusModel.dart';
import 'package:work_Force/Model/service_category_model.dart';
import 'package:work_Force/Model/service_execution_model.dart';
import 'package:work_Force/Model/service_material_model.dart';
import 'package:work_Force/Model/subscription_based_service_model.dart';
import 'package:work_Force/Model/taxes_model.dart';
import 'package:work_Force/Model/user_model.dart';
import 'package:work_Force/utils/Services/rest_api_services.dart';
import 'package:work_Force/utils/api/common_api.dart';
import 'package:work_Force/utils/check_token_expired.dart';
import 'package:work_Force/view/screens/My_account/more_module/Masters/Masters%20Items/Service%20Master/View%20Service%20Master/list_service_master.dart';
import 'package:work_Force/view/widget/custom_popup_with_widget.dart';
import 'package:work_Force/view/widget/snackbar.dart';
import '../Model/material_list_model.dart';

class ServiceMasterController extends GetxController {
  late TextEditingController nameController,
      commissionController,
      sacController,
      uomController,
      serviceChargeController,
      taxController,
      serviecStatusController,
      descriptionController,
      qualifiedTeamMembercontroller,
      serviceExecutiModeController,
      categoryController,
      startDateController,
      endDateController,
      serviceFrequencyController,
      serviceFrequencyCountController,
      estimatedExecutionController,
      commentsController,
      availablityController;
// TextEditingController
  @override
  void onInit() {
    super.onInit();

    nameController = TextEditingController();
    commentsController = TextEditingController();
    commissionController = TextEditingController();
    sacController = TextEditingController();
    uomController = TextEditingController();
    serviceChargeController = TextEditingController();
    taxController = TextEditingController();
    categoryController = TextEditingController();
    endDateController = TextEditingController();
    startDateController = TextEditingController();
    serviceFrequencyCountController = TextEditingController();
    serviceFrequencyController = TextEditingController();
    estimatedExecutionController = TextEditingController();
    serviecStatusController = TextEditingController();
    descriptionController = TextEditingController();
    qualifiedTeamMembercontroller = TextEditingController();
    serviceExecutiModeController = TextEditingController();
    availablityController = TextEditingController();
    getServiceStatus();
    getServiceCategory();
    getServiceExecution();
    getServiceAvailablity();
    getTeamMemberList();
    getUnitLists("");
  }

  RxList<UOMGetModel> unitList = <UOMGetModel>[].obs;
  RxList<UOMGetModel> timeSpanList = <UOMGetModel>[].obs;
  RxList<SubscriptionBasedServices> subscriptionList =
      <SubscriptionBasedServices>[].obs;

  RxList<TaxesModel> taxList = <TaxesModel>[].obs;
  RxList<GetServiceStatusModel> serviceStatusList =
      <GetServiceStatusModel>[].obs;
  RxList<GetServiceCategoryModel> serviceCategoryList =
      <GetServiceCategoryModel>[].obs;
  RxList<GetServiceExecutionModel> serviceExecutionList =
      <GetServiceExecutionModel>[].obs;
  RxList<GetServiceExecutionModel> serviceAvailablityList =
      <GetServiceExecutionModel>[].obs;
  RxList<UserModel> selectedTeamMember = <UserModel>[].obs;
  RxList<UserModel> teamMemberList = <UserModel>[].obs;

  MaterialListModel? saveMaterailValue;
  ServiceMaterialListModel? saveMaterialValue;

  Map? mapvalue;

  RxBool supplyType = false.obs;
  RxBool ifTaxSelected = false.obs;
  RxBool ifUnitSelected = false.obs;
  RxBool inclusiveTaxIschecked = false.obs;
  RxString taxeS = "".obs;
  var startDate = Rx<DateTime?>(null);
  var endDate = Rx<DateTime?>(null);
  RxInt serviceStatusId = 1.obs;
  RxInt taxId = 0.obs;
  RxInt executionId = 0.obs;
  RxInt timeSpanId = 0.obs;

  RxInt availablityId = 1.obs;
  RxString teamMemberId = "".obs;

  RxInt categoryId = 0.obs;

  RxDouble taxRate = 0.0.obs;
  int? unitId;
  RxString inclusiveTaxAmount = "".obs;
  RxString inclusiveTaxRate = "".obs;
  RxBool nocustomerFound = false.obs;
  RxBool customerSelected = false.obs;
  RxBool uploadImage = false.obs;

  RxString poParty = "".obs;
  RxString poid = "".obs;
  String? currencyVal;
  RxBool isOpenEnded = false.obs;

  RxBool isPageLoading = false.obs;
  RxBool isOneTime = false.obs;
  RxBool isdefault = false.obs;
  RxBool isAlreadyDefault = false.obs;

  RxString selectedOption = 'One Time'.obs;

  // Function to change selected option
  void setOption(String option) {
    selectedOption.value = option;
    print("selected option -=${selectedOption.value}");
  }

  Rx<File?> selectedImage = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();
  RxBool isLoading = false.obs;

  Future<File?> obtainImage(
      {required ImageSource source, required dynamic id}) async {
    final file = await _picker.pickImage(source: source);

    if (file != null) {
      isLoading.value = true;

      selectedImage.value = File(file.path);
      await uploadImageToServer(File(file.path), id);
    } else if (file == null) {
      customSnackbar(
        "Alert",
        'No image selected',
        "normal",
      );

      return null;
    }

    return null;
  }

  initializeDefaultState() {
    print("init default ");
    for (var i = 0; i < subscriptionList.length; i++) {
      print("default --${subscriptionList[i].isDefault}");
      if (subscriptionList[i].isDefault == 1) {
        isdefault.value = true; // Set to true for the default item
        break;
      }
    }
  }

  deleteImage(String imageName, var Id) async {
    try {
      final response = await apiCallService(
          "/files-delete/material/$imageName/1/$Id",
          "DELETE",
          {},
          TheResponseType.map,
          {},
          false);

      if (response['responseStatus'] == 1) {
        print("successfully deleted");
        selectedImage.value = null;
        uploadImage.value = false;

        customSnackbar("Deleted", response['responseString'], "error");
      } else {
        customSnackbar("Error", response['responseString'], "error");
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      print(e);
    }
  }

  RxString fileName = "".obs;

  getImageById(var id) async {
    print("image --$id");
    try {
      Map<String, dynamic> response = await apiCallService(
          "/material/image/$id", "GET", {}, TheResponseType.list, {}, false);
      print(
          "list data- serviceAvailablityList  -----${response["responseString"]}");
      fileName.value = response["responseString"];
      // uploadedImageUrl.value = filename;
      // uploadImage.value = true;

      await showImageByFileName(fileName);
    } catch (e) {
      print("errorrr --get image-$e");
    }
    // return serviceAvailablityList;
  }

  Rx<Uint8List> uploadedImageBytes = Uint8List(0).obs;

  showImageByFileName(var fileName) async {
    print("image --$fileName");
    try {
      Uint8List response = await apiCallService("/files/material/$fileName",
          "GET", {}, TheResponseType.bytes, {}, false);
      print("list data- serviceAvailablityList  -----${response.toString()}");
      var filename = response;
      uploadedImageBytes.value = filename;
      uploadImage.value = true;

      // await showImage(filename);
    } catch (e) {
      print("errorrr --shw image by file name-$e");
    }
  }

  showImage(String fileName) async {
    try {
      Map<String, dynamic> response = await apiCallService(
          "/files/material-base64/$fileName",
          "GET",
          {},
          TheResponseType.list,
          {},
          false);
      print(
          "list data- serviceAvailablityList  -----${response["responseString"]}");
      // uploadedImageUrl.value = response["responseString"];

      // uploadImage.value = true;

      // print("uploaded ---${uploadedImageUrl.value}");
    } catch (e) {
      print("errorrr ---$e");
    }
  }

  Future<List<UOMGetModel>> getUnitLists(String query) async {
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
        List<UOMGetModel> result = (response.data as List)
            .map((e) => UOMGetModel.fromJson(e))
            .toList();

        unitList.value = result.where(
          (element) {
            return element.isSubscriptionBasedService == 0;
          },
        ).toList();
        unitList.refresh();

        // timeSpanList.value = result.where(
        //   (element) {
        //     return element.isSubscriptionBasedService == 1;
        //   },
        // ).toList();
        // timeSpanList.refresh();
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return unitList;
  }

  Future<List<UOMGetModel>> gettimeSpanList(String query) async {
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
        List<UOMGetModel> result = (response.data as List)
            .map((e) => UOMGetModel.fromJson(e))
            .toList();

        // unitList.value = result.where(
        //   (element) {
        //     return element.isSubscriptionBasedService == 0;
        //   },
        // ).toList();
        // unitList.refresh();

        timeSpanList.value = result.where(
          (element) {
            return element.isSubscriptionBasedService == 1;
          },
        ).toList();
        timeSpanList.refresh();
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
    } finally {}
    return timeSpanList;
  }

  Future<List<GetServiceStatusModel>> getServiceStatus() async {
    try {
      List<dynamic> response = await apiCallService(
          "/getAllServiceStatus", "GET", {}, TheResponseType.map, {}, false);
      List<GetServiceStatusModel> userDatas =
          response.map((e) => GetServiceStatusModel.fromJson(e)).toList();
      serviceStatusList.value = userDatas;
      serviceStatusList.refresh();
      print("list data- serviceStatusList  -----$serviceStatusList");
      serviceStatusId.value = serviceStatusList[0].id ?? 0;
      serviecStatusController.text = serviceStatusList[0].name ?? "";

      print("service id --${serviceStatusId.value}");
    } catch (e) {
      print("errorrr ---$e");
    }
    return serviceStatusList;
  }

  Future<List<GetServiceExecutionModel>> getServiceExecution() async {
    try {
      List<dynamic> response = await apiCallService(
          "/getAllServiceExeMode", "GET", {}, TheResponseType.map, {}, false);
      List<GetServiceExecutionModel> userDatas =
          response.map((e) => GetServiceExecutionModel.fromJson(e)).toList();
      serviceExecutionList.value = userDatas;
      serviceExecutionList.refresh();
      print("list data- serviceExecutionList  -----$serviceExecutionList");
    } catch (e) {
      print("errorrr ---$e");
    }
    return serviceExecutionList;
  }

  Future<List<GetServiceExecutionModel>> getServiceAvailablity() async {
    try {
      List<dynamic> response = await apiCallService(
          "/getAllServiceAvailability",
          "GET",
          {},
          TheResponseType.map,
          {},
          false);
      List<GetServiceExecutionModel> userDatas =
          response.map((e) => GetServiceExecutionModel.fromJson(e)).toList();
      serviceAvailablityList.value = userDatas;
      serviceAvailablityList.refresh();
      availablityId.value = serviceAvailablityList[0].id ?? 0;
      availablityController.text = serviceAvailablityList[0].name ?? "";
      print("list data- serviceAvailablityList  -----$serviceAvailablityList");
    } catch (e) {
      print("errorrr ---$e");
    }
    return serviceAvailablityList;
  }

  Future<List<GetServiceCategoryModel>> getServiceCategory() async {
    try {
      List<dynamic> response = await apiCallService(
          "/materialCategory", "GET", {}, TheResponseType.map, {}, false);
      List<GetServiceCategoryModel> userDatas =
          response.map((e) => GetServiceCategoryModel.fromJson(e)).toList();
      serviceCategoryList.value = userDatas;
      serviceCategoryList.refresh();
      print("list data- serviceCategoryList  -----$serviceCategoryList");
    } catch (e) {
      print("errorrr ---$e");
    }
    return serviceCategoryList;
  }

  getTeamMemberList() async {
    List<dynamic> responseValue = await apiCallService(
        "/users",
        'GET',
        {},
        TheResponseType.list,
        {},
        false); //--url, Method, body, responsetype, query parameter, isAuth
    List<UserModel> user =
        (responseValue).map((e) => UserModel.fromJson(e)).toList();

    teamMemberList.value = user
        .where(
          (element) => element.id != 9999,
        )
        .toList();
    teamMemberList.refresh();
    print("user list---${teamMemberList.length}");

    return teamMemberList;
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

  uploadImageToServer(File file, var id) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    final loginDetails = LoginModel.fromJson(logindecoded);
    Dio dio = Dio();

    String url = baseUrl + '/files/material';

    print("url ---- $url");

    var fileName = file.path.split('/').last;
    print("Filename: $fileName");

    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
        contentType: MediaType("application", "octet-stream"),
      ),
      "id": id
    });
    final headers = {
      "Authorization": "Bearer ${loginDetails.token}",
      'Content-Type': 'multipart/form-data',
    };

    // print("id ------------ $id");

    try {
      final response = await dio.post(
        url,
        data: formData,
        options: Options(headers: headers),
      );

      print(response.data);
      isLoading.value = false;

      customSnackbar("Success", "uploaded successfully", "success");

      print("Upload completed.");

      await getImageById(id);

      await checkTokenExpired(response.statusCode);

      print("Response: ${response.data}");
    } catch (e) {
      print("Error occurred during upload:");
      print("Error: $e");
    }
  }

  checkName(
    String name,
    String id,
    bool? isFromLead,
    BuildContext context,
  ) async {
    List<dynamic> response = await apiCallService(
        "/check-name?name=$name&id=$id",
        "GET",
        {},
        TheResponseType.map,
        {},
        false);

    if (response.isNotEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return CustomPopup(
                children: [
                  Text(
                    "Service with similar name already exists. Do you want to save?",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.grey.shade600),
                  )
                ],
                title: "Name Exist",
                onCancelPressed: () {
                  Get.back();
                },
                onUpdatePressed: () {
                  saveServiceMaster(isFromLead);
                },
                saveButtonText: "Confirm");
          });

      print("response --|$response");
    } else {
      saveServiceMaster(isFromLead);
    }
  }

  Future saveServiceMaster(bool? isFromLead) async {
    print(serviceChargeController.text);
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString('token');

    Map map = saveMaterialValue!.toJson();

    print("save service map $map");

    var mapdatas = jsonEncode(map);

    log("ajith-----------sending dataaaa-------1------${mapdatas.toString()}");

    var apiData = baseUrl + "/material";

    print(apiData);

    try {
      final response = await http.post(
        Uri.parse(apiData),
        body: mapdatas,
        headers: {
          "Authorization": "Bearer $token",
          "content-type": "application/json",
        },
      );

      // print("this is status code ${response.body}");

      print(
          "ajith--------------------response dataaa a---2----------${response.body}");
      print(
          "ajith--------------------response dataaa a-----2--------${response.statusCode}");

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        ServiceMaterialListModel value =
            ServiceMaterialListModel.fromJson(jsonDecode(response.body));

        // print("this is status code ${response.body}");

        print(
            "while going to saved -------------------------------------------------------");

        customSnackbar("Success", "successfully Saved", "success");

   
        Get.offAll(() => ServiceMasterScreen(),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 600));
      } else {
        customSnackbar("error", "Service Master is not Saved", "error");
        print(response.statusCode);
        isPageLoading.value = false;
      }
    } on DioException catch (e) {
      await checkTokenExpired(e.response!.statusCode);
      print("step 5");
      print("errorr-----$e");
    } finally {
      isPageLoading.value = false;
    }
  }

  Future updateServiceMaster(
      bool isSavedValue,
      int? index,
      ServiceMaterialListModel? serviceMasterSavedValue,
      List<ServiceMaterialListModel>? getList) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString('token');

    Map map = saveMaterailValue!.toJson();

    print(map);

    var mapdatas = jsonEncode(map);

    log("ajith-----------sending dataaaa-------------${mapdatas.toString()}");

    var apiData = baseUrl + "/material";

    // print(apiData);

    try {
      final response = await http.post(
        Uri.parse(apiData),
        body: mapdatas,
        headers: {
          "Authorization": "Bearer $token",
          "content-type": "application/json"
        },
      );

      // print("this is status code ${response.body}");

      print(
          "ajith--------------------response dataaa a-------------${response.body}");
      print(
          "ajith--------------------response dataaa a-------------${response.statusCode}");

      await checkTokenExpired(response.statusCode);
      if (response.statusCode == 200) {
        ServiceMaterialListModel value =
            ServiceMaterialListModel.fromJson(jsonDecode(response.body));

        // print("this is status code ${response.body}");

        print(
            "while going to saved -------------------------------------------------------");

        customSnackbar("Success", "successfully Saved", "success");

        Get.offAll(() => ServiceMasterScreen(),
            transition: Transition.fade,
            duration: const Duration(milliseconds: 600));
      } else {
        customSnackbar("error", "Service Master is not Saved", "error");
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
}
