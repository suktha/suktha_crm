// ignore_for_file: must_be_immutable, avoid_print

import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Model/area_model.dart';
import 'package:work_Force/Model/city_model.dart';
import 'package:work_Force/Model/company_profile_model.dart';
import 'package:work_Force/Model/customer_model.dart';
import 'package:work_Force/Model/get_party_master_model.dart';
import 'package:work_Force/Model/material_price_model.dart';
import 'package:work_Force/Model/party_contact_model.dart';
import 'package:work_Force/Model/party_master_list_model.dart';
import 'package:work_Force/Model/state_model.dart';
import 'package:work_Force/Model/type_model.dart';
import 'package:work_Force/controllers/party_master_controller.dart';
import 'package:work_Force/utils/validations/validations.dart';
import 'package:work_Force/view/screens/My_account/more_module/Masters/Masters%20Items/Party%20Master/Add%20Party%20Master/party_master_save.dart';
import 'package:work_Force/view/screens/My_account/more_module/Masters/Masters%20Items/Party%20Master/View%20Party%20Master/list_party_master.dart';
import 'package:work_Force/view/widget/LoadingScreenwithText.dart';
import 'package:work_Force/view/widget/custom_button.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';
import 'package:work_Force/view/widget/snackbar.dart';

class AddPartyMasterScreen extends StatefulWidget {
  final bool isEdit;

  List<PartyMasterListModel>? getList;
  List<PartyContactDetails>? contactList;
  List<MaterialPriceListDTOList>? priceList;
  List<PartyBankMapDTOList>? bankList;
  List<TermsAndConditions>? termsAndConditionValue;

  PartyDTO? partyMasterSaved;

  AddPartyMasterScreen({
    super.key,
    required this.isEdit,
    this.priceList,
    this.bankList,
    this.contactList,
    this.partyMasterSaved,
    this.termsAndConditionValue,
  });

  @override
  State<AddPartyMasterScreen> createState() => _AddPartyMasterScreenState();
}

class _AddPartyMasterScreenState extends State<AddPartyMasterScreen> {
  @override
  void initState() {
    super.initState();
    controller.getMaterialTypeList("");

    // controller.getFinancialYearList();

    widget.isEdit ? isEdited() : null;
  }

  final controller = Get.put(PartyMasterController());
  final formkey = GlobalKey<FormState>();

  List<String> gstRegTypeList = [
    'Normal',
    'Composition',
    'Unregistered / URP',
  ];

