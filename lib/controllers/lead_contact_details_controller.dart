// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:suktha_crm/Model/lead_model.dart';
import 'package:suktha_crm/utils/Services/contact_services.dart';
import 'package:suktha_crm/utils/Services/rest_api_services.dart';
import 'package:suktha_crm/view/screens/pre_sales/lead_managment/view_lead_managment/view_lead_management.dart';
import 'package:suktha_crm/view/widget/snackbar.dart';

class LeadContactDetaisController extends GetxController {
  RxList<Map<String, String>> contactsList = <Map<String, String>>[].obs;
  RxList<Map<String, String>> filteredContacts = <Map<String, String>>[].obs;
  RxList<Map<String, String>> selectedContacts = <Map<String, String>>[].obs;
  RxList<LeadModel> leadList = <LeadModel>[].obs;
  RxList<LeadModel> filteredLeadList = <LeadModel>[].obs;

  var contactNames = <String>[].obs;
  var contactNumbers = <String>[].obs;

  TextEditingController searchController = TextEditingController();

  RxBool isSearchClicked = false.obs;
  RxBool isListLoading = true.obs;
  RxList<bool> isMandatoryFieldAdded = <bool>[].obs;

  // For handling checking the mandatory field selected
  void updateMandatoryIndex(int index) {
    // Set all items to false first
    for (int i = 0; i < isMandatoryFieldAdded.length; i++) {
      if (i != index) {
        isMandatoryFieldAdded[i] = false; // Set all others to false
      }
    } // Set the clicked item to true
    isMandatoryFieldAdded[index] = true;
  }

  Future<void> fetchContacts() async {
    getContacts();
  }

  // Fetch contacts from device
  Future<void> getContacts() async {
    PermissionStatus status = await Permission.contacts.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      // Request permission
      status = await Permission.contacts.request();
    }

    if (status.isGranted) {
      // Fetch contacts if permission is granted
      Iterable<Map<String, String>> contacts = await ContactService.getContacts();

      contactsList.value = contacts.toList();
      filteredContacts.value = contactsList;
      isMandatoryFieldAdded.assignAll(List.generate(filteredContacts.length, (index) => false));

      print("contact list -----$contactsList");
      isListLoading.value = false;
    } else {
      // Show an error if permission is denied
      customSnackbar("Permission Denied", "Please enable contact permissions", "error");
    }
  }

  // Filter contacts based on search query
  void filterContact(String query) {
    if (query.isEmpty) {
      filteredContacts.value = contactsList;
    } else {
      filteredContacts.value = contactsList.where((contact) {
        final nameMatches = contact['name']?.toLowerCase().contains(query.toLowerCase()) ?? false;
        final phoneMatches = contact['phone']?.replaceAll(RegExp(r'\s+'), '').contains(query.replaceAll(RegExp(r'\s+'), '')) ?? false;
        return nameMatches || phoneMatches;
      }).toList();
    }
  }

  // Clean the phone number to match a proper format
  String cleanPhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return '';
    }
    // Remove all non-digit characters (including spaces, dashes, etc.)
    String cleanedNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

    if (cleanedNumber.startsWith('94')) {
      cleanedNumber = cleanedNumber.substring(2); // Remove country code if it's '94'
    }

    return cleanedNumber;
  }

  RxBool allMandatoryFieldsAdded = false.obs;

  // Save all leads generated from contacts
  saveAllLeadFromContacts(List<LeadModel> items) async {
    if (items.isEmpty) {
      customSnackbar("No Contacts", "Please select at least one contact", "error");
    } else {
      print("items from contacts ${items.toString()}");
      var values = items.map((e) => e.toJson()).toList();
      values.forEach((lead) {
        print(lead);
      });
      print('Leads Added: ${leadList.length}');
      try {
        List<dynamic> response = await apiCallService("/saveAllLeadGen", "POST", values, TheResponseType.list, {}, false);
        print("response ---$response");
        Get.offAll(() => LeadManagementListScreen());
        customSnackbar("Success", "Lead uploaded successfully", "success");
      } catch (e) {
        print(e);
        customSnackbar("Error", "Something went wrong", "error");
      }
    }
  }
}
