// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Model/bank_model.dart';
import 'package:work_Force/Model/company_profile_model.dart';
import 'package:work_Force/Model/expenses_model.dart';
import 'package:work_Force/Model/get_party_master_model.dart';
import 'package:work_Force/Model/material_models.dart';
import 'package:work_Force/Model/material_price_model.dart';
import 'package:work_Force/Model/party_contact_model.dart';
import 'package:work_Force/Model/party_master_list_model.dart';
import 'package:work_Force/Model/transaction_type_model.dart';
import 'package:work_Force/controllers/party_master_controller.dart';
import 'package:work_Force/utils/Date.dart';
import 'package:work_Force/view/screens/settings_module/Masters/Masters%20Items/Party%20Master/View%20Party%20Master/list_party_master.dart';
import 'package:work_Force/view/widget/LoadingScreenwithText.dart';
import 'package:work_Force/view/widget/custom_button.dart';
import 'package:work_Force/view/widget/custom_dropdown.dart';
import 'package:work_Force/view/widget/custom_popup_with_widget.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';
import 'package:work_Force/view/widget/deleteAlertDialogue.dart';
import 'package:work_Force/view/widget/material_list_custom_widgets.dart';
import 'package:work_Force/view/widget/snackbar.dart';
import 'package:work_Force/view/widget/webview.dart';
import '../../../../../../../Model/type_model.dart';

class SavePartyMasterScreen extends StatefulWidget {
  final bool isEdit;

  List<PartyMasterListModel>? getList;
  List<PartyContactDetails>? contactList;

  PartyDTO? partyMasterSaved;
  List<MaterialPriceListDTOList>? priceList;
  List<PartyBankMapDTOList>? bankList;
  List<TermsAndConditions>? termsAndConditionValue;

  SavePartyMasterScreen({
    super.key,
    required this.isEdit,
    this.priceList,
    this.contactList,
    this.bankList,
    this.termsAndConditionValue,
    this.partyMasterSaved,
  });

  @override
  State<SavePartyMasterScreen> createState() => _SavePartyMasterScreenState();
}

class _SavePartyMasterScreenState extends State<SavePartyMasterScreen> {
  ExpensesModel? expenseHeader;

  final controller = Get.put(PartyMasterController());
  // final taxcontroller = Get.put(GetTaxInvoiceController());
  // final cashVouchercontroller = Get.put(GetCashVoucherController());
  // final chequeVouchercontroller = Get.put(GetChequeVoucherController());

  final formkey = GlobalKey<FormState>();

  MaterialModel? materialPriceValue;
  TypeModel? materialTypeValue;

  int? index;

