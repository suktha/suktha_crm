// ignore_for_file: must_be_immutable, avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
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
import 'package:work_Force/Model/type_model.dart';
import 'package:work_Force/controllers/party_master_controller.dart';
import 'package:work_Force/view/screens/My_account/more_module/Masters/Masters%20Items/Party%20Master/Tab_screens/bank_list.dart';
import 'package:work_Force/view/screens/My_account/more_module/Masters/Masters%20Items/Party%20Master/Tab_screens/contact_list.dart';
import 'package:work_Force/view/screens/My_account/more_module/Masters/Masters%20Items/Party%20Master/Tab_screens/document_wallet_list.dart';
import 'package:work_Force/view/screens/My_account/more_module/Masters/Masters%20Items/Party%20Master/Tab_screens/price_list.dart';
import 'package:work_Force/view/screens/My_account/more_module/Masters/Masters%20Items/Party%20Master/Tab_screens/service_details_list.dart';
import 'package:work_Force/view/screens/My_account/more_module/Masters/Masters%20Items/Party%20Master/Tab_screens/terms_and_condition_list.dart';
import 'package:work_Force/view/screens/My_account/more_module/Masters/Masters%20Items/Party%20Master/View%20Party%20Master/list_party_master.dart';
import 'package:work_Force/view/widget/LoadingScreenwithText.dart';
import 'package:work_Force/view/widget/custom_button.dart';
import 'package:work_Force/view/widget/custom_dropdown.dart';
import 'package:work_Force/view/widget/custom_dropdown_with_search.dart';
import 'package:work_Force/view/widget/snackbar.dart';

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
    print(
        "controller.materailTypeList === ${controller.materailTypeList.length}");
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
                  fontSize: 18.5.sp),
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
                  SizedBox(
                    height: 2.h,
                  ),
                  Expanded(
                    child: SizedBox(
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
                              child: Obx(() => Padding(
                                  padding: EdgeInsets.only(
                                      left: 3.w,
                                      right: 3.w,
                                      top: 2.w,
                                      bottom: 1.w),
                                  child: SizedBox(
                                    height: 6.h,
                                    child: CustomDropdown(
                                      value: controller.materialIdName.value,
                                      items: controller.materailTypeList
                                          .map((e) => e.name.toString())
                                          .toList(),
                                      hintText: 'Material Type*',
                                      onChanged: (newValue) async {
                                        controller.materialIdName.value =
                                            newValue!;

                                        materialTypeValue = controller
                                            .materailTypeList
                                            .firstWhere(
                                          (item) =>
                                              item.name.toString() == newValue,
                                        );

                                        if (materialTypeValue != null) {
                                          controller
                                                  .materialTypeController.text =
                                              materialTypeValue!.name ?? '';
                                          controller.materialId.value =
                                              materialTypeValue!.id ?? 0;
                                        }

                                        controller.materialNameController
                                            .clear();
                                        await controller
                                            .getMaterialNameList("");
                                      },
                                    ),
                                  ))),
                            ),
                            expenseHeaderfield: FadeIn(
                              delay: const Duration(milliseconds: 300),
                              duration: const Duration(milliseconds: 300),
                              child: Container(
                                  margin: EdgeInsets.all(2.w),
                                  height: 6.h,
                                  child:
                                      CustomDropdownWithSearch<MaterialModel>(
                                    controller:
                                        controller.materialNameController,
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
                                      materialPriceValue!.price,
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
                                // FocusScope.of(context).unfocus();

                                controller.materialPriceItem.add(value);
                              }

                              controller.materialTypeController.clear();
                              controller.materialNameController.clear();
                              controller.materialIdName.value = "";
                              controller.materialId.value = 0;
                            },
                          ),
                          BuildBankList(
                            isEdit: widget.isEdit,
                            bankList: widget.bankList,
                            controller: controller,
                            expenseHeaderfield: FadeIn(
                              delay: const Duration(milliseconds: 300),
                              duration: const Duration(milliseconds: 300),
                              child: Obx(() => Container(
                                    margin: EdgeInsets.all(4.w),
                                    height: 6.h,
                                    // width: 50.w,
                                    child: CustomDropdown(
                                      value: controller.bankIdName.value,
                                      items: controller.bankList
                                          .map((e) => e.bankname.toString())
                                          .toList(),
                                      hintText: 'Bank Name',
                                      onChanged: (newValue) async {
                                        controller.bankIdName.value = newValue!;

                                        controller.bankValue =
                                            controller.bankList.firstWhere(
                                          (item) =>
                                              item.bankname.toString() ==
                                              newValue,
                                        );

                                        if (controller.bankValue != null) {
                                          controller.bankNameController.text =
                                              controller.bankValue!.bankname ??
                                                  '';
                                          controller.bankId.value =
                                              controller.bankValue!.id ?? 0;
                                        }
                                      },
                                    ),
                                  )),
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
                              controller.bankIdName.value = "";
                              controller.bankId.value = 0;
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
                                    child: SizedBox(
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
                                      child: SizedBox(
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
                                                        child: Text(item
                                                            .designationName),
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

class TabContainer extends StatelessWidget {
  final String text;
  final bool isSelected;
  final IconData icon;

  const TabContainer(
      {super.key,
      required this.text,
      required this.isSelected,
      required this.icon});

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
