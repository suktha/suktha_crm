import 'package:get/get.dart';
import 'package:work_Force/utils/Services/rest_api_services.dart';
import 'package:work_Force/utils/api/home_screen.dart';
import 'package:work_Force/view/screens/home_screen/model/advance_receipt_data_model.dart';
import 'package:work_Force/view/screens/home_screen/model/last_three_invoice_model.dart';
import 'package:work_Force/view/screens/home_screen/model/moving_material_model.dart';
import 'package:work_Force/view/screens/home_screen/model/pending_amount_model.dart';

class HomeScreenTextController extends GetxController {
  RxList<LastThreeMonthInvoiceModel> lastThreeMonthInvoiceList = <LastThreeMonthInvoiceModel>[].obs;
  GetLastThreeInvoiceData() async {
    List<dynamic> response = await apiCallService(HomeScreenUrl().lastThreeMonthInvoiceAmountUrl, "GET", {}, TheResponseType.list, {}, false);

    List<LastThreeMonthInvoiceModel> expenseValue = response.map((e) => LastThreeMonthInvoiceModel.fromJson(e)).toList().reversed.toList();

    lastThreeMonthInvoiceList.value = expenseValue;
    lastThreeMonthInvoiceList.refresh();
    print(lastThreeMonthInvoiceList.length);
  }

  RxList<AdvanceReceiptDataModel> advanceReceiptDataList = <AdvanceReceiptDataModel>[].obs;
  GetAdvanceReceiptData() async {
    List<dynamic> response = await apiCallService(HomeScreenUrl().advanceReceiptDataUrl, "GET", {}, TheResponseType.list, {}, false);

    List<AdvanceReceiptDataModel> expenseValue = response.map((e) => AdvanceReceiptDataModel.fromJson(e)).toList();

    advanceReceiptDataList.value = expenseValue;
    advanceReceiptDataList.refresh();
    print(advanceReceiptDataList.length);
  }

  RxList<PendingAmountModel> customerPendingAmountList = <PendingAmountModel>[].obs;
  GetCustomerPendingAmount() async {
    List<dynamic> response = await apiCallService(HomeScreenUrl().customerDueAmountUrl, "GET", {}, TheResponseType.list, {}, false);

    List<PendingAmountModel> expenseValue = response.map((e) => PendingAmountModel.fromJson(e)).toList();

    customerPendingAmountList.value = expenseValue;
    customerPendingAmountList.refresh();
    print(customerPendingAmountList.length);
  }

  RxList<PendingAmountModel> supplierPendingAmountList = <PendingAmountModel>[].obs;
  GetSupplierPendingAmount() async {
    List<dynamic> response = await apiCallService(HomeScreenUrl().supplierDueAmountUrl, "GET", {}, TheResponseType.list, {}, false);

    List<PendingAmountModel> expenseValue = response.map((e) => PendingAmountModel.fromJson(e)).toList();

    supplierPendingAmountList.value = expenseValue;
    supplierPendingAmountList.refresh();
    print(supplierPendingAmountList.length);
  }

  RxList<MovingMaterialsModel> fastMovingMaterialList = <MovingMaterialsModel>[].obs;
  GetfastMovingMaterial() async {
    List<dynamic> response = await apiCallService(HomeScreenUrl().highestMovingMaterialUrl, "GET", {}, TheResponseType.list, {}, false);

    List<MovingMaterialsModel> expenseValue = response.map((e) => MovingMaterialsModel.fromJson(e)).toList();

    fastMovingMaterialList.value = expenseValue;
    fastMovingMaterialList.refresh();
    print(fastMovingMaterialList.length);
  }

  RxList<MovingMaterialsModel> slowMovingMaterialList = <MovingMaterialsModel>[].obs;
  GetSlowMovingMaterial() async {
    List<dynamic> response = await apiCallService(HomeScreenUrl().lowestMovingMaterialUrl, "GET", {}, TheResponseType.list, {}, false);

    List<MovingMaterialsModel> expenseValue = response.map((e) => MovingMaterialsModel.fromJson(e)).toList();

    slowMovingMaterialList.value = expenseValue;
    slowMovingMaterialList.refresh();
    print(slowMovingMaterialList.length);
  }
}
