// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Model/bank_model.dart';
import 'package:work_Force/Model/company_model.dart';
import 'package:work_Force/Model/company_profile_model.dart';
import 'package:work_Force/Model/material_models.dart';
import 'package:work_Force/controllers/Home_controller.dart';
import 'package:work_Force/controllers/settings_controller.dart';
import 'package:work_Force/utils/Services/sharedpref_services.dart';
import 'package:work_Force/view/settings_module/Account%20Settings/widgets/bank_list_screen.dart';
import 'package:work_Force/view/settings_module/Account%20Settings/widgets/basic_info_screen.dart';
import 'package:work_Force/view/settings_module/Account%20Settings/widgets/branch_list_screen.dart';
import 'package:work_Force/view/settings_module/Account%20Settings/widgets/contact_list.dart';
import 'package:work_Force/view/settings_module/Account%20Settings/widgets/document_wallet_screen.dart';
import 'package:work_Force/view/settings_module/Account%20Settings/widgets/edit_company_details.dart';
import 'package:work_Force/view/bottom_navigation/bottom_navigation_mainscreen.dart';
import 'package:work_Force/view/screens/home_screen/Home_Screen.dart';
import 'package:work_Force/view/widget/custom_button.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';
import 'package:work_Force/view/widget/snackbar.dart';
import '../../../../Constants/shared_pref_keys.dart';

class CompanyDetailsScreen extends StatefulWidget {
  final CompanyModel companyDetails;

  // Uint8List? companyLogo;
  const CompanyDetailsScreen({
    super.key,
    required this.companyDetails,
  });