  AreaModel? areavalue;
  StateModel? stateValue;
  CityModel? cityvalue;
  StateModel? countryvalue;
  TypeModel? partyTypevalue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: true, // set it to false
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
                  fontSize: 19.sp),
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
                  Get.offAll(PartyMasterScreen());
                }),
              )),
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.all(2.w),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formkey,
              child: Column(
                children: [
                  Text(
                    "Enter The Basic Informations",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(children: [
                        FadeIn(
                          delay: const Duration(milliseconds: 300),
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            margin: EdgeInsets.all(2.w),
                            height: 6.h,
                            child: TypeAheadField<TypeModel>(
                              debounceDuration:
                                  const Duration(milliseconds: 500),

                              controller: controller.partyTypeController,
                              builder: (context, partyTypecontroller,
                                  partyTypefocusNode) {
                                return TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Select the Party Type";
                                      }
                                      return null;
                                    },
                                    focusNode: partyTypefocusNode,
                                    controller: partyTypecontroller,
                                    readOnly: true,
                                    enabled: widget.isEdit ? false : true,
                                    decoration: InputDecoration(
                                      labelText: "Party Type*",
                                      suffixIcon: Icon(
                                        Icons.arrow_drop_down,
                                        color: kColorblack,
                                      ),
                                      contentPadding:
                                          EdgeInsets.only(left: 2.w),
                                      labelStyle: TextStyle(
                                          overflow: TextOverflow.fade,
                                          fontSize: 15.5.sp,
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
                              suggestionsCallback: controller.getPartyTypeLists,

                              itemBuilder: (context, TypeModel suggestion) {
                                final quotNumber = suggestion;
                                return ListTile(
                                  title: Text(quotNumber.name!),
                                );
                              },
                              loadingBuilder: (context) {
                                return SizedBox(
                                    height: 10.h,
                                    child: const Center(
                                        child: CircularProgressIndicator()));
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

                              onSelected: (TypeModel suggestion) {
                                partyTypevalue = suggestion;

                                controller.partyTypeController.text =
                                    partyTypevalue!.name.toString();

                                controller
                                    .transactionNumber(partyTypevalue!.id!);
                                // setState(() {

                                // });
                              },
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                  multilines: 1,
                                  height: 7.h,
                                  validator: (value) {
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  obscure: false,
                                  enabled: false,
                                  controller: controller.partyCodeController,
                                  label: "Party Code*"),
                            ),
                            Expanded(
                              child: CustomTextField(
                                  multilines: 1,
                                  height: 7.h,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Enter The Name";
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  obscure: false,
                                  enabled: widget.isEdit ? false : true,
                                  controller: controller.partyNameController,
                                  label: "Party Name*"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                  multilines: 1,
                                  height: 6.h,
                                  validator: (value) {
                                    return null;
                                  },
                                  textInputType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  obscure: false,
                                  controller: controller.vendercodeController,
                                  label: "Vendor Code"),
                            ),
                            Expanded(
                              child: CustomTextField(
                                  multilines: 1,
                                  height: 6.h,
                                  validator: (value) {
                                    // Regular expression to match a 10-digit US phone number
                                    final RegExp regex = RegExp(r'^\d{10}$');

                                    if (value.isNotEmpty) {
                                      if (!regex.hasMatch(value)) {
                                        return 'Enter a valid 10-digit number';
                                      }
                                      return null;
                                    }
                                    return null;
                                  },
                                  textInputType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  obscure: false,
                                  controller:
                                      controller.contactNumberController,
                                  label: "Contact Number"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                  multilines: 1,
                                  height: 6.h,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Enter PinCode";
                                    }
                                    return null;
                                  },
                                  textInputType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  obscure: false,
                                  controller: controller.pincodeController,
                                  label: "Pincode*"),
                            ),
                            Expanded(
                              child: FadeIn(
                                delay: const Duration(milliseconds: 300),
                                duration: const Duration(milliseconds: 300),
                                child: Container(
                                  margin: EdgeInsets.all(2.w),
                                  height: 6.h,
                                  child: TypeAheadField<AreaModel>(
                                    debounceDuration:
                                        const Duration(milliseconds: 500),

                                    controller: controller.areaController,
                                    builder: (context, areacontroller,
                                        areafocusNode) {
                                      return TextFormField(
                                          enabled: true,
                                          focusNode: areafocusNode,
                                          controller: areacontroller,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            labelText: "Area",
                                            suffixIcon: Icon(
                                              Icons.arrow_drop_down,
                                              color: kColorblack,
                                            ),
                                            contentPadding:
                                                EdgeInsets.only(left: 2.w),
                                            labelStyle: TextStyle(
                                                overflow: TextOverflow.fade,
                                                fontSize: 15.5.sp,
                                                color: const Color.fromARGB(
                                                    255, 78, 78, 78),
                                                fontWeight: FontWeight.w700),
                                            errorBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: kColorRed),
                                            ),
                                            disabledBorder:
                                                UnderlineInputBorder(
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
                                    suggestionsCallback: controller.getAreaList,

                                    itemBuilder:
                                        (context, AreaModel suggestion) {
                                      final areaValue = suggestion;
                                      return ListTile(
                                        title: Text(areaValue.name!),
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

                                    onSelected: (AreaModel suggestion) async {
                                      areavalue = suggestion;

                                      controller.areaController.text =
                                          areavalue!.name.toString();

                                      controller.ifAreaSelected.value = true;

                                      //selecting city-----------------------

                                      final cityId = areavalue!.cityId;

                                      final citylist =
                                          await controller.getCityList("");

                                      final selectedCity = citylist.firstWhere(
                                        (city) => city.id == cityId,
                                      );

                                      cityvalue = selectedCity;

                                      controller.ifCitySelected.value = true;

                                      controller.cityController.text =
                                          selectedCity.name ?? "";

                                      //selecting state-----------------------

                                      final stateId = selectedCity.stateId;

                                      final statelist =
                                          await controller.getStateList("");

                                      final selectedState =
                                          statelist.firstWhere(
                                        (state) => state.id == stateId,
                                      );

                                      stateValue = selectedState;

                                      controller.stateController.text =
                                          selectedState.name ?? "";

                                      //selecting country-----------------------

                                      final countryId = selectedState.countryId;

                                      final countryList =
                                          await controller.getCountryList("");

                                      final selectedCountry =
                                          countryList.firstWhere(
                                        (country) => country.id == countryId,
                                      );

                                      countryvalue = selectedCountry;

                                      controller.countryController.text =
                                          selectedCountry.name ?? "";
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: FadeIn(
                                delay: const Duration(milliseconds: 300),
                                duration: const Duration(milliseconds: 300),
                                child: Container(
                                  margin: EdgeInsets.all(2.w),
                                  height: 6.h,
                                  child: TypeAheadField<CityModel>(
                                    debounceDuration:
                                        const Duration(milliseconds: 500),

                                    controller: controller.cityController,
                                    builder: (context, citycontroller,
                                        cityfocusNode) {
                                      return TextFormField(
                                          focusNode: cityfocusNode,
                                          controller: citycontroller,
                                          readOnly: true,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Select City";
                                            }
                                            return null;
                                          },
                                          enabled: true,
                                          decoration: InputDecoration(
                                            labelText: "City*",
                                            suffixIcon: Icon(
                                              Icons.arrow_drop_down,
                                              color: kColorblack,
                                            ),
                                            contentPadding:
                                                EdgeInsets.only(left: 2.w),
                                            labelStyle: TextStyle(
                                                overflow: TextOverflow.fade,
                                                fontSize: 15.5.sp,
                                                color: const Color.fromARGB(
                                                    255, 78, 78, 78),
                                                fontWeight: FontWeight.w700),
                                            errorBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: kColorRed),
                                            ),
                                            disabledBorder:
                                                UnderlineInputBorder(
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
                                    suggestionsCallback: controller.getCityList,

                                    itemBuilder:
                                        (context, CityModel suggestion) {
                                      final quotNumber = suggestion;
                                      return ListTile(
                                        title: Text(quotNumber.name!),
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

                                    onSelected: (CityModel suggestion) async {
                                      cityvalue = suggestion;
                                      controller.cityController.text =
                                          cityvalue!.name.toString();
                                      controller.ifCitySelected.value = true;
                                      //selecting state-----------------------

                                      final stateId = cityvalue!.stateId;

                                      final statelist =
                                          await controller.getStateList("");
                                      final selectedState =
                                          statelist.firstWhere(
                                        (state) => state.id == stateId,
                                      );

                                      stateValue = selectedState;
                                      controller.stateController.text =
                                          selectedState.name ?? "";

                                      //selecting country-----------------------

                                      final countryId = selectedState.countryId;
                                      final countryList =
                                          await controller.getCountryList("");
                                      final selectedCountry =
                                          countryList.firstWhere(
                                        (country) => country.id == countryId,
                                      );

                                      countryvalue = selectedCountry;

                                      controller.countryController.text =
                                          selectedCountry.name ?? "";
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: FadeIn(
                                delay: const Duration(milliseconds: 300),
                                duration: const Duration(milliseconds: 300),
                                child: Container(
                                  margin: EdgeInsets.all(2.w),
                                  height: 6.h,
                                  child: TypeAheadField<StateModel>(
                                    debounceDuration:
                                        const Duration(milliseconds: 500),

                                    controller: controller.stateController,
                                    builder: (context, statecontroller,
                                        statefocusNode) {
                                      return TextFormField(
                                          enabled: true,
                                          focusNode: statefocusNode,
                                          controller: statecontroller,
                                          readOnly: true,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Select State";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            labelText: "State*",
                                            suffixIcon: Icon(
                                              Icons.arrow_drop_down,
                                              color: kColorblack,
                                            ),
                                            contentPadding:
                                                EdgeInsets.only(left: 2.w),
                                            labelStyle: TextStyle(
                                                overflow: TextOverflow.fade,
                                                fontSize: 15.5.sp,
                                                color: const Color.fromARGB(
                                                    255, 78, 78, 78),
                                                fontWeight: FontWeight.w700),
                                            errorBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: kColorRed),
                                            ),
                                            disabledBorder:
                                                UnderlineInputBorder(
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
                                        controller.getStateList,

                                    itemBuilder:
                                        (context, StateModel suggestion) {
                                      final quotNumber = suggestion;
                                      return ListTile(
                                        title: Text(quotNumber.name!),
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

                                    onSelected: (StateModel suggestion) async {
                                      stateValue = suggestion;

                                      controller.stateController.text =
                                          stateValue!.name.toString();

                                      //selecting country-----------------------

                                      final countryId = stateValue!.countryId;

                                      final countryList =
                                          await controller.getCountryList("");

                                      final selectedCountry =
                                          countryList.firstWhere(
                                        (country) => country.id == countryId,
                                      );
                                      countryvalue = selectedCountry;

                                      controller.countryController.text =
                                          selectedCountry.name ?? "";
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: FadeIn(
                                delay: const Duration(milliseconds: 300),
                                duration: const Duration(milliseconds: 300),
                                child: Container(
                                  margin: EdgeInsets.all(2.w),
                                  height: 6.h,
                                  child: TypeAheadField<StateModel>(
                                    debounceDuration:
                                        const Duration(milliseconds: 500),

                                    controller: controller.countryController,
                                    builder: (context, countryController,
                                        countryFocusNode) {
                                      return TextFormField(
                                          enabled: true,
                                          focusNode: countryFocusNode,
                                          controller: countryController,
                                          readOnly: true,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Select Country";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            labelText: "Country*",
                                            suffixIcon: Icon(
                                              Icons.arrow_drop_down,
                                              color: kColorblack,
                                            ),
                                            contentPadding:
                                                EdgeInsets.only(left: 2.w),
                                            labelStyle: TextStyle(
                                                overflow: TextOverflow.fade,
                                                fontSize: 15.5.sp,
                                                color: const Color.fromARGB(
                                                    255, 78, 78, 78),
                                                fontWeight: FontWeight.w700),
                                            errorBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: kColorRed),
                                            ),
                                            disabledBorder:
                                                UnderlineInputBorder(
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
                                        controller.getCountryList,
                                    // hideKeyboardOnDrag: true,

                                    itemBuilder:
                                        (context, StateModel suggestion) {
                                      final quotNumber = suggestion;
                                      return ListTile(
                                        title: Text(quotNumber.name!),
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

                                    onSelected: (StateModel suggestion) {
                                      countryvalue = suggestion;

                                      controller.countryController.text =
                                          countryvalue!.name.toString();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                  multilines: 1,
                                  height: 6.h,
                                  validator: (value) {
                                    return null;
                                  },
                                  textInputType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  obscure: false,
                                  controller:
                                      controller.primaryTelephoneController,
                                  label: "Primary Telephone"),
                            ),
                            Expanded(
                              child: CustomTextField(
                                  multilines: 1,
                                  height: 6.h,
                                  validator: (value) {
                                    return null;
                                  },
                                  textInputType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  obscure: false,
                                  controller:
                                      controller.secondaryTelephoneController,
                                  label: "Secondary Telephone"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                  multilines: 1,
                                  height: 6.h,
                                  validator: (value) {
                                    return null;
                                  },
                                  textInputType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  obscure: false,
                                  controller:
                                      controller.primaryMobileController,
                                  label: "Primary Mobile"),
                            ),
                            Expanded(
                              child: CustomTextField(
                                  multilines: 1,
                                  height: 6.h,
                                  validator: (value) {
                                    return null;
                                  },
                                  textInputType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  obscure: false,
                                  controller:
                                      controller.secondaryMobileController,
                                  label: "Secondary Mobile"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                  multilines: 1,
                                  height: 6.h,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return null;
                                    } else if (!Validate()
                                        .validateEmail(value)) {
                                      return 'Enter a valid email address';
                                    }
                                    return null;
                                  },
                                  textInputType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  obscure: false,
                                  controller: controller.emailController,
                                  label: "E-Mail"),
                            ),
                            Expanded(
                              child: CustomTextField(
                                  multilines: 1,
                                  height: 6.h,
                                  validator: (value) {
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  obscure: false,
                                  controller: controller.websiteController,
                                  label: "Website"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                  multilines: 1,
                                  height: 6.h,
                                  validator: (value) {
                                    return null;
                                  },
                                  textInputType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  obscure: false,
                                  controller:
                                      controller.contactPersonController,
                                  label: "Contact Person Name"),
                            ),
                            Expanded(
                              child: CustomTextField(
                                  multilines: null,
                                  height: 6.h,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Enter The Address";
                                    }
                                    return null;
                                  },
                                  textInputType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.next,
                                  obscure: false,
                                  controller:
                                      controller.billToAddressController,
                                  label: "Bill to Address*"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                  multilines: null,
                                  height: 6.h,
                                  validator: (value) {
                                    return null;
                                  },
                                  textInputType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.next,
                                  obscure: false,
                                  controller:
                                      controller.shipToAddressLine1Controller,
                                  label: "Ship To Address 1"),
                            ),
                            Expanded(
                              child: CustomTextField(
                                  multilines: null,
                                  height: 6.h,
                                  validator: (value) {
                                    return null;
                                  },
                                  textInputType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.done,
                                  obscure: false,
                                  controller:
                                      controller.shipToAddressLine2Controller,
                                  label: "Ship To Address 2"),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: Padding(
                                    padding: EdgeInsets.all(2.w),
                                    child: TypeAheadField<String>(
                                      debounceDuration:
                                          const Duration(milliseconds: 500),
                                      controller: controller
                                          .gstRegistrationTypeController,
                                      builder: (context, gstcontroller,
                                          gstfocusNode) {
                                        return TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Select the GST Type";
                                              }
                                              return null;
                                            },
                                            focusNode: gstfocusNode,
                                            controller: gstcontroller,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              labelText: "GST-Reg-type*",
                                              suffixIcon: Icon(
                                                Icons.arrow_drop_down,
                                                color: kColorblack,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.only(left: 2.w),
                                              labelStyle: TextStyle(
                                                  overflow: TextOverflow.fade,
                                                  fontSize: 15.5.sp,
                                                  color: const Color.fromARGB(
                                                      255, 78, 78, 78),
                                                  fontWeight: FontWeight.w700),
                                              errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: kColorRed),
                                              ),
                                              disabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: kColorgrey),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: kColorgrey),
                                              ),
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: kColorgrey),
                                              ),
                                            ));
                                      },
                                      autoFlipDirection: true,
                                      suggestionsCallback: (pattern) {
                                        return gstRegTypeList;
                                      },
                                      itemBuilder:
                                          (context, String suggestion) {
                                        return ListTile(
                                          title: Text(suggestion),
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
                                      onSelected: (String suggestion) {
                                        setState(() {
                                          controller
                                              .gstRegistrationTypeController
                                              .text = suggestion;

                                          int selectedIndex = gstRegTypeList
                                              .indexOf(suggestion);

                                          controller.gstRegistrationTypeId =
                                              selectedIndex + 1;

                                          print(
                                              controller.gstRegistrationTypeId);

                                          // controller.transactionNumber(gstRegTypeList.indexOf(suggestion) + 1);

                                          if (suggestion ==
                                              "Unregistered / URP") {
                                            controller.gstNumberVisible.value =
                                                false;
                                          } else {
                                            controller.gstNumberVisible.value =
                                                true;
                                          }
                                        });
                                      },
                                    )),
                              ),
                            ),
                            controller.gstNumberVisible.value
                                ? Expanded(
                                    child: CustomTextField(
                                        multilines: 1,
                                        height: 6.h,
                                        validator: (value) {
                                          if (controller
                                                  .gstNumberVisible.value ==
                                              true) {
                                            if (value.isEmpty) {
                                              return "Enter The GST";
                                            }
                                            return null;
                                          }
                                          return null;
                                        },
                                        textInputType:
                                            TextInputType.streetAddress,
                                        textInputAction: TextInputAction.done,
                                        obscure: false,
                                        controller:
                                            controller.gstNumberController,
                                        label: "GST Number*"),
                                  )
                                : Expanded(
                                    child: CustomTextField(
                                        multilines: 1,
                                        height: 6.h,
                                        validator: (value) {
                                          return null;
                                        },
                                        textInputType:
                                            TextInputType.streetAddress,
                                        textInputAction: TextInputAction.done,
                                        obscure: false,
                                        controller:
                                            controller.panNumberController,
                                        label: "PAN Number"),
                                  )
                          ],
                        ),

                        controller.gstNumberVisible.value
                            ? CustomTextField(
                                multilines: 1,
                                height: 6.h,
                                validator: (value) {
                                  return null;
                                },
                                textInputType: TextInputType.streetAddress,
                                textInputAction: TextInputAction.done,
                                obscure: false,
                                controller: controller.panNumberController,
                                label: "PAN Number")
                            : Container(),
                        // Spacer(),
                      ]),
                    ),
                  ),
                  Center(
                    child: CustomButton(
                      width: 50.w,
                      title: "Next",
                      color: const Color.fromARGB(255, 58, 192, 255),
                      textcolor: kColorwhite,
                      ontap: () async {
                        bool? emailCheck;
                        bool? numberCheck;
                        bool? gstCheck;

                        // print("EMAIL- " + controller.emailController.text);
                        // print("number- " + controller.contactNumberController.text);
                        // print("EgstMAIL- " + controller.gstNumberController.text);

                        if (widget.isEdit == false) {
                          if (controller.emailController.text.isNotEmpty) {
                            emailCheck = await controller
                                .checkEmail(controller.emailController.text);
                          }
                          if (controller
                              .contactNumberController.text.isNotEmpty) {
                            numberCheck = await controller.checkNumber(
                                int.parse(
                                    controller.contactNumberController.text));
                          }
                          if (controller.gstNumberController.text.isNotEmpty) {
                            gstCheck = await controller
                                .checkgst(controller.gstNumberController.text);
                          }
                        }
                        PartyDTO? item;

                        widget.isEdit == true
                            ? item = widget.partyMasterSaved
                            : null;

                        // final item = widget.isSavedPage
                        //     ? widget.partyMasterSaved
                        //     : widget.getList![widget.index!];

                        // print(item!.name);
                        // print(widget.partyMasterSaved!.name ?? "");
                        // print(widget.getList![widget.index!].name);

                        if (formkey.currentState!.validate()) {
                          controller.isPageLoading.value = true;

                          controller.partyMasterModelValue = CustomerModel(
                            address: controller.billToAddressController.text,
                            addressesListDTO:
                                widget.isEdit ? item!.addressesListDTO : [],
                            areaId: controller.ifAreaSelected.value
                                ? areavalue!.id
                                : null,
                            areaName: controller.ifAreaSelected.value
                                ? areavalue!.name
                                : null,
                            billAddress:
                                controller.shipToAddressLine1Controller.text,
                            cityId: cityvalue!.id,
                            contactPersonName:
                                controller.contactPersonController.text,
                            contactPersonNumber:
                                controller.contactNumberController.text,
                            countryId: countryvalue!.id,
                            deleted: widget.isEdit ? item!.deleted : "N",
                            dueDaysLimit:
                                widget.isEdit ? item!.dueDaysLimit : null,
                            email: controller.emailController.text == ""
                                ? null
                                : controller.emailController.text,
                            gstNumber: controller.gstNumberController.text,
                            gstRegistrationTypeId: widget.isEdit
                                ? item!.gstRegistrationTypeId
                                : controller.gstRegistrationTypeId,
                            id: widget.isEdit ? item!.id : null,
                            isIgst: widget.isEdit ? item!.isIgst : 0,
                            name: controller.partyNameController.text,
                            panNumber: controller.panNumberController.text,
                            partyCode: controller.partyCodeController.text,
                            partyCurrencyId:
                                widget.isEdit ? item!.partyCurrencyId : null,
                            partyCurrencyName:
                                widget.isEdit ? item!.partyCurrencyName : null,
                            partyId: widget.isEdit ? item!.partyId : null,
                            partyTypeId: widget.isEdit
                                ? item!.partyTypeId
                                : partyTypevalue!.id,
                            partyTypeName: widget.isEdit
                                ? item!.partyTypeName
                                : partyTypevalue!.name,
                            pinCode: controller.pincodeController.text,
                            primaryMobile:
                                controller.primaryMobileController.text,
                            primaryTelephone:
                                controller.primaryTelephoneController.text,
                            secondaryMobile:
                                controller.secondaryMobileController.text,
                            secondaryTelephone:
                                controller.secondaryTelephoneController.text,
                            shipToAddress2:
                                controller.shipToAddressLine2Controller.text,
                            stateCode: widget.isEdit
                                ? item!.stateCode
                                : stateValue!.stateCode,
                            stateId: stateValue!.id,
                            stateName: stateValue!.name,
                            vendorCode: controller.vendercodeController.text,
                            webSite: controller.websiteController.text,
                          );
                          controller.isPageLoading.value = false;

                          if (emailCheck == false) {
                            customSnackbar("Email is Taken",
                                "This Email-id is Already In use", "error");
                          } else if (numberCheck == false) {
                            customSnackbar("Number is Taken",
                                "This Phone Number is Already In use", "error");
                          } else if (gstCheck == false) {
                            customSnackbar("GST is Taken",
                                "This GST-Number is Already In use", "error");
                          } else {
                            Get.to(
                                SavePartyMasterScreen(
                                  contactList: widget.contactList,
                                  priceList: widget.priceList,
                                  bankList: widget.bankList,
                                  partyMasterSaved: widget.partyMasterSaved,
                                  termsAndConditionValue:
                                      widget.termsAndConditionValue,
                                  isEdit: widget.isEdit,
                                ),
                                transition: Transition.fade,
                                duration: const Duration(milliseconds: 600));
                          }
                        } else {
                          controller.isPageLoading.value = false;

                          customSnackbar("Field is Empty",
                              "Please fill all the mandatory fields", "error");
                        }
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

  void isEdited() async {
    final item = widget.partyMasterSaved;
    // print("id financial year-----------${controller.financialYearList[0].id.toString()}");
    // controller.financialYearId.value = controller.financialYearList[0].id.toString();
    controller.materialPriceItem.value = widget.priceList ?? [];
    controller.materialBankItem.value = widget.bankList ?? [];
    controller.contactListItem.value = widget.contactList ?? [];
    controller.termsNdconditionItem.value = widget.termsAndConditionValue ?? [];

    controller.partyTypeController.text = item!.partyTypeName ?? "";
    controller.partyCodeController.text = item.partyCode ?? "";
    controller.partyNameController.text = item.name ?? "";
    controller.vendercodeController.text = item.vendorCode ?? "";
    controller.contactNumberController.text = item.contactPersonNumber ?? "";
    controller.pincodeController.text = item.pinCode ?? "";
    controller.areaController.text = item.areaName ?? "";

//
    if (item.cityId != null) {
      final citylist = await controller.getCityList("");
      final selectedCity = citylist.firstWhere(
        (city) => city.id == item.cityId,
      );
      cityvalue = selectedCity;
      controller.cityController.text = cityvalue!.name ?? "";
    }
    //

    final stateList = await controller.getStateList("");

    final selectedState = stateList.firstWhere(
      (state) => state.id == item.stateId,
    );
    stateValue = selectedState;

    controller.stateController.text = stateValue!.name ?? "";

//
    final countryList = await controller.getCountryList("");

    final selectedCountry = countryList.firstWhere(
      (country) => country.id == item.countryId,
    );
    countryvalue = selectedCountry;

    controller.countryController.text = countryvalue!.name ?? "";
    //

    controller.primaryTelephoneController.text = item.primaryTelephone ?? "";
    controller.secondaryTelephoneController.text =
        item.secondaryTelephone ?? "";
    controller.primaryMobileController.text = item.primaryMobile ?? "";
    controller.secondaryMobileController.text = item.secondaryMobile ?? "";

    controller.emailController.text =
        item.email!.split(".com").first == "notnull@notnull"
            ? ""
            : item.email ?? "";

    controller.websiteController.text = item.webSite ?? "";
    controller.contactPersonController.text = item.contactPersonName ?? "";
    controller.billToAddressController.text = item.address ?? "";
    controller.shipToAddressLine1Controller.text = item.billAddress ?? "";
    controller.shipToAddressLine2Controller.text = item.shipToAddress2 ?? "";

//
    setState(() {
      if (item.gstRegistrationTypeId == 1) {
        controller.gstRegistrationTypeController.text = "Normal";
        // controller.gstType.value = "Normal";
        controller.gstNumberController.text = item.gstNumber ?? "";
        controller.gstNumberVisible.value = true;
        controller.panNumberVisible.value = false;
      } else if (item.gstRegistrationTypeId == 2) {
        controller.gstRegistrationTypeController.text = "Composition";
        // controller.gstType.value = "Composition";
        controller.gstNumberController.text = item.gstNumber ?? "";

        controller.gstNumberVisible.value = true;
        controller.panNumberVisible.value = false;
      } else if (item.gstRegistrationTypeId == 3) {
        controller.gstRegistrationTypeController.text = "Unregistered / URP";
        // controller.gstType.value = "Unregistered / URP";
      }
    });

    controller.panNumberController.text = item.panNumber ?? "";

    controller.materialPriceItem.value = widget.priceList!;
    controller.materialBankItem.value = widget.bankList!;
    controller.termsNdconditionItem.value = widget.termsAndConditionValue ?? [];

    print(widget.priceList);
    print(widget.bankList);
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
  }
}
