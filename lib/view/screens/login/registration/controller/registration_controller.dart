import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_Force/Model/resgistration_state_model.dart';
import 'package:work_Force/utils/Services/rest_api_services.dart';
import 'package:work_Force/view/screens/login/registration/view/registration_screen.dart';
import 'package:work_Force/view/widget/snackbar.dart';

class RegistrationController extends GetxController {
  final companyNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final gstTypeController = TextEditingController();
  final gstNumberController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final nameController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  RxList<dynamic> registrationTypeList = [
    {"id": 1, "name": "Registered"},
    {"id": 2, "name": "Composition"},
    {"id": 3, "name": "Unregistered"}
  ].obs;
  RxString selectedRegistrationType = "".obs;
  RxInt selectedRegistrationId = 0.obs;

  void goToNextScreen() {
    Get.to(() => const RegistrationScreen(),
        transition: Transition.rightToLeftWithFade,
        duration: const Duration(milliseconds: 600));
  }

  @override
  void onClose() {
    companyNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  RxString todaySubscriptionDateFormatted = ''.obs;
  RxString subscriptionEndDateFormatted = ''.obs;

  late DateTime todayDate;
  late DateTime subscriptionEndDate;

  String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  @override
  void onInit() {
    getRegistrationState();
    todayDate = DateTime.now();
    subscriptionEndDate = todayDate.add(const Duration(days: 30));
    todaySubscriptionDateFormatted.value = formatDate(todayDate);
    subscriptionEndDateFormatted.value = formatDate(subscriptionEndDate);
    print("Subscription End Date: ${subscriptionEndDateFormatted.value}");
    print("Today: ${todaySubscriptionDateFormatted.value}");
    super.onInit();
  }

  RxList<RegistrationStateModel> stateList = <RegistrationStateModel>[].obs;
  RxInt stateId = 0.obs;

  getRegistrationState() async {
    String apiUrl = "/userregistration/state/1";

    List<dynamic> response =
        await apiCallService(apiUrl, "GET", {}, TheResponseType.list, {}, true);

    stateList.value = response
        .map(
          (e) => RegistrationStateModel.fromJson(e),
        )
        .toList();
  }

  checkEmail(var email) async {
    try {
      Map<String, dynamic> response = await apiCallService(
          "/check-email/$email", "GET", {}, TheResponseType.map, {}, true);
      print("response -- $response");

      if (response["responseStatus"] == 1) {
        customSnackbar("Success", response["responseString"], "success");
      } else if (response["responseStatus"] == 0) {
        customSnackbar("Error", response["responseString"], "error");
        emailController.clear();
      }
    } catch (e) {
      customSnackbar("Error", "Something went wrong $e", "error");
    }
  }

  checkUsername(var username) async {
    try {
      Map<String, dynamic> response = await apiCallService(
          "/check-username/$username",
          "GET",
          {},
          TheResponseType.map,
          {},
          true);
      print("response -- $response");

      if (response["responseStatus"] == 1) {
        customSnackbar("Success", response["responseString"], "success");
      } else if (response["responseStatus"] == 0) {
        customSnackbar("Error", response["responseString"], "error");
        usernameController.clear();
      }
    } catch (e) {
      // customSnackbar("Error", "Something went wrong $e", "error");
    }
  }

  UserRegister() {
    var payload = {
      "userDTO": {
        "id": null,
        "username": usernameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "name": nameController.text,
        "currentAddress": null,
        "isLogInRequired": 1,
        "employeeNumber": null,
        "mobileNumber": phoneController.text,
        "countryId": 1,
        "stateId": stateId.value,
      },
      "companyDTO": {
        "id": null,
        "name": companyNameController.text,
        "address": addressController.text,
        "stateId": stateId.value,
        "countryId": null,
        "primaryMobile": null,
        "secondaryMobile": null,
        "email": null,
        "gstRegistrationTypeId": selectedRegistrationId.value,
        "enableJobwork": 0,
        "subscriptionStart": todaySubscriptionDateFormatted.value,
        "subscriptionEnd": subscriptionEndDateFormatted.value,
        "enableTrailAccount": 1
      },
      "enableJobwork": 0,
      "enableTrailAccount": 1,
      "agreeTermsAndCondtion": 0
    };

    print("Payload: $payload");
    String apiUrl = "/userregistration/register";
    var response = apiCallService(
      apiUrl,
      "POST",
      payload,
      TheResponseType.map,
      {},
      true,
    );
    print("Response: $response");
  }
}