  @override
  void initState() {
    if (widget.isEdit == true) {
      controller
          .getDocumentWalletList(widget.partyMasterSaved!.id?.toString() ?? "");
      controller.getInvoicesList(
          controller.selectedtransactiontypeId.value,
          controller.financialYearIdInvoice.value,
          widget.partyMasterSaved!.id!,
          "");
    }
    controller.gettransactionTypeList("");
    super.initState();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false, // set it to false

          appBar: AppBar(
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 2.w),
                  child: IconButton(
                    onPressed: () {
                      Get.offAll(PartyMasterScreen());
                    },
                    icon: Icon(
                      Icons.close,
                      color: kColorblack,
                    ),
                  ),
                )
              ],
              title: const Text("Party Master"),
              titleTextStyle: TextStyle(
                  color: kColorblack,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.sp),
              centerTitle: true,
              backgroundColor: kColorwhite,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  color: kColorblack,
                  size: 25.sp,
                ),
                onPressed: (() {
                  Get.back();
                }),
              )),
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.all(2.w),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  // widget.isEdit == true
                  //     ? Container(
                  //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.blue.shade50), color: kColorwhite, boxShadow: kElevationToShadow[2]),
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(
                  //             left: 10.0,
                  //           ),
                  //           child: Row(
                  //             children: [
                  //               Expanded(
                  //                 flex: 5,
                  //                 child: Obx(
                  //                   () => Padding(
                  //                     padding: const EdgeInsets.only(left: 5.0, right: 5, top: 10),
                  //                     child: Container(
                  //                         // width: 30.w,
                  //                         // height: 6.h,
                  //                         child: DropdownButton(
                  //                       isExpanded: true,
                  //                       underline: Divider(
                  //                         color: Color.fromARGB(255, 220, 220, 220),
                  //                         thickness: 1,
                  //                         height: 1,
                  //                       ),
                  //                       value: controller.newTranTypeId.value,
                  //                       items: [
                  //                         DropdownMenuItem<String>(
                  //                           value: "",
                  //                           child: Text("Create New Transaction"),
                  //                         ),
                  //                         ...controller.createNewTramsactionList.map((item) => DropdownMenuItem<String>(
                  //                               value: item.id.toString(),
                  //                               child: Text(
                  //                                 "${item.name}",
                  //                                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  //                               ),
                  //                             )),
                  //                       ],
                  //                       onChanged: (newValue) {
                  //                         setState(() {
                  //                           controller.newTranTypeId.value = newValue!;

                  //                           print(controller.newTranTypeId.value);

                  //                           controller.newTransactionTypeController.text =
                  //                               controller.createNewTramsactionList.firstWhere((item) => item.id.toString() == controller.newTranTypeId.value).name!;

                  //                           print(controller.newTransactionTypeController.text);
                  //                         });
                  //                       },
                  //                       hint: Text('Select an item'),
                  //                     )),
                  //                   ),
                  //                 ),
                  //               ),
                  //               Expanded(
                  //                 child: GestureDetector(
                  //                   onTap: () {
                  //                     print("ontaped");
                  //                     addCreateNewTransaction(controller);
                  //                   },
                  //                   child: Container(
                  //                     decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: kElevationToShadow[3]),
                  //                     child: CircleAvatar(
                  //                       radius: 2.3.h,
                  //                       backgroundColor: kColorlightBlue,
                  //                       child: Icon(
                  //                         Icons.add,
                  //                         size: 20.sp,
                  //                         color: kColorwhite,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       )
                  //     : SizedBox(),
                  SizedBox(
                    height: 2.h,
                  ),
                  Expanded(
                    child: Container(
                      width: 100.w,
                      // height: 70.h,
                      child: ContainedTabBarView(
                        callOnChangeWhileIndexIsChanging: true,
                        initialIndex: 0,
                        onChange: (index) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        tabBarProperties: TabBarProperties(
                          isScrollable: true,
                          unselectedLabelStyle: TextStyle(fontSize: 11.sp),
                          labelStyle: TextStyle(fontSize: 15.sp),
                          labelColor: kColorblack,
                          labelPadding: EdgeInsets.symmetric(horizontal: 1.5.w),
                          unselectedLabelColor: kColorgrey,
                          indicator: const BoxDecoration(
                            color: Colors
                                .transparent, // Customize indicator if needed
                          ),
                        ),
                        tabs: [
                          TabContainer(
                            text: 'Price List',
                            isSelected: selectedIndex == 0,
                            icon: Icons.currency_exchange_rounded,
                          ),
                          TabContainer(
                            text: 'Bank List',
                            isSelected: selectedIndex == 1,
                            icon: Icons.add_business_outlined,
                          ),
                          TabContainer(
                            text: 'Contact List',
                            isSelected: selectedIndex == 2,
                            icon: Icons.contact_emergency_rounded,
                          ),
                          TabContainer(
                            text: 'Terms and condition',
                            isSelected: selectedIndex == 3,
                            icon: Icons.deblur,
                          ),
                          widget.isEdit == true
                              ? TabContainer(
                                  text: 'Service Details',
                                  isSelected: selectedIndex == 4,
                                  icon: Icons.design_services_outlined,
                                )
                              : const SizedBox.shrink(),
                          widget.isEdit == true
                              ? TabContainer(
                                  text: 'Document Wallet',
                                  isSelected: selectedIndex == 5,
                                  icon: Icons.document_scanner_rounded,
                                )
                              : const SizedBox.shrink(),
                        ],
                        views: [
                          buildPriceList(
                            isEdit: widget.isEdit,
                            controller: controller,
                            priceList: widget.priceList,
                            partyTypefield: FadeIn(
                              delay: const Duration(milliseconds: 300),
                              duration: const Duration(milliseconds: 300),
                              child: Padding(
                                padding: EdgeInsets.all(2.w),
                                child: TypeAheadField<TypeModel>(
                                  debounceDuration:
                                      const Duration(milliseconds: 500),

                                  controller: controller.materialTypeController,
                                  builder: (context, materialTypeController,
                                      materialTypeFocusNode) {
                                    return TextFormField(
                                        enabled: true,
                                        focusNode: materialTypeFocusNode,
                                        controller: materialTypeController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Select something";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelText: "Material Type",
                                          suffixIcon: Icon(
                                            Icons.arrow_drop_down,
                                            color: kColorblack,
                                          ),
                                          contentPadding:
                                              EdgeInsets.only(left: 2.w),
                                          labelStyle: TextStyle(
                                              overflow: TextOverflow.fade,
                                              fontSize: 15.sp,
                                              color: const Color.fromARGB(
                                                  255, 78, 78, 78),
                                              fontWeight: FontWeight.w700),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: kColorRed),
                                          ),
                                          disabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: kColorgrey),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: kColorgrey),
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: kColorgrey),
                                          ),
                                        ));
                                  },
                                  // getImmediateSuggestions: true,
                                  suggestionsCallback:
                                      controller.getMaterialTypeList,

                                  itemBuilder: (context, TypeModel suggestion) {
                                    final quotNumber = suggestion;
                                    return ListTile(
                                      title: Text(quotNumber.name!),
                                    );
                                  },
                                  loadingBuilder: (context) {
                                    return const SizedBox(
                                        child: Center(
                                            child:
                                                CircularProgressIndicator()));
                                  },
                                  emptyBuilder: (context) {
                                    return SizedBox(
                                      height: 10.h,
                                      child: Center(
                                        child: Text(
                                          "No items Found",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.sp),
                                        ),
                                      ),
                                    );
                                  },

                                  onSelected: (TypeModel suggestion) async {
                                    materialTypeValue = suggestion;

                                    controller.materialTypeController.text =
                                        materialTypeValue!.name.toString();

                                    controller.materialId.value =
                                        materialTypeValue!.id!;

                                    controller.materialNameController.clear();

                                    // FocusScope.of(context).unfocus();

                                    await controller.getMaterialNameList("");
                                  },
                                ),
                              ),
                            ),
                            expenseHeaderfield: FadeIn(
                              delay: const Duration(milliseconds: 300),
                              duration: const Duration(milliseconds: 300),
                              child: Container(
                                  margin: EdgeInsets.all(2.w),
                                  height: 6.h,
                                  child: CustomDropdown<MaterialModel>(
                                    items: controller
                                        .materialNameList, // assume this is your material name list
                                    itemToString: (item) => item.name ?? '',
                                    labelText: 'Material Name',
                                    searchable:
                                        true, // make it act like TypeAhead
                                    onSelected: (MaterialModel suggestion) {
                                      materialPriceValue = suggestion;
                                      controller.materialNameController.text =
                                          materialPriceValue!.name ?? '';
                                    },
                                  )),
                            ),
                            itemAddButton: () {
                              // setState(() {});

                              if (controller
                                  .materialTypeController.text.isEmpty) {
                                customSnackbar("Error",
                                    "Please select material type*", "error");
                                // FocusScope.of(context).unfocus();
                              } else if (controller
                                  .materialNameController.text.isEmpty) {
                                customSnackbar("Error",
                                    "Please select material name*", "error");
                              } else {
                                final value = MaterialPriceListDTOList(
                                  comment:
                                      controller.commentsItemController.text,
                                  currentBuyingPrice:
                                      materialPriceValue!.buyingPrice,
                                  currentSellingPrice:
                                      materialPriceValue!.price ?? null,
                                  discountPercentage:
                                      materialPriceValue!.discountPercentage,
                                  id: null,
                                  deleted: materialPriceValue!.deleted,
                                  materialId: materialPriceValue!.id,
                                  materialName: materialPriceValue!.name,
                                  materialTypeName: materialTypeValue!.name,
                                  partNumber: materialPriceValue!.partNumber,
                                  partyId: null,
                                  sellingPrice: double.parse(controller
                                              .sellingPriceitemController
                                              .text ==
                                          ""
                                      ? "0.0"
                                      : controller
                                          .sellingPriceitemController.text),
                                );
                                controller.materialTypeController.clear();
                                controller.materialNameController.clear();
                                FocusScope.of(context).unfocus();
                                controller.materialPriceItem.add(value);
                              }
                            },
                          ),
                          buildBankList(
                            isEdit: widget.isEdit,
                            bankList: widget.bankList,
                            controller: controller,
                            expenseHeaderfield: FadeIn(
                              delay: const Duration(milliseconds: 300),
                              duration: const Duration(milliseconds: 300),
                              child: Container(
                                margin: EdgeInsets.all(4.w),
                                height: 6.h,
                                // width: 50.w,
                                child: TypeAheadField<BankModel>(
                                  debounceDuration:
                                      const Duration(milliseconds: 500),

                                  controller: controller.bankNameController,
                                  builder:
                                      (context, bankController, bankFocusNode) {
                                    return TextFormField(
                                        enabled: true,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Select something";
                                          }
                                          return null;
                                        },
                                        controller: bankController,
                                        focusNode: bankFocusNode,
                                        decoration: InputDecoration(
                                          labelText: "Bank Name",
                                          suffixIcon: Icon(
                                            Icons.arrow_drop_down,
                                            color: kColorblack,
                                          ),
                                          contentPadding:
                                              EdgeInsets.only(left: 2.w),
                                          labelStyle: TextStyle(
                                              overflow: TextOverflow.fade,
                                              fontSize: 15.sp,
                                              color: const Color.fromARGB(
                                                  255, 78, 78, 78),
                                              fontWeight: FontWeight.w700),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: kColorRed),
                                          ),
                                          disabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: kColorgrey),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: kColorgrey),
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: kColorgrey),
                                          ),
                                        ));
                                  },

                                  // getImmediateSuggestions: true,
                                  suggestionsCallback: controller.getBankList,
                                  // hideKeyboard: true,
                                  // hideKeyboardOnDrag: true,

                                  itemBuilder: (context, BankModel suggestion) {
                                    final quotNumber = suggestion;
                                    return ListTile(
                                      title: Text(quotNumber.bankname!),
                                    );
                                  },
                                  loadingBuilder: (context) {
                                    return SizedBox(
                                        height: 10.h,
                                        child: const Center(
                                            child:
                                                CircularProgressIndicator()));
                                  },
                                  emptyBuilder: (context) {
                                    // customerReceiptController
                                    //     .nocustomerFound.value = true;

                                    return SizedBox(
                                      height: 10.h,
                                      child: Center(
                                        child: Text(
                                          "No items Found",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.sp),
                                        ),
                                      ),
                                    );
                                  },

                                  onSelected: (BankModel suggestion) {
                                    controller.bankValue = suggestion;

                                    controller.bankNameController.text =
                                        controller.bankValue!.bankname
                                            .toString();
                                  },
                                ),
                              ),
                            ),
                            itemAddButton: () {
                              final value = PartyBankMapDTOList(
                                  accountNumber:
                                      controller.aCController.text.isEmpty
                                          ? null
                                          : controller.aCController.text,
                                  bankAdCode: null,
                                  bankId: controller.bankValue!.id,
                                  branch:
                                      controller.branchController.text.isEmpty
                                          ? null
                                          : controller.branchController.text,
                                  companyId: null,
                                  contactNumber: "",
                                  ifsc: controller.ifscController.text.isEmpty
                                      ? null
                                      : controller.ifscController.text,
                                  openingBalance: controller
                                          .openingBalanceController.text.isEmpty
                                      ? null
                                      : double.tryParse(controller
                                          .openingBalanceController.text),
                                  partyId: null,
                                  swiftCode: "",
                                  bankname: controller.bankValue!.bankname,
                                  id: null);

                              controller.materialBankItem.add(value);

                              controller.bankNameController.clear();
                              controller.isDefault.value = false;
                            },
                          ),
                          ContactList(
                              departmentDropdown: FadeIn(
                                delay: const Duration(milliseconds: 300),
                                duration: const Duration(milliseconds: 300),
                                child: Obx(
                                  () => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, right: 5),
                                    child: Container(
                                        // margin: EdgeInsets.all(2.w),
                                        height: 7.h,
                                        // width: 30.w,
                                        child: DropdownButton(
                                          isExpanded: true,
                                          underline: const Divider(
                                            color: Color.fromARGB(
                                                255, 220, 220, 220),
                                            thickness: 1,
                                            height: 1,
                                          ),
                                          value: controller.departmentId.value,
                                          items: [
                                            const DropdownMenuItem<String>(
                                              value: "",
                                              child: Text("Department Type*"),
                                            ),
                                            ...controller.departmentList.map(
                                                (item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item.id.toString(),
                                                      child: Text(
                                                          "${item.departmentName}"),
                                                    )),
                                          ],
                                          onChanged: (newValue) {
                                            setState(() {
                                              controller.departmentId.value =
                                                  newValue!;

                                              controller.departmentController
                                                      .text =
                                                  controller.departmentList
                                                      .firstWhere((item) =>
                                                          item.id.toString() ==
                                                          controller
                                                              .departmentId
                                                              .value)
                                                      .departmentName!;
                                            });
                                          },
                                          hint: const Text('Select an item'),
                                        )),
                                  ),
                                ),
                              ),
                              contactList: widget.contactList,
                              designationDropdown: Column(
                                children: [
                                  Obx(
                                    () => Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 5),
                                      child: Container(
                                          // width: 30.w,
                                          height: 7.h,
                                          child: DropdownButton(
                                            isExpanded: true,
                                            underline: const Divider(
                                              color: Color.fromARGB(
                                                  255, 220, 220, 220),
                                              thickness: 1,
                                              height: 1,
                                            ),
                                            value:
                                                controller.designationId.value,
                                            items: [
                                              const DropdownMenuItem<String>(
                                                value: "",
                                                child:
                                                    Text("Designation Type*"),
                                              ),
                                              ...controller.designationList.map(
                                                  (item) =>
                                                      DropdownMenuItem<String>(
                                                        value:
                                                            item.id.toString(),
                                                        child: Text(
                                                            "${item.designationName}"),
                                                      )),
                                            ],
                                            onChanged: (newValue) {
                                              setState(() {
                                                controller.designationId.value =
                                                    newValue!;

                                                controller.designationController
                                                        .text =
                                                    controller.designationList
                                                        .firstWhere((item) =>
                                                            item.id
                                                                .toString() ==
                                                            controller
                                                                .designationId
                                                                .value)
                                                        .designationName;
                                              });
                                            },
                                            hint: const Text('Select an item'),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              itemAddButton: () {
                                if (controller
                                    .departmentController.text.isEmpty) {
                                  customSnackbar(
                                      "Error",
                                      "Please select department type*",
                                      "error");
                                } else if (controller
                                    .designationController.text.isEmpty) {
                                  customSnackbar(
                                      "Error",
                                      "Please select designation type*",
                                      "error");
                                } else {
                                  var value = PartyContactDetails(
                                      id: null,
                                      name: null,
                                      department:
                                          controller.departmentController.text,
                                      designation:
                                          controller.designationController.text,
                                      departmentId: int.tryParse(
                                          controller.departmentId.value),
                                      designationId: int.tryParse(
                                          controller.designationId.value),
                                      email: controller
                                          .emailContactListController.text,
                                      primaryPhoneNumber: controller
                                          .primaryPhoneNumontactListController
                                          .text,
                                      secondaryPhoneNumber: controller
                                          .secPhoneNumontactListController.text,
                                      remarks: controller
                                          .remarkContactController.text,
                                      deleted: "N",
                                      partyId: null,
                                      companyId: null,
                                      isPrimary: null);
                                  controller.departmentController.clear();
                                  controller.designationController.clear();

                                  controller.contactListItem.add(value);
                                }
                              },
                              isEdit: widget.isEdit,
                              controller: controller),
                          TermsAndCondition(
                            termsAndConditionList:
                                widget.termsAndConditionValue,
                            controller: controller,
                            expenseHeaderfield: FadeIn(
                              delay: const Duration(milliseconds: 300),
                              duration: const Duration(milliseconds: 300),
                              child: Container(
                                margin: EdgeInsets.all(3.w),
                                height: 6.h,
                                // width: 50.w,
                                child: TypeAheadField<TransactionTypeModel>(
                                  debounceDuration:
                                      const Duration(milliseconds: 500),

                                  controller:
                                      controller.inputtranscationTypeController,
                                  builder: (context, inputController,
                                      inputFocusNode) {
                                    return TextFormField(
                                        enabled: true,
                                        controller: inputController,
                                        focusNode: inputFocusNode,
                                        decoration: InputDecoration(
                                          labelText: "Select Transcation Type*",
                                          suffixIcon: Icon(
                                            Icons.arrow_drop_down,
                                            color: kColorblack,
                                          ),
                                          contentPadding:
                                              EdgeInsets.only(left: 2.w),
                                          labelStyle: TextStyle(
                                              overflow: TextOverflow.fade,
                                              fontSize: 15.sp,
                                              color: const Color.fromARGB(
                                                  255, 78, 78, 78),
                                              fontWeight: FontWeight.w700),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: kColorRed),
                                          ),
                                          disabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: kColorgrey),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: kColorgrey),
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: kColorgrey),
                                          ),
                                        ));
                                  },

                                  // getImmediateSuggestions: true,
                                  suggestionsCallback:
                                      controller.gettransactionTypeList,
                                  // hideKeyboard: true,
                                  // hideKeyboardOnDrag: true,

                                  itemBuilder: (context,
                                      TransactionTypeModel suggestion) {
                                    final transactionType = suggestion;
                                    return ListTile(
                                      title: Text(transactionType.name!),
                                    );
                                  },
                                  loadingBuilder: (context) {
                                    return SizedBox(
                                        height: 10.h,
                                        child: const Center(
                                            child:
                                                CircularProgressIndicator()));
                                  },
                                  emptyBuilder: (context) {
                                    // customerReceiptController
                                    //     .nocustomerFound.value = true;

                                    return SizedBox(
                                      height: 10.h,
                                      child: Center(
                                        child: Text(
                                          "No items Found",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.sp),
                                        ),
                                      ),
                                    );
                                  },

                                  onSelected:
                                      (TransactionTypeModel suggestion) {
                                    controller.transactionType = suggestion;
                                    controller.transactionTypeId.value =
                                        controller.transactionType!.id!
                                            .toString();
                                    controller.inputtranscationTypeController
                                            .text =
                                        controller.transactionType!.name
                                            .toString();
                                  },
                                ),
                              ),
                            ),
                            isEdit: widget.isEdit,
                            itemAddButton: () {
                              if (controller.transactionTypeId.value.isEmpty) {
                                customSnackbar("Error",
                                    "Please select transaction type*", "error");
                              } else {
                                var value = TermsAndConditions(
                                    id: null,
                                    name: controller
                                        .NametermsNdConditionController.text,
                                    termsAndCondition: controller
                                        .termsNdConditionController.text,
                                    paymentTerms: null,
                                    deliveryTerms: null,
                                    defaultTermsAndCondition: null,
                                    transactionTypeId: int.parse(
                                        controller.transactionTypeId.value),
                                    deleted: "N",
                                    partyId: null);
                                controller.termsNdconditionItem.add(value);
                                controller.inputtranscationTypeController
                                    .clear();
                                controller.transactionTypeId.value = "";
                                controller.NametermsNdConditionController
                                    .clear();
                                controller.termsNdConditionController.clear();
                              }
                            },
                          ),
                          widget.isEdit == true
                              ? ServiceDetails(
                                  controller: controller,
                                  partyMasterSaved: widget.partyMasterSaved,
                                )
                              : const SizedBox(),
                          widget.isEdit == true
                              ? PartyDocumentWalletScreen(
                                  partyId:
                                      widget.partyMasterSaved!.id.toString(),
                                  controller: controller,
                                  isEdit: true,
                                  itemAddButton: () async {
                                    var file = await controller.pickFile();

                                    await controller.uploadDocumentWalletPdf(
                                        file!,
                                        widget.partyMasterSaved!.id.toString());
                                  },
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: CustomButton(
                      width: 50.w,
                      title: "Save",
                      color: const Color.fromARGB(255, 58, 192, 255),
                      textcolor: kColorwhite,
                      ontap: () {
                        controller.isPageLoading.value = true;

                        controller.savePartyMaster(widget.isEdit);
                      },
                    ),
                  )
                ],
              ),
            ),
          )),
        ),
        Obx(() => loadingScreenWithText(
            isPageLoading: controller.isPageLoading.value)),
      ],
    );
  }

  void clearFunction(PartyMasterController controller) {
    controller.partyTypeController.clear();
    controller.partyCodeController.clear();
    controller.partyNameController.clear();
    controller.emailController.clear();
    controller.vendercodeController.clear();
    controller.contactNumberController.clear();
    controller.pincodeController.clear();
    controller.areaController.clear();
    controller.cityController.clear();
    controller.stateController.clear();
    controller.countryController.clear();
    controller.primaryTelephoneController.clear();
    controller.secondaryTelephoneController.clear();
    controller.primaryMobileController.clear();
    controller.secondaryMobileController.clear();
    controller.websiteController.clear();
    controller.contactPersonController.clear();
    controller.billToAddressController.clear();
    controller.shipToAddressLine1Controller.clear();
    controller.shipToAddressLine2Controller.clear();
    controller.materialTypeController.clear();
    controller.materialNameController.clear();
    controller.bankNameController.clear();
  }

