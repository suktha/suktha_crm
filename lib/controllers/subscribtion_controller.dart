import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suktha_crm/Model/subscribtion_detail_model.dart';
import 'package:suktha_crm/Model/subscriptionHistoryModel.dart';
import 'package:suktha_crm/utils/Services/rest_api_services.dart';

class SubscriptionController extends GetxController {
  TextEditingController subscriptionIdcontroller = TextEditingController();

  SubscriptionDetailsModel? subscriptionDetails;
  RxList<SubHistoryModel> subHistoryList = <SubHistoryModel>[].obs;

  void onInit() {
    getSubscriptionDetails();
    super.onInit();
  }

  getSubscriptionDetails() async {
    Map<String, dynamic> response = await apiCallService("/PaymentDetails", "GET", {}, TheResponseType.map, {}, false);
    print(response.toString());
    subscriptionDetails = SubscriptionDetailsModel.fromJson(response);

    print("subscription printing--${subscriptionDetails.toString()}");
  }

  Future<List<SubHistoryModel>> getSubscriptionHistoryList() async {
    try {
      List<dynamic> response = await apiCallService("/subscriptionList", "GET", {}, TheResponseType.list, {}, false);
      List<SubHistoryModel> userDatas = response.map((e) => SubHistoryModel.fromJson(e)).toList();
      subHistoryList.value = userDatas;
      subHistoryList.refresh();
      print("list data- SubHistoryModel-----${subHistoryList}");
    } catch (e) {
      print("errorrr ---$e");
    }
    return subHistoryList;
  }
}