  @override
  State<CompanyDetailsScreen> createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends State<CompanyDetailsScreen> {
  MaterialModel? materialPriceValue;

  // final controller = Get.find<SettingsController>();
  final homeController = Get.put(HomeController());
  final controller = Get.put(SettingsController());

  // CompanyModel? companyDetails;

  getCompanyLogo() async {
    await homeController.getCompanyDetails();
    String? newvalue = SharedPreferencesService.instance
        .getValue(SharedPrefKeys().CompanyLogoKey);
    String? companyEncodedDetails = SharedPreferencesService.instance
        .getValue(SharedPrefKeys().CompanyDetailsKey);
    if (companyEncodedDetails != null) {
      print(controller.companyDetailsValue!.iecCode);
    }

    if (newvalue != null) {
      controller.companyLogo.value = base64Decode(newvalue);
    }
  }

  int initialIndex = 0;

  @override
  void initState() {
    controller.getDepartmentList();
    controller.getDesignationList();
    controller.getDocumentWalletList();
    controller.getCompanyCertificationImage();
    controller.getCompanyQrCode();
    controller.getCompanySignatureImage();
    controller.companyDetailsValue = widget.companyDetails;

    if (controller.isFromSettings.value == false) {
      print("inside company details screen");
      getCompanyLogo();
    }

    super.initState();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // PartyBankMapDTOList banklistValue;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.height;
    double width = screenSize.width;

    Timer(Duration.zero, () {
      controller.companyLogo.value == true ? getCompanyLogo() : SizedBox();
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Obx(() => Hero(
                        tag: "company_image",
                        child: Container(
                          height: height * 0.25,
                          width: width,
                          decoration: BoxDecoration(
                            // color: kColorlightBlue300,
                            image: controller.companyLogo.value != null
                                ? DecorationImage(
                                    image: MemoryImage(
                                        controller.companyLogo.value!),
                                    fit: BoxFit.contain,
                                  )
                                : DecorationImage(
                                    image: NetworkImage(
                                        "https://cdn.vectorstock.com/i/preview-1x/65/30/default-image-icon-missing-picture-page-vector-40546530.jpg"),
                                    fit: BoxFit.fitWidth,
                                  ),
                          ),
                        ),
                      )),
                  Positioned(
                    top: height *
                        0.01, // Adjust the value to position the back button as needed
                    left: width *
                        0.02, // Adjust the value to position the back button as needed
                    child: GestureDetector(
                      onTap: () {
                        Get.offAll(
                            () => const BottomNavigationMainscreen(
                                  initialIndex: 2,
                                ),
                            transition: Transition.fade,
                            duration: const Duration(milliseconds: 700));
                        controller.isFromSettings.value = false;
                      },
                      child: CircleAvatar(
                        backgroundColor: kColorwhite,
                        child: Icon(Icons.keyboard_arrow_left),
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.14,
                    right: width * 0.04,
                    child: InkWell(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return UploadCompanyLogoWidget(
                              buttonText: "Upload Logo",
                              ontap: () async {
                                var file = await controller.obtainImage(
                                    source: ImageSource.gallery);

                                await controller.uploadCompanyLogo(file!);

                                setState(() {
                                  getCompanyLogo();
                                });

                                Get.back();
                              },
                            );
                          },
                        );
                      },
                      child: CircleAvatar(
                        radius: 5.5.w,
                        backgroundColor: kColorlightBlue,
                        child: CircleAvatar(
                          backgroundColor: kColorwhite,
                          child: Icon(Icons.camera_alt_outlined),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: height * 0.2,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: FadeInUp(
                      child: Container(
                        padding: EdgeInsets.all(width * 0.05),
                        height: height - height * 0.27,
                        decoration: BoxDecoration(
                          color: kColorwhite,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(width * 0.1),
                            topRight: Radius.circular(width * 0.1),
                          ), // Adjust the radius as needed
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 70.w,
                                  child: Text(
                                    controller.companyDetailsValue?.name ?? "",
                                    style: TextStyle(
                                        fontSize: width * 0.06,
                                        fontWeight: FontWeight.bold,
                                        color: kColorblack),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    controller.primaryMobNumController.text =
                                        controller.companyDetailsValue
                                                ?.primaryMobile ??
                                            "";
                                    controller.seconMobileController.text =
                                        controller.companyDetailsValue
                                                ?.secondaryMobile ??
                                            "";
                                    controller.contactPersonController.text =
                                        controller.companyDetailsValue
                                                ?.contactPersonName ??
                                            "";
                                    controller.contactPersonNumController.text =
                                        controller.companyDetailsValue
                                                ?.contactPersonNumber ??
                                            "";
                                    controller.primaryTelephoneNumController
                                        .text = controller.companyDetailsValue
                                            ?.primaryTelephone ??
                                        "";
                                    controller.secondaryTelephoneNumController
                                        .text = controller.companyDetailsValue
                                            ?.secondaryTelephone ??
                                        "";
                                    controller.websiteController.text =
                                        controller
                                                .companyDetailsValue?.website ??
                                            "";
                                    controller.emailController.text =
                                        controller.companyDetailsValue?.email ??
                                            "";
                                    controller.faxNumController.text =
                                        controller.companyDetailsValue
                                                ?.faxNumber ??
                                            "";
                                    controller.addressController.text =
                                        controller
                                                .companyDetailsValue?.address ??
                                            "";
                                    controller.taglineController.text =
                                        controller
                                                .companyDetailsValue?.tagLine ??
                                            "";
                                    controller.pincodeController.text =
                                        controller
                                                .companyDetailsValue?.pinCode ??
                                            "";
                                    controller.panNumController.text =
                                        controller.companyDetailsValue
                                                ?.panNumber ??
                                            "";
                                    controller.iecCodeController.text =
                                        controller
                                                .companyDetailsValue?.iecCode ??
                                            "";
                                    controller.msmeNumController.text =
                                        controller.companyDetailsValue
                                                ?.msmeNumber ??
                                            "";
                                    controller.cinNumController.text =
                                        controller.companyDetailsValue
                                                ?.cinNumber ??
                                            "";
                                    if (controller.companyDetailsValue
                                            ?.companyCurrencyId ==
                                        null) {
                                      print("inside-----");
                                      controller.currencyId.value = "";
                                    } else if (controller.companyDetailsValue
                                            ?.companyCurrencyId !=
                                        null) {
                                      controller.currencyId.value = controller
                                              .companyDetailsValue
                                              ?.companyCurrencyId
                                              .toString() ??
                                          "";
                                    }

                                    if (controller
                                            .companyDetailsValue?.cityId ==
                                        null) {
                                      controller.cityId.value = "";
                                    } else if (controller
                                            .companyDetailsValue?.cityId !=
                                        null) {
                                      controller.cityId.value = controller
                                              .companyDetailsValue?.cityId
                                              .toString() ??
                                          "";
                                    }
                                    await CompanyDetailsBottomSheet(
                                        context,
                                        controller.companyDetailsValue!,
                                        controller);
                                  },
                                  child: CircleAvatar(
                                    child: Icon(Icons.edit),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              controller.companyDetailsValue
                                          ?.gstRegistrationName ==
                                      null
                                  ? ""
                                  : controller.companyDetailsValue
                                          ?.gstRegistrationName
                                          .toString() ??
                                      "",
                              style: TextStyle(
                                  fontSize: width * 0.038,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                  color: kColorgrey),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "${controller.companyDetailsValue?.stateName == null ? "" : controller.companyDetailsValue?.stateName.toString()} ",
                              style: TextStyle(
                                  fontSize: width * 0.038,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w400,
                                  color: kColorgrey),
                            ),
                            // Text(
                            //   "India",
                            //   style: TextStyle(fontSize: width * 0.038, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w400, color: kColorgrey),
                            // ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: double.infinity,
                                child: ContainedTabBarView(
                                  callOnChangeWhileIndexIsChanging: true,
                                  initialIndex: 0,
                                  tabBarProperties: TabBarProperties(
                                    isScrollable: true,
                                    indicatorColor: kColorlightBlue,
                                    indicatorWeight: 2,
                                    unselectedLabelStyle:
                                        TextStyle(fontSize: 15.sp),
                                    labelStyle: TextStyle(fontSize: 16.sp),
                                    labelColor: kColorblack,
                                    labelPadding: EdgeInsets.symmetric(
                                      horizontal: 1.w,
                                    ),
                                    unselectedLabelColor: kColorgrey,
                                  ),
                                  tabs: const [
                                    Padding(
                                      padding: EdgeInsets.only(right: 15.0),
                                      child: Text(
                                        'Basic Info',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 15.0),
                                      child: Text(
                                        'Bank List',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 15.0),
                                      child: Text(
                                        'Contact List',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 15.0),
                                      child: Text(
                                        'Branch List',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 15.0),
                                      child: Text(
                                        'Document Wallet',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                  views: [
                                    BasicInfoScreen(),
                                    BankListScreen(
                                        controller: controller,
                                        isEdit: false,
                                        expenseHeaderfield: Form(
                                          key: formKey,
                                          child: Column(
                                            children: [
                                              FadeIn(
                                                delay: const Duration(
                                                    milliseconds: 300),
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                child: SizedBox(
                                                  child:
                                                      TypeAheadField<BankModel>(
                                                    autoFlipDirection: true,
                                                    debounceDuration: Duration(
                                                        milliseconds: 500),

                                                    builder: (context,
                                                        bankNamecontroller,
                                                        bankNamefocusNode) {
                                                      return TextFormField(
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return "Select bank name";
                                                            }
                                                            return null;
                                                          },
                                                          controller:
                                                              bankNamecontroller,
                                                          focusNode:
                                                              bankNamefocusNode,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                "Bank Name*",
                                                            suffixIcon: Icon(
                                                              Icons
                                                                  .arrow_drop_down,
                                                              color:
                                                                  kColorblack,
                                                            ),
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    left: 3.w),
                                                            labelStyle: TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .fade,
                                                                fontSize: 16.sp,
                                                                color: Color
                                                                    .fromARGB(
                                                                        213,
                                                                        78,
                                                                        78,
                                                                        78),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                            errorBorder:
                                                                UnderlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          kColorRed),
                                                            ),
                                                            disabledBorder:
                                                                UnderlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          kColorgrey),
                                                            ),
                                                            enabledBorder:
                                                                UnderlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          kColorgrey),
                                                            ),
                                                            border:
                                                                UnderlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          kColorgrey),
                                                            ),
                                                          ));
                                                    },

                                                    controller: controller
                                                        .bankNameController,

                                                    // getImmediateSuggestions: true,
                                                    suggestionsCallback:
                                                        controller.getBankList,
                                                    // hideKeyboard: true,
                                                    // hideKeyboardOnDrag: true,

                                                    itemBuilder: (context,
                                                        BankModel suggestion) {
                                                      final quotNumber =
                                                          suggestion;
                                                      return ListTile(
                                                        title: Text(quotNumber
                                                            .bankname!),
                                                      );
                                                    },
                                                    loadingBuilder: (context) {
                                                      return SizedBox(
                                                          height: 10.h,
                                                          child: Center(
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
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    13.sp),
                                                          ),
                                                        ),
                                                      );
                                                    },

                                                    onSelected:
                                                        (BankModel suggestion) {
                                                      controller.bankValue =
                                                          suggestion;

                                                      controller
                                                              .bankNameController
                                                              .text =
                                                          controller.bankValue!
                                                              .bankname
                                                              .toString();
                                                    },
                                                  ),
                                                ),
                                              ),
                                              CustomTextField(
                                                  validator: (value) {
                                                    return null;
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  obscure: false,
                                                  maxLength: 100,
                                                  controller: controller
                                                      .branchController,
                                                  label: "Branch "),
                                              CustomTextField(
                                                  validator: (value) {
                                                    return null;
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  obscure: false,
                                                  maxLength: 15,
                                                  controller:
                                                      controller.ifscController,
                                                  label: "IFSC Code "),
                                              CustomTextField(
                                                  validator: (value) {
                                                    return null;
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  obscure: false,
                                                  controller:
                                                      controller.aCController,
                                                  label: "A/C Number"),
                                              CustomTextField(
                                                  validator: (value) {
                                                    return null;
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  textInputType:
                                                      TextInputType.number,
                                                  obscure: false,
                                                  maxLength: 30,
                                                  controller:
                                                      controller.bankADCode,
                                                  label: "Bank AD Code"),
                                              CustomTextField(
                                                  validator: (value) {
                                                    return null;
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  obscure: false,
                                                  textInputType:
                                                      TextInputType.number,
                                                  controller:
                                                      controller.swiftCode,
                                                  maxLength: 20,
                                                  label: "Swift Code")
                                            ],
                                          ),
                                        ),
                                        itemAddButton: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            final value = PartyBankMapDTOList(
                                                accountNumber: controller
                                                        .aCController
                                                        .text
                                                        .isEmpty
                                                    ? null
                                                    : controller
                                                        .aCController.text,
                                                bankAdCode:
                                                    controller.bankADCode.text.isEmpty
                                                        ? null
                                                        : int.parse(controller
                                                            .bankADCode.text),
                                                bankId:
                                                    controller.bankValue!.id,
                                                branch: controller.branchController.text.isEmpty
                                                    ? null
                                                    : controller
                                                        .branchController.text,
                                                companyId: null,
                                                contactNumber: "",
                                                ifsc: controller.ifscController.text.isEmpty
                                                    ? null
                                                    : controller
                                                        .ifscController.text,
                                                openingBalance: null,
                                                partyId: null,
                                                swiftCode: controller.swiftCode.text.isEmpty
                                                    ? null
                                                    : int.parse(controller.swiftCode.text),
                                                bankname: controller.bankValue!.bankname,
                                                isChecked: controller.isDefault.value == true ? 1 : 0,
                                                id: null);

                                            controller.partyBankList.add(value);
                                            Get.back();
                                            controller.bankNameController
                                                .clear();
                                            controller.branchController.clear();
                                            controller.ifscController.clear();
                                            controller.aCController.clear();
                                            controller.bankADCode.clear();
                                            controller.swiftCode.clear();

                                            print("+ value---------$value");
                                            print(
                                                "+ bankname---------${controller.bankNameController.text}");
                                          } else {
                                            customSnackbar("Error",
                                                "Select Bank Name", "error");
                                          }
                                        }),
                                    CustomContactList(
                                      controller: controller,
                                      isEdit: false,
                                      designationHead: FadeIn(
                                        delay:
                                            const Duration(milliseconds: 300),
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Column(
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
                                                      underline: Divider(
                                                        color: Color.fromARGB(
                                                            255, 220, 220, 220),
                                                        thickness: 1,
                                                        height: 1,
                                                      ),
                                                      value: controller
                                                          .designationId.value,
                                                      items: [
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: "",
                                                          child: Text(
                                                              "Designation Type*"),
                                                        ),
                                                        ...controller
                                                            .designationList
                                                            .map((item) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                                  value: item.id
                                                                      .toString(),
                                                                  child: Text(item
                                                                      .designationName),
                                                                )),
                                                      ],
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          controller
                                                                  .designationId
                                                                  .value =
                                                              newValue!;

                                                          print(controller
                                                              .designationId
                                                              .value);

                                                          controller
                                                                  .designationController
                                                                  .text =
                                                              controller
                                                                  .designationList
                                                                  .firstWhere((item) =>
                                                                      item.id
                                                                          .toString() ==
                                                                      controller
                                                                          .designationId
                                                                          .value)
                                                                  .designationName;

                                                          print(controller
                                                              .designationController
                                                              .text);
                                                        });
                                                      },
                                                      hint: Text(
                                                          'Select an item'),
                                                    )),
                                              ),
                                            ),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter name";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction:
                                                    TextInputAction.next,
                                                obscure: false,
                                                controller: controller
                                                    .namecontactListController,
                                                label: "Name "),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter Email";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction:
                                                    TextInputAction.next,
                                                obscure: false,
                                                controller: controller
                                                    .emailContactListController,
                                                label: "Email"),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please Primary Phone Number";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction:
                                                    TextInputAction.next,
                                                obscure: false,
                                                controller: controller
                                                    .primaryPhoneNumontactListController,
                                                label: "Primary Phone Number"),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Secondary Phone Number";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction:
                                                    TextInputAction.next,
                                                textInputType:
                                                    TextInputType.number,
                                                obscure: false,
                                                controller: controller
                                                    .secPhoneNumontactListController,
                                                label:
                                                    "Secondary Phone Number"),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter Remarks";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction:
                                                    TextInputAction.next,
                                                obscure: false,
                                                textInputType:
                                                    TextInputType.number,
                                                controller: controller
                                                    .remarkContactController,
                                                label: "Remarks")
                                          ],
                                        ),
                                      ),
                                      itemAddButton: () {
                                        final value = PartyContactDetails(
                                            companyId: null,
                                            deleted: null,
                                            department: controller
                                                .departmentController.text,
                                            departmentId: int.parse(
                                                controller.departmentId.value),
                                            designation: controller
                                                .designationController.text,
                                            designationId: int.parse(
                                                controller.designationId.value),
                                            email: controller
                                                .emailContactListController
                                                .text,
                                            imp: null,
                                            isPrimary: null,
                                            name: controller
                                                .namecontactListController.text,
                                            partyId: null,
                                            primaryPhoneNumber: controller
                                                .primaryPhoneNumontactListController
                                                .text,
                                            remarks: controller
                                                .remarkContactController.text,
                                            secondaryPhoneNumber: controller
                                                .secPhoneNumontactListController
                                                .text,
                                            id: null);

                                        controller.partyContactItems.add(value);

                                        controller.bankNameController.clear();

                                        Get.back();

                                        print("+ value---------$value");
                                      },
                                      departmentHead: FadeIn(
                                        delay:
                                            const Duration(milliseconds: 300),
                                        duration:
                                            const Duration(milliseconds: 300),
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
                                                  underline: Divider(
                                                    color: Color.fromARGB(
                                                        255, 220, 220, 220),
                                                    thickness: 1,
                                                    height: 1,
                                                  ),
                                                  value: controller
                                                      .departmentId.value,
                                                  items: [
                                                    DropdownMenuItem<String>(
                                                      value: "",
                                                      child: Text(
                                                          "Department Type*"),
                                                    ),
                                                    ...controller.departmentList
                                                        .map((item) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                              value: item.id
                                                                  .toString(),
                                                              child: Text(
                                                                  "${item.departmentName}"),
                                                            )),
                                                  ],
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      controller.departmentId
                                                          .value = newValue!;

                                                      print(controller
                                                          .departmentId.value);

                                                      controller
                                                              .departmentController
                                                              .text =
                                                          controller
                                                              .departmentList
                                                              .firstWhere((item) =>
                                                                  item.id
                                                                      .toString() ==
                                                                  controller
                                                                      .departmentId
                                                                      .value)
                                                              .departmentName!;

                                                      print(controller
                                                          .departmentController
                                                          .text);
                                                    });
                                                  },
                                                  hint: Text('Select an item'),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                    BranchListScreen(
                                      controller: controller,
                                      isEdit: false,
                                      expenseHeaderfield: Form(
                                        key: formKey,
                                        child: Column(
                                          children: [
                                            Obx(
                                              () => Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0, right: 5),
                                                child: SizedBox(
                                                    // margin: EdgeInsets.all(2.w),
                                                    height: 7.h,
                                                    // width: 30.w,
                                                    child: DropdownButton(
                                                      isExpanded: true,
                                                      underline: Divider(
                                                        color: Color.fromARGB(
                                                            255, 220, 220, 220),
                                                        thickness: 1,
                                                        height: 1,
                                                      ),
                                                      value: controller
                                                          .branchId.value,
                                                      items: [
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: "",
                                                          child: Text(
                                                              "Branch Admin*"),
                                                        ),
                                                        ...controller.userList
                                                            .map((item) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                                  value: item
                                                                      .name
                                                                      .toString(),
                                                                  child: Text(
                                                                      "${item.name}"),
                                                                )),
                                                      ],
                                                      onChanged: (newValue) {
                                                        if (controller
                                                            .partyBranchItems
                                                            .any(
                                                          (element) =>
                                                              element
                                                                  .branchAdminName
                                                                  .toString() ==
                                                              newValue,
                                                        )) {
                                                          customSnackbar(
                                                              "Invalid Selection",
                                                              "This branch admin is already assigned.",
                                                              "error");
                                                          // Get.snackbar(
                                                          //   "Invalid Selection",
                                                          //   "",
                                                          //   snackPosition: SnackPosition.BOTTOM,
                                                          // );
                                                        } else {
                                                          controller
                                                              .branchAdminController
                                                              .text = newValue!;

                                                          controller.branchId
                                                                  .value =
                                                              controller
                                                                  .branchAdminController
                                                                  .text;
                                                          controller
                                                                  .selectedBranchId
                                                                  .value =
                                                              controller
                                                                  .userList
                                                                  .firstWhere(
                                                                    (element) =>
                                                                        element
                                                                            .name ==
                                                                        controller
                                                                            .branchAdminController
                                                                            .text,
                                                                  )
                                                                  .id
                                                                  .toString();
                                                          print(
                                                              "id---${controller.selectedBranchId.value}");

                                                          print(
                                                              "selected branch name --${controller.branchAdminController.text}");
                                                        }
                                                      },
                                                      hint: Text(
                                                          'Select an item'),
                                                    )),
                                              ),
                                            ),
                                            CustomTextField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter Branch Name";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputAction:
                                                    TextInputAction.next,
                                                obscure: false,
                                                textInputType:
                                                    TextInputType.name,
                                                controller:
                                                    controller.branchController,
                                                label: "Branch Name"),
                                          ],
                                        ),
                                      ),
                                      itemAddButton: () async {
                                        var value = BranchDTOList(
                                          id: null,
                                          branchAdminId: int.parse(controller
                                              .selectedBranchId.value),
                                          branchAdminName: controller
                                              .branchAdminController.text,
                                          deleted: "N",
                                          name:
                                              controller.branchController.text,
                                        );
                                        Get.back();
                                        controller.partyBranchItems.add(value);
                                      },
                                    ),
                                    DocumentWalletScreen(
                                      documentwallertId: controller
                                          .documentwallertId
                                          .toString(),
                                      controller: controller,
                                      isEdit: false,
                                      itemAddButton: () async {
                                        if (controller
                                                .documentWalletList.length >=
                                            5) {
                                          customSnackbar(
                                              "Error",
                                              "You cannot upload more than 5 files",
                                              "error");
                                        } else {
                                          var file =
                                              await controller.pickFile();
                                          print("filepicked =----- $file");

                                          await controller
                                              .uploadDocumentWalletPdf(
                                                  file!,
                                                  controller.documentwallertId
                                                      .toString());
                                        }
                                        // setState(() {
                                        //   getCompanyLogo();
                                        // });

                                        // Get.back();
                                      },
                                    ),
                                  ],
                                  onChange: (index) {
                                    setState(() {
                                      initialIndex = index;
                                      print(index);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            initialIndex == 0 || initialIndex == 4
                ? SizedBox()
                : FadeInUp(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: CustomButton(
                          width: 50.w,
                          title: "Save",
                          color: const Color.fromARGB(255, 58, 192, 255),
                          textcolor: kColorwhite,
                          ontap: () {
                            controller.saveCompanyDetails(
                                controller.deletedbranchIds);
                          },
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