//   addCreateNewTransaction(PartyMasterController controller) async {
//     print("id---${controller.newTranTypeId.value}");
//     if (controller.newTranTypeId.value == "1") {
//       print("---inside");

//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => TaxInvoiceDetailScreen(
//                 isCreateproforma: false,
//                 isCreatePo: false,
//                 isEdit: false,
//                 isClone: false,
//                 isCreateDc: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,
//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));

//       // Get.back();
//       // } else {
//       //   customSnackbar("Can't Edit", " '${controller.taxInvoiceitems[index].statusName}' Quoatation can't edit", "normal");
//     } else if (controller.newTranTypeId.value == "18") {
//       print("---inside");

//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => SubcontractingInvoiceDetailScreen(
//                 isCreateproforma: false,
//                 isCreatePo: false,
//                 isEdit: false,

//                 isCreateDc: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,
//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "19") {
//       print("---inside");

//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => ProformaInvoiceDetailScreen(
//                 isCreatePo: false,
//                 isEdit: false,

//                 isCreateDc: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,
//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "32") {
//       print("---inside");

//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => JobworkProformaInvoiceDetailScreen(
//                 isCreatePo: false,
//                 isEdit: false,
//                 isCreateDc: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,
//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "33") {
//       print("---inside");

//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => SubcontractingProformaInvoiceDetailScreen(
//                 isCreatePo: false,
//                 isEdit: false,
//                 isCreateDc: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,
//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "7") {
//       print("---inside");

//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => DcAddScreen(
//                 isEdit: false,

//                 isCreateDc: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,
//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "14") {
//       print("---inside");

//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       // Get.to(
//       //     () => JobworkOutDcAddScreen(
//       //           isCreateInDc: false,
//       //           isEdit: false,
//       //           isCreateFromPartyMaster: true,
//       //           partyMasterSaved: widget.partyMasterSaved!,
//       //
//       //           // partyMasterSaved: controller.itemDatas,
//       //         ),
//       //     transition: Transition.fade,
//       //     duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "13") {
//       print("---inside");

//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => JobworkInDcAddScreen(
//                 isEdit: false,
//                 isCreateDc: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,
//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "16") {
//       print("---inside");

//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => SubcontractingOutDcAddScreen(
//                 isCreatePo: false,
//                 isEdit: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,
//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "17") {
//     } else if (controller.newTranTypeId.value == "15") {
//       print("---inside");

//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       Get.to(
//           () => JobworkInvoiceDetailScreen(
//                 isCreateDc: false,
//                 isCreatePo: false,
//                 isCreateproforma: false,
//                 isEdit: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "3") {
//       print("---inside");

//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => CustomerReceiptsDetailScreen(
//                 isEdit: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,
//                 isCreateDc: false,
//                 isCreatePo: false,
//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "11") {
//       print("---inside");

//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => PurchaseOrderDetailsScreen(
//                 isCreatePo: false,
//                 isEdit: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,
//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "20") {
//       print("---inside");

//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => JobWorkPOdetailsScreen(
//                 isCreatePo: false,
//                 isEdit: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,
//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "21") {
//       print("---inside");

//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => SubcontractingPOdetailsScreen(
//                 isCreatePo: false,
//                 isEdit: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,
//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "22") {
//       print("---inside");

//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => CashVoucherAddScreen(
//                 isEdit: false,
//                 transactionNumber: cashVouchercontroller.cashVoucherTransactionNumber!.responseString!,
//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "23") {
//       Get.to(
//           () => ChequeVoucherAddScreen(
//                 isEdit: false,
//                 transactionNumber: chequeVouchercontroller.chequeVoucherTransactionNumber!.responseString!,
//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "9") {
//       print("---inside");

//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => CreditNoteDetailScreen(
//                 isEdit: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,
//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "28") {
//       print("---inside");

//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => JobWorkCreditNoteDetailScreen(
//                 isEdit: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,
//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "29") {
//       print("---inside");

//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => SubcontractDebitNoteDetailScreen(
//                 isEdit: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,
//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "12") {
//       print("---inside");

//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => QuotationAdd(
//                 isEdit: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,
//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "30") {
//       print("---inside");

//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => JobWorkQuotationAdd(
//                 isEdit: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,
//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "31") {
//       print("---inside");

//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => SubcontractingQuotationAdd(
//                 isEdit: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,

//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "2") {
//       print("SSupplier po");

//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => SupplierPoDetailScreen(
//                 isEdit: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,

//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "4") {
//       print("SSupplier payment");
//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => SupplierPaymentDetailScreen(
//                 isEdit: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,
//                 isCreateDc: false,
//                 isCreatePo: false,
//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "10") {
//       print("Debit Note ---");
//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => DebitNoteDetailScreen(
//                 isEdit: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,

//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "6") {
//       print("Incoming dc --- ");
//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => IncomingDcAddScreen(
//                 isCreateDc: false,
//                 isEdit: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,

//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     } else if (controller.newTranTypeId.value == "5") {
//       print(" Purchase Invoice --- ");
//       print("----inside for id--${widget.partyMasterSaved!.name.toString()}");

//       // controller.getInvoicedetails(widget.partyMasterSaved!.id.toString());

//       Get.to(
//           () => PurchaseInvoiceDetailScreen(
//                 isCreateGrn: false,
//                 isCreatePo: false,
//                 isEdit: false,
//                 isCreateFromPartyMaster: true,
//                 partyMasterSaved: widget.partyMasterSaved!,
//                 // partyMasterSaved: controller.itemDatas,
//               ),
//           transition: Transition.fade,
//           duration: Duration(milliseconds: 600));
//     }
//   }
}

class ServiceDetails extends StatefulWidget {
  final PartyMasterController controller;
  final PartyDTO? partyMasterSaved;
  const ServiceDetails({
    super.key,
    required this.controller,
    this.partyMasterSaved,
  });

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  @override
  void initState() {
    widget.controller.getFinancialYearList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 5.5.h,
              // width: 75.w,
              decoration: BoxDecoration(
                boxShadow: kElevationToShadow[4],
                color: kColorwhite,
                borderRadius: BorderRadius.circular(3.w),
              ),
              child: TextField(
                onChanged: (value) {
                  widget.controller.searchController.text = value;
                  widget.controller.getServiceList(
                    widget.controller.selectedtransactiontypeId.value,
                    widget.controller.financialYearIdInvoice.value,
                    widget.partyMasterSaved!.id!,
                    value,
                    widget.controller.selectedStatusId.value,
                  );
                },
                controller: widget.controller.searchController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search Here',
                  hintStyle: TextStyle(color: kColorgrey),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(2.w),
                  height: 7.h,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: const Divider(
                      color: Color.fromARGB(255, 220, 220, 220),
                      thickness: 1,
                      height: 1,
                    ),
                    value: widget.controller.financialYearList.any((item) =>
                            item.id.toString() ==
                            widget.controller.financialYearId.value)
                        ? widget.controller.financialYearId.value
                        : null, // Set to null if not found
                    items: [
                      const DropdownMenuItem<String>(
                        value: "",
                        child: Text("Financial Year"),
                      ),
                      ...widget.controller.financialYearList
                          .map((item) => DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: Text("${item.financialYear}"),
                              )),
                    ],
                    onChanged: (newValue) async {
                      if (newValue != null) {
                        setState(() {
                          widget.controller.financialYearId.value = newValue;

                          widget.controller.financialYear.value = widget
                              .controller.financialYearList
                              .firstWhere(
                                  (item) => item.id.toString() == newValue)
                              .financialYear!;
                        });

                        widget.controller.serviceListItems.clear();

                        await widget.controller.getServiceList(
                          widget.controller.selectedtransactiontypeId.value,
                          widget.controller.financialYearId.value,
                          widget.partyMasterSaved!.id!,
                          widget.controller.searchController.text,
                          widget.controller.selectedStatusId.value,
                        );
                      }
                    },
                    hint: const Text('Select an item'),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    margin: EdgeInsets.all(2.w),
                    height: 7.h,
                    // width: 30.w,
                    child: DropdownButton(
                      isExpanded: true,
                      underline: const Divider(
                        color: Color.fromARGB(255, 220, 220, 220),
                        thickness: 1,
                        height: 1,
                      ),
                      value: widget.controller.selectedStatusId.value,
                      items: [
                        const DropdownMenuItem<String>(
                          value: "",
                          child: Text("Status"),
                        ),
                        ...widget.controller.statusOptions
                            .map((item) => DropdownMenuItem<String>(
                                  value: item['id'].toString(),
                                  child: Text("${item['name']}"),
                                )),
                      ],
                      onChanged: (newValue) async {
                        setState(() {
                          widget.controller.selectedStatusId.value = newValue!;

                          widget.controller.selectedStatus.value = widget
                              .controller.statusOptions
                              .firstWhere((item) =>
                                  item['id'].toString() ==
                                  widget.controller.selectedStatusId
                                      .value)['name']!;
                        });
                        widget.controller.serviceListItems.clear();

                        await widget.controller.getServiceList(
                          widget.controller.selectedtransactiontypeId.value,
                          widget.controller.financialYearId.value,
                          widget.partyMasterSaved!.id!,
                          widget.controller.searchController.text,
                          widget.controller.selectedStatusId.value,
                        );
                      },
                      hint: const Text('Select an item'),
                    )),
              ),
            ],
          ),
          Expanded(
              child: Obx(
            () => widget.controller.serviceListItems.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeIn(
                          delay: const Duration(milliseconds: 300),
                          duration: const Duration(milliseconds: 300),
                          child: LottieBuilder.asset(
                            "assets/lottie/empty.json",
                            width: 70.w,
                          )),
                      SizedBox(
                        height: 3.h,
                      ),
                      FadeIn(
                        delay: const Duration(milliseconds: 500),
                        duration: const Duration(milliseconds: 500),
                        child: Text(
                          "Data is Empty ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13.sp),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: widget.controller.serviceListItems.length,
                    itemBuilder: (context, index) {
                      var item = widget.controller.serviceListItems[index];
                      // Parse Start and End Dates
                      DateTime startDate =
                          DateTime.parse(item.serviceStartDate!);
                      DateTime endDate = DateTime.parse(item.serviceEndDate!);

                      Map<String, Color> statusInfo = widget.controller
                          .getPlanStatuss(
                              startDate: startDate, endDate: endDate);
                      String statusText = statusInfo.keys.first;
                      Color statusColor = statusInfo.values.first;
                      // Get Plan Status
                      return Card(
                        color: kColorLightGrey,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.all(2.w),
                        child: ExpansionTile(
                          title: Text(
                            "Service : ${item.serviceName ?? ""}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("Status: ${statusText}",
                              style: TextStyle(
                                  color: statusColor,
                                  fontWeight: FontWeight.w500)),
                          children: [
                            ListTile(
                              title: const Text('Invoice Number'),
                              subtitle: Text(item.invoiceNumber.toString()),
                            ),
                            ListTile(
                              title: const Text('Start Date'),
                              subtitle: Text(DateClass()
                                  .showDate(item.serviceStartDate ?? "")),
                            ),
                            ListTile(
                              title: const Text('End Date'),
                              subtitle: Text(DateClass()
                                  .showDate(item.serviceEndDate ?? "")),
                            ),
                            ListTile(
                              title: const Text('Price'),
                              subtitle: Text(item.price.toString()),
                            ),
                            ListTile(
                              title: const Text('Status'),
                              subtitle: Text(item.statusName ?? ""),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ))
        ],
      ),
    );
  }
}

// class TransactionDetails extends StatelessWidget {
//   final PartyMasterController controller;
//   final PartyDTO? partyMasterSaved;

//   const TransactionDetails({
//     super.key,
//     required this.controller,
//     this.partyMasterSaved,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Column(
//         children: [
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(
//                   left: 3.0, top: 20, right: 3, bottom: 20),
//               child: Container(
//                 width: 100.w,
//                 child: ContainedTabBarView(
//                     callOnChangeWhileIndexIsChanging: true,
//                     initialIndex: 0,
//                     tabBarProperties: TabBarProperties(
//                         background: Container(
//                           height: 43,
//                           decoration: BoxDecoration(
//                             color: Colors.blue.shade50,
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(15.0)),
//                           ),
//                         ),
//                         isScrollable: true,
//                         unselectedLabelStyle: TextStyle(
//                             fontSize: 10.5.sp, fontWeight: FontWeight.w300),
//                         labelStyle: TextStyle(fontSize: 12.sp),
//                         labelColor: kColorblack,
//                         labelPadding: EdgeInsets.symmetric(horizontal: 6.w),
//                         unselectedLabelColor: kColorgreyShade500,
//                         indicatorPadding:
//                             const EdgeInsets.only(left: 5, right: 5)),
//                     tabs: [
//                       const Text(
//                         'Invoice',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       const Text(
//                         'Quotation',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const Text(
//                         'Purchase Orders',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const Text(
//                         "Receipts",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const Text(
//                         'Delivery Challans',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const Text(
//                         "Advances",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                     views: [
//                       InvoicesScreenPartyMaster(
//                         controller: controller,
//                         partyMasterSaved: partyMasterSaved,
//                       ),
//                       QuotationsScreenPartyMaster(
//                         controller: controller,
//                         partyMasterSaved: partyMasterSaved,
//                       ),
//                       POScreenPartyMaster(
//                         controller: controller,
//                         partyMasterSaved: partyMasterSaved,
//                       ),
//                       ReceiptScreenPartyMaster(
//                         controller: controller,
//                         partyMasterSaved: partyMasterSaved,
//                       ),
//                       DCScreenPartyMaster(
//                         controller: controller,
//                         partyMasterSaved: partyMasterSaved,
//                       ),
//                       AdvancesScreenPartyMaster(
//                         controller: controller,
//                         partyMasterSaved: partyMasterSaved,
//                       ),
//                     ]),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class TermsAndCondition extends StatefulWidget {
  final Widget expenseHeaderfield;
  final VoidCallback itemAddButton;
  List<TermsAndConditions>? termsAndConditionList;
  final bool isEdit;

  TermsAndCondition({
    super.key,
    required this.controller,
    required this.isEdit,
    this.termsAndConditionList,
    required this.expenseHeaderfield,
    required this.itemAddButton,
  });

  final PartyMasterController controller;

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(flex: 4, child: widget.expenseHeaderfield),
              Expanded(
                child: GestureDetector(
                  onTap: widget.itemAddButton,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: kElevationToShadow[3]),
                    child: CircleAvatar(
                      radius: 2.4.h,
                      backgroundColor: kColorlightBlue,
                      child: Icon(
                        Icons.add,
                        size: 22.sp,
                        color: kColorwhite,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Obx(
            () => Expanded(
              child: widget.controller.termsNdconditionItem.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 6.h,
                          ),
                          FadeIn(
                              delay: const Duration(milliseconds: 300),
                              duration: const Duration(milliseconds: 300),
                              child: LottieBuilder.asset(
                                  "assets/lottie/empty.json",
                                  height: 15.h)),
                          SizedBox(
                            height: 3.h,
                          ),
                          FadeIn(
                            delay: const Duration(milliseconds: 500),
                            duration: const Duration(milliseconds: 500),
                            child: Text(
                              "Terms and condition List is Empty",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12.sp),
                            ),
                          )
                        ],
                      ),
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(
                          child: Divider(
                        thickness: 1,
                        color: kColorgrey,
                      )),
                      shrinkWrap: true,
                      itemCount: widget.controller.termsNdconditionItem.length,
                      itemBuilder: (context, index) {
                        return SwipeActionCell(
                          key: UniqueKey(),
                          trailingActions: <SwipeAction>[
                            SwipeAction(
                                performsFirstActionWithFullSwipe: false,
                                backgroundRadius: 6.w,
                                widthSpace: 20.w,
                                title: "Delete",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kColorwhite),
                                onTap: (CompletionHandler handler) async {
                                  customDeleteAlertDialogue(
                                    context,
                                    () async {
                                      widget.controller.termsNdconditionItem
                                          .removeAt(index);
                                      Get.back();
                                    },
                                  );
                                },
                                color: Colors.red),
                          ],
                          child: MaterialListCustom(
                            amount: "",
                            name: widget.controller.transcationItem
                                    .firstWhere((element) =>
                                        element.id ==
                                        widget
                                            .controller
                                            .termsNdconditionItem[index]
                                            .transactionTypeId)
                                    .name ??
                                "",
                            quantity: widget
                                .controller.termsNdconditionItem[index].name
                                .toString(),
                            onlongpress: () {
                              customDeleteAlertDialogue(
                                context,
                                () {
                                  widget.controller.termsNdconditionItem
                                      .removeAt(index);
                                  Get.back();
                                },
                              );
                            },
                            ontap: () {
                              widget.controller.NametermsNdConditionController
                                  .text = widget.controller
                                      .termsNdconditionItem[index].name ??
                                  "";
                              widget.controller.termsNdConditionController
                                  .text = widget
                                      .controller
                                      .termsNdconditionItem[index]
                                      .termsAndCondition ??
                                  "";
                              // controller.transcationTypeController.text = controller.termsNdconditionItem[index].branch ?? "";
                              widget.controller.transcationTypeController.text =
                                  widget.controller.transcationItem
                                          .firstWhere((element) =>
                                              element.id ==
                                              widget
                                                  .controller
                                                  .termsNdconditionItem[index]
                                                  .transactionTypeId)
                                          .name ??
                                      "";

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Form(
                                    key: formKey,
                                    child: CustomPopup(
                                        title: 'Bank Details',
                                        onCancelPressed: () {
                                          Get.back();
                                          widget.controller
                                              .NametermsNdConditionController
                                              .clear();
                                          widget.controller
                                              .termsNdConditionController
                                              .clear();
                                          widget.controller
                                              .transcationTypeController
                                              .clear();
                                        },
                                        onUpdatePressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            widget
                                                .controller
                                                .termsNdconditionItem[index]
                                                .name = widget
                                                    .controller
                                                    .NametermsNdConditionController
                                                    .text
                                                    .isEmpty
                                                ? ""
                                                : widget
                                                    .controller
                                                    .NametermsNdConditionController
                                                    .text;
                                            widget
                                                    .controller
                                                    .termsNdconditionItem[index]
                                                    .termsAndCondition =
                                                widget
                                                    .controller
                                                    .termsNdConditionController
                                                    .text;

                                            widget
                                                .controller.termsNdconditionItem
                                                .refresh();

                                            Get.back();
                                            widget.controller
                                                .NametermsNdConditionController
                                                .clear();
                                            widget.controller
                                                .termsNdConditionController
                                                .clear();
                                            widget.controller
                                                .transcationTypeController
                                                .clear();
                                          } else {}
                                        },
                                        saveButtonText: "Save",
                                        children: [
                                          CustomTextField(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter transaction type";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller: widget.controller
                                                  .transcationTypeController,
                                              label: "Transaction Type"),
                                          CustomTextField(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter Name";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller: widget.controller
                                                  .NametermsNdConditionController,
                                              label: "Name"),
                                          CustomTextField(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter Terms & Condition";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller: widget.controller
                                                  .termsNdConditionController,
                                              label: "Terms & Condition"),
                                        ]),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }
}

Row switchCustom(Widget switchwidget, String title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: SizedBox(
          width: 50.w,
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      const Spacer(),
      switchwidget,
    ],
  );
}

class PartyDocumentWalletScreen extends StatelessWidget {
  final VoidCallback itemAddButton;
  String? partyId;

  final bool isEdit;

  PartyDocumentWalletScreen({
    super.key,
    required this.controller,
    required this.isEdit,
    required this.itemAddButton,
    this.partyId,
  });

  final PartyMasterController controller;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 50.h,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  controller.documentWalletList.length == 5
                      ? GestureDetector(
                          onTap: () {
                            customSnackbar("Error",
                                "You cannot upload more than 5 files", "error");
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade300),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Obx(() => Text(
                                    "Upload Documents - (${controller.documentWalletList.length}/5)",
                                    style: TextStyle(
                                      fontSize: 15,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      color: kColorblack,
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: itemAddButton,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kColorlightBlue),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Obx(() => Text(
                                    "Upload Documents - (${controller.documentWalletList.length}/5)",
                                    style: TextStyle(
                                        fontSize: 15,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold,
                                        color: kColorwhite),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Obx(
                      () => controller.documentWalletList.isEmpty
                          ? Center(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                FadeIn(
                                    delay: const Duration(milliseconds: 300),
                                    duration: const Duration(milliseconds: 300),
                                    child: LottieBuilder.asset(
                                        "assets/lottie/empty.json",
                                        height: 15.h)),
                                SizedBox(
                                  height: 3.h,
                                ),
                                FadeIn(
                                  delay: const Duration(milliseconds: 500),
                                  duration: const Duration(milliseconds: 500),
                                  child: Text(
                                    "Document List is Empty",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp),
                                  ),
                                )
                              ],
                            ))
                          : ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              shrinkWrap: true,
                              itemCount: controller.documentWalletList.length,
                              itemBuilder: (context, index) {
                                controller.documentWalletList[index].id
                                    .toString();

                                return SwipeActionCell(
                                  key: UniqueKey(),
                                  trailingActions: <SwipeAction>[
                                    SwipeAction(
                                        performsFirstActionWithFullSwipe: false,
                                        backgroundRadius: 6.w,
                                        widthSpace: 20.w,
                                        title: "Delete",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: kColorwhite),
                                        onTap:
                                            (CompletionHandler handler) async {
                                          customDeleteAlertDialogue(
                                            context,
                                            () async {
                                              List<String> payload = [
                                                controller
                                                    .documentWalletList[index]
                                                    .name
                                                    .toString()
                                              ];

                                              controller.deleteDocument(
                                                  payload, partyId);

                                              Get.back();
                                              customSnackbar(
                                                  "Delete",
                                                  "Successfully Deleted",
                                                  "error");
                                            },
                                          );
                                        },
                                        color: Colors.red),
                                  ],
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => MyWebView(
                                            url: controller
                                                    .documentWalletList[index]
                                                    .fileURL ??
                                                "",
                                          ));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.grey.shade100),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                height: 60,
                                                width: 40,
                                                child: Image.asset(
                                                    "assets/Images/pdf.png")),
                                            SizedBox(
                                                width: 70.w,
                                                child: Text(
                                                  controller
                                                      .documentWalletList[index]
                                                      .name!,
                                                  style: const TextStyle(
                                                      fontSize: 17),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactList extends StatelessWidget {
  final Widget designationDropdown;
  final Widget departmentDropdown;
  final VoidCallback itemAddButton;
  List<PartyContactDetails>? contactList;
  final bool isEdit;

  ContactList(
      {super.key,
      required this.designationDropdown,
      this.contactList,
      required this.itemAddButton,
      required this.isEdit,
      required this.controller,
      required this.departmentDropdown});

  final PartyMasterController controller;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 1.h,
                ),
                departmentDropdown,
                Row(
                  children: [
                    Expanded(flex: 3, child: designationDropdown),
                    Expanded(
                      child: GestureDetector(
                        onTap: itemAddButton,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: kElevationToShadow[3]),
                          child: CircleAvatar(
                            radius: 2.4.h,
                            backgroundColor:
                                const Color.fromARGB(255, 248, 235, 234),
                            child: Icon(
                              Icons.add,
                              size: 22.sp,
                              color: kColorblack,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Obx(
            () => Expanded(
              child: controller.contactListItem.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeIn(
                              delay: const Duration(milliseconds: 300),
                              duration: const Duration(milliseconds: 300),
                              child: LottieBuilder.asset(
                                  "assets/lottie/empty.json",
                                  height: 15.h)),
                          SizedBox(
                            height: 3.h,
                          ),
                          FadeIn(
                            delay: const Duration(milliseconds: 500),
                            duration: const Duration(milliseconds: 500),
                            child: Text(
                              "Price List is Empty",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12.sp),
                            ),
                          )
                        ],
                      ),
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(
                          child: Divider(
                        thickness: 1,
                        color: kColorgrey,
                      )),
                      shrinkWrap: true,
                      itemCount: controller.contactListItem.length,
                      itemBuilder: (context, indexs) {
                        return SwipeActionCell(
                          key: UniqueKey(),
                          trailingActions: <SwipeAction>[
                            SwipeAction(
                                performsFirstActionWithFullSwipe: false,
                                backgroundRadius: 6.w,
                                widthSpace: 20.w,
                                title: "Delete",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kColorwhite),
                                onTap: (CompletionHandler handler) async {
                                  customDeleteAlertDialogue(
                                    context,
                                    () async {
                                      controller.contactListItem
                                          .removeAt(indexs);
                                      Get.back();
                                    },
                                  );
                                },
                                color: Colors.red),
                          ],
                          child: MaterialListCustom(
                            amount: "",
                            name:
                                controller.contactListItem[indexs].department ??
                                    "",
                            quantity: controller
                                    .contactListItem[indexs].designation ??
                                "",
                            onlongpress: () {
                              customDeleteAlertDialogue(
                                context,
                                () {
                                  controller.contactListItem.removeAt(indexs);
                                  Get.back();
                                },
                              );
                            },
                            ontap: () {
                              controller.departmentController.text = controller
                                      .contactListItem[indexs].department ??
                                  "";
                              controller.designationController.text = controller
                                      .contactListItem[indexs].designation ??
                                  "";
                              controller.namecontactListController.text =
                                  controller.contactListItem[indexs].name ?? "";
                              controller.emailContactListController.text =
                                  controller.contactListItem[indexs].email ??
                                      "";
                              controller.primaryPhoneNumontactListController
                                  .text = controller.contactListItem[indexs]
                                      .primaryPhoneNumber ??
                                  "";
                              controller.secPhoneNumontactListController.text =
                                  controller.contactListItem[indexs]
                                          .secondaryPhoneNumber ??
                                      "";
                              controller.remarkContactController.text =
                                  controller.contactListItem[indexs].remarks
                                          ?.toString() ??
                                      "";

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Form(
                                    key: formKey,
                                    child: CustomPopup(
                                        title: 'Price Details',
                                        onCancelPressed: () {
                                          Get.back();
                                          controller.namecontactListController
                                              .clear();
                                          controller.emailContactListController
                                              .clear();
                                          controller
                                              .primaryPhoneNumontactListController
                                              .clear();
                                          controller
                                              .secPhoneNumontactListController
                                              .clear();
                                          controller.remarkContactController
                                              .clear();
                                        },
                                        onUpdatePressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            controller.contactListItem[indexs]
                                                    .name =
                                                controller
                                                    .namecontactListController
                                                    .text;
                                            controller.contactListItem[indexs]
                                                    .email =
                                                controller
                                                    .emailContactListController
                                                    .text;
                                            controller.contactListItem[indexs]
                                                    .primaryPhoneNumber =
                                                controller
                                                    .primaryPhoneNumontactListController
                                                    .text;
                                            controller.contactListItem[indexs]
                                                    .secondaryPhoneNumber =
                                                controller
                                                    .secPhoneNumontactListController
                                                    .text;
                                            controller.contactListItem[indexs]
                                                    .remarks =
                                                controller
                                                    .remarkContactController
                                                    .text;

                                            controller.contactListItem
                                                .refresh();

                                            Get.back();
                                            controller.namecontactListController
                                                .clear();
                                            controller
                                                .emailContactListController
                                                .clear();
                                            controller
                                                .primaryPhoneNumontactListController
                                                .clear();
                                            controller
                                                .secPhoneNumontactListController
                                                .clear();
                                            controller.remarkContactController
                                                .clear();
                                          } else {}
                                        },
                                        saveButtonText: "Save",
                                        children: [
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller: controller
                                                  .departmentController,
                                              label: "Department"),
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller: controller
                                                  .designationController,
                                              label: "Designation"),
                                          CustomTextField(
                                              // readonly: true,
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller: controller
                                                  .namecontactListController,
                                              label: "Name"),
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              // readonly: true,
                                              controller: controller
                                                  .emailContactListController,
                                              label: "Email"),
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              textInputType:
                                                  TextInputType.number,
                                              // readonly: true,
                                              controller: controller
                                                  .primaryPhoneNumontactListController,
                                              label: "Primary Number"),
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              textInputType:
                                                  TextInputType.number,

                                              // readonly: true,
                                              controller: controller
                                                  .secPhoneNumontactListController,
                                              label: "Sec Phone No"),
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller: controller
                                                  .remarkContactController,
                                              label: "Remarks")
                                        ]),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class buildPriceList extends StatelessWidget {
  final Widget partyTypefield;
  final Widget expenseHeaderfield;
  final VoidCallback itemAddButton;

  final bool isEdit;
  List<MaterialPriceListDTOList>? priceList;
  PartyBankMapDTOList? bankList;

  buildPriceList({
    super.key,
    required this.controller,
    required this.partyTypefield,
    required this.expenseHeaderfield,
    required this.itemAddButton,
    required this.isEdit,
    this.priceList,
    this.bankList,
  });

  final PartyMasterController controller;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.h,
          ),
          partyTypefield,
          Row(
            children: [
              Expanded(flex: 5, child: expenseHeaderfield),
              Expanded(
                child: GestureDetector(
                  onTap: itemAddButton,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: kElevationToShadow[3]),
                    child: CircleAvatar(
                      radius: 2.4.h,
                      backgroundColor: const Color.fromARGB(255, 248, 235, 234),
                      child: Icon(
                        Icons.add,
                        size: 22.sp,
                        color: kColorblack,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Obx(
            () => Expanded(
              child: controller.materialPriceItem.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeIn(
                              delay: const Duration(milliseconds: 300),
                              duration: const Duration(milliseconds: 300),
                              child: LottieBuilder.asset(
                                  "assets/lottie/empty.json",
                                  height: 15.h)),
                          SizedBox(
                            height: 3.h,
                          ),
                          FadeIn(
                            delay: const Duration(milliseconds: 500),
                            duration: const Duration(milliseconds: 500),
                            child: Text(
                              "Price List is Empty",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15.sp),
                            ),
                          )
                        ],
                      ),
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(
                          child: Divider(
                        thickness: 1,
                        color: kColorgrey,
                      )),
                      shrinkWrap: true,
                      itemCount: controller.materialPriceItem.length,
                      itemBuilder: (context, indexs) {
                        return SwipeActionCell(
                          key: UniqueKey(),
                          trailingActions: <SwipeAction>[
                            SwipeAction(
                                performsFirstActionWithFullSwipe: false,
                                backgroundRadius: 6.w,
                                widthSpace: 20.w,
                                title: "Delete",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kColorwhite),
                                onTap: (CompletionHandler handler) async {
                                  customDeleteAlertDialogue(
                                    context,
                                    () async {
                                      controller.materialPriceItem
                                          .removeAt(indexs);
                                      Get.back();
                                    },
                                  );
                                },
                                color: Colors.red),
                          ],
                          child: MaterialListCustom(
                            amount: "",
                            name: controller
                                    .materialPriceItem[indexs].materialName ??
                                "",
                            quantity: controller.materialPriceItem[indexs]
                                    .materialTypeName ??
                                "",
                            onlongpress: () {
                              customDeleteAlertDialogue(
                                context,
                                () {
                                  controller.materialPriceItem.removeAt(indexs);
                                  Get.back();
                                },
                              );
                            },
                            ontap: () {
                              controller.materialTypePriceController.text =
                                  controller.materialPriceItem[indexs]
                                      .materialTypeName!;
                              controller.materialNamePriceController.text =
                                  controller
                                      .materialPriceItem[indexs].materialName!;
                              controller.sellingPriceController.text =
                                  controller.materialPriceItem[indexs]
                                          .sellingPrice
                                          ?.toString() ??
                                      "";

                              controller.materialNumController.text = controller
                                      .materialPriceItem[indexs].partNumber ??
                                  "0.0";
                              controller.currentSellingPriceController.text =
                                  controller.materialPriceItem[indexs]
                                          .currentSellingPrice
                                          ?.toString() ??
                                      "0.0";
                              controller.commentsController.text = controller
                                      .materialPriceItem[indexs].comment ??
                                  "--";

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Form(
                                    key: formKey,
                                    child: CustomPopup(
                                        title: 'Price Details',
                                        onCancelPressed: () {
                                          Get.back();
                                          controller.sellingPriceController
                                              .clear();
                                          controller.commentsController.clear();
                                        },
                                        onUpdatePressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            controller.materialPriceItem[indexs]
                                                .sellingPrice = controller
                                                    .sellingPriceController
                                                    .text
                                                    .isNotEmpty
                                                ? double.tryParse(controller
                                                    .sellingPriceController
                                                    .text)
                                                : 0.0;
                                            controller.materialPriceItem[indexs]
                                                    .comment =
                                                controller
                                                    .commentsController.text;

                                            controller.materialPriceItem
                                                .refresh();

                                            Get.back();
                                            controller.sellingPriceController
                                                .clear();
                                            controller.commentsController
                                                .clear();
                                            // controller.openingBalanceController.clear();
                                            // controller.branchController.clear();
                                            // controller.bankNameController.clear();
                                          } else {}
                                        },
                                        saveButtonText: "Save",
                                        children: [
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller: controller
                                                  .materialTypePriceController,
                                              label: "MaterialType"),
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller: controller
                                                  .materialNamePriceController,
                                              label: "Material-Name"),
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller: controller
                                                  .materialNumController,
                                              label: "Material Number"),
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller: controller
                                                  .currentSellingPriceController,
                                              label: "Current selling Price"),
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              textInputType:
                                                  TextInputType.number,
                                              obscure: false,
                                              controller: controller
                                                  .sellingPriceController,
                                              label: "Selling Price"),
                                          CustomTextField(
                                              validator: (value) {
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscure: false,
                                              controller:
                                                  controller.commentsController,
                                              label: "Comments")
                                        ]),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class buildBankList extends StatelessWidget {
  final Widget expenseHeaderfield;
  final VoidCallback itemAddButton;
  List<PartyBankMapDTOList>? bankList;
  final bool isEdit;

  buildBankList({
    super.key,
    required this.controller,
    required this.isEdit,
    this.bankList,
    required this.expenseHeaderfield,
    required this.itemAddButton,
  });

  final PartyMasterController controller;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(flex: 6, child: expenseHeaderfield),
              Expanded(
                child: GestureDetector(
                  onTap: itemAddButton,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: kElevationToShadow[3]),
                    child: CircleAvatar(
                      radius: 2.4.h,
                      backgroundColor: kColorlightBlue,
                      child: Icon(
                        Icons.add,
                        size: 22.sp,
                        color: kColorwhite,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Obx(
            () => Expanded(
              child: controller.materialBankItem.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 6.h,
                          ),
                          FadeIn(
                              delay: const Duration(milliseconds: 300),
                              duration: const Duration(milliseconds: 300),
                              child: LottieBuilder.asset(
                                  "assets/lottie/empty.json",
                                  height: 15.h)),
                          SizedBox(
                            height: 3.h,
                          ),
                          FadeIn(
                            delay: const Duration(milliseconds: 500),
                            duration: const Duration(milliseconds: 500),
                            child: Text(
                              "Bank List is Empty",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12.sp),
                            ),
                          )
                        ],
                      ),
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Divider(
                          thickness: 1,
                          color: kColorgrey,
                        ),
                      )),
                      shrinkWrap: true,
                      itemCount: controller.materialBankItem.length,
                      itemBuilder: (context, index) {
                        return SwipeActionCell(
                          key: UniqueKey(),
                          trailingActions: <SwipeAction>[
                            SwipeAction(
                                performsFirstActionWithFullSwipe: false,
                                backgroundRadius: 6.w,
                                widthSpace: 20.w,
                                title: "Delete",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kColorwhite),
                                onTap: (CompletionHandler handler) async {
                                  customDeleteAlertDialogue(
                                    context,
                                    () async {
                                      controller.materialBankItem
                                          .removeAt(index);
                                      Get.back();
                                    },
                                  );
                                },
                                color: Colors.red),
                          ],
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: ListTile(
                              trailing: controller
                                          .materialBankItem[index].isChecked ==
                                      1
                                  ? const Text(
                                      "Default",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : const Text(""),
                              title: Text(
                                  controller.materialBankItem[index].bankname ??
                                      ""),
                              subtitle: Text(
                                  controller.materialBankItem[index].ifsc ??
                                      ""),
                              onLongPress: () {
                                customDeleteAlertDialogue(
                                  context,
                                  () {
                                    controller.materialBankItem.removeAt(index);
                                    Get.back();
                                  },
                                );
                              },
                              onTap: () {
                                controller.bankNameController.text = controller
                                        .materialBankItem[index].bankname ??
                                    "";
                                controller.ifscController.text =
                                    controller.materialBankItem[index].ifsc ??
                                        "";
                                controller.branchController.text =
                                    controller.materialBankItem[index].branch ??
                                        "";
                                controller.aCController.text = controller
                                        .materialBankItem[index]
                                        .accountNumber ??
                                    "";
                                controller.openingBalanceController.text =
                                    controller.materialBankItem[index]
                                            .openingBalance
                                            ?.toString() ??
                                        "";
                                controller.isDefault.value = controller
                                            .materialBankItem[index]
                                            .isChecked ==
                                        1
                                    ? true
                                    : false;
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Form(
                                      key: formKey,
                                      child: CustomPopup(
                                          title: 'Bank Details',
                                          onCancelPressed: () {
                                            Get.back();
                                            controller.aCController.clear();
                                            controller.ifscController.clear();
                                            controller.openingBalanceController
                                                .clear();
                                            controller.branchController.clear();
                                            controller.bankNameController
                                                .clear();
                                            controller.isDefault.value = false;
                                          },
                                          onUpdatePressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              controller.materialBankItem[index]
                                                  .accountNumber = controller
                                                      .aCController.text.isEmpty
                                                  ? ""
                                                  : controller
                                                      .aCController.text;
                                              controller.materialBankItem[index]
                                                      .ifsc =
                                                  controller
                                                      .ifscController.text;
                                              controller.materialBankItem[index]
                                                  .openingBalance = controller
                                                      .openingBalanceController
                                                      .text
                                                      .isNotEmpty
                                                  ? double.tryParse(controller
                                                      .openingBalanceController
                                                      .text)
                                                  : 0.0;
                                              controller.materialBankItem[index]
                                                      .branch =
                                                  controller
                                                      .branchController.text;
                                              controller.materialBankItem[index]
                                                      .isChecked =
                                                  controller.isDefault.value ==
                                                          true
                                                      ? 1
                                                      : 0;

                                              controller.materialBankItem
                                                  .refresh();

                                              Get.back();
                                              controller.aCController.clear();
                                              controller.ifscController.clear();
                                              controller
                                                  .openingBalanceController
                                                  .clear();
                                              controller.branchController
                                                  .clear();
                                              controller.bankNameController
                                                  .clear();
                                              controller.isDefault.value =
                                                  false;
                                            } else {}
                                          },
                                          saveButtonText: "Save",
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow:
                                                      kElevationToShadow[2],
                                                  color: kColorwhite),
                                              child: switchCustom(
                                                Obx(() => Switch(
                                                      value: controller
                                                          .isDefault.value,
                                                      onChanged: (value) {
                                                        controller.isDefault
                                                            .value = value;
                                                      },
                                                    )),
                                                "Is Default",
                                              ),
                                            ),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter bankname";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction:
                                                    TextInputAction.next,
                                                obscure: false,
                                                controller: controller
                                                    .bankNameController,
                                                label: "Bank"),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter branch";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction:
                                                    TextInputAction.next,
                                                obscure: false,
                                                controller:
                                                    controller.branchController,
                                                label: "Branch "),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter IFSC CODE";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction:
                                                    TextInputAction.next,
                                                obscure: false,
                                                controller:
                                                    controller.ifscController,
                                                label: "IFSC Code "),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter A/C Number";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction:
                                                    TextInputAction.next,
                                                obscure: false,
                                                controller:
                                                    controller.aCController,
                                                label: "A/C Number"),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter Balance";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction:
                                                    TextInputAction.next,
                                                obscure: false,
                                                controller: controller
                                                    .openingBalanceController,
                                                label: "Opening Balance")
                                          ]),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }
}

class TabContainer extends StatelessWidget {
  final String text;
  final bool isSelected;
  final IconData icon;

  const TabContainer(
      {required this.text, required this.isSelected, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: isSelected
            ? Container(
                width: isSelected ? null : 5.w, // Increase width if selected
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.blue.shade50),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        icon,
                        color: Colors.grey.shade800,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        text,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors
                              .grey.shade800, // Change color based on selection
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.transparent,
                    border: Border.all(
                      color: kColorlightBlue,
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(icon),
                )));
  }
}
