// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Model/city_model.dart';
import 'package:work_Force/Model/country_master_model.dart';
import 'package:work_Force/view/settings_module/user_profile/controller/general_master_controller.dart';
import 'package:work_Force/view/settings_module/user_profile/controller/user_profile_controller.dart';
import 'package:work_Force/view/widget/custom_button.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';

import '../../../../Model/area_model.dart';
import '../../../../Model/state_model.dart';
import '../../../../utils/Date.dart';

class CreateUserOrEditCustom extends StatefulWidget {
  final GlobalKey<FormState> createUserFormKey;
  final String title;
  final String buttonText;
  final VoidCallback buttonPress;
  final UserProfileController controller;

  const CreateUserOrEditCustom(
      {super.key,
      required this.createUserFormKey,
      required this.title,
      required this.controller,
      required this.buttonText,
      required this.buttonPress});

  @override
  State<CreateUserOrEditCustom> createState() => _CreateUserOrEditCustomState();
}

class _CreateUserOrEditCustomState extends State<CreateUserOrEditCustom> {
  @override
  void initState() {
    widget.controller.getBranchList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final generalController = Get.find<GeneralMasterController>();
    return FadeInUp(
      duration: Durations.long2,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Form(
          key: widget.createUserFormKey,
          child: Padding(
            padding: EdgeInsets.only(
                top: 1.h,
                left: 3.w,
                right: 3.w,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                SizedBox(
                  height: 1.h,
                ),
                FadeIn(
                  delay: const Duration(milliseconds: 300),
                  duration: const Duration(milliseconds: 300),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.sp),
                      ),
                      Spacer(),
                      CircleAvatar(
                        child: IconButton(
                            onPressed: () {
                              widget.controller.clearFunction();
                              Get.back();
                            },
                            icon: Icon(
                              Icons.close,
                              color: kColorwhite,
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Obx(
                                () => Container(
                                    margin: EdgeInsets.all(2.w),

                                    // width: 30.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Name Prefix*"),
                                        DropdownButtonFormField(
                                          isExpanded: true,
                                          autofocus: true,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please select Prefix";
                                            }
                                            setState(() {

                                            });
                                            return null;
                                          },
                                          value:
                                              widget.controller.prefixId.value,
                                          items: [
                                            DropdownMenuItem<String>(
                                              value: "",
                                              child: Text("Prefix*"),
                                            ),
                                            ...widget.controller.prefixList.map(
                                                (item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item.id.toString(),
                                                      child:
                                                          Text("${item.name}"),
                                                    )),
                                          ],
                                          onChanged: (newValue) {
                                            setState(() {
                                              widget.controller.prefixId.value =
                                                  newValue!;
                                              widget.controller.prefixName
                                                      .value =
                                                  widget.controller.prefixList
                                                      .firstWhere((item) =>
                                                          item.id.toString() ==
                                                          widget.controller
                                                              .prefixId.value)
                                                      .name!;
                                            });

                                            // widget.createUserFormKey.currentState!.validate();
                                          },
                                          hint: Text('Select an item'),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Obx(
                                () => Container(
                                    margin: EdgeInsets.all(2.w),

                                    // width: 30.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Gender*"),
                                        DropdownButtonFormField(
                                          isExpanded: true,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please select Gender";
                                            }
                                            return null;
                                          },
                                          value:
                                              widget.controller.genderId.value,
                                          items: [
                                            DropdownMenuItem<String>(
                                              value: "",
                                              child: Text("Type*"),
                                            ),
                                            ...widget.controller.genderList.map(
                                                (item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item.id.toString(),
                                                      child:
                                                          Text("${item.name}"),
                                                    )),
                                          ],
                                          onChanged: (newValue) {
                                            widget.controller.genderId.value =
                                                newValue!;

                                            print(widget
                                                .controller.genderId.value);

                                            widget.controller.genderName.value =
                                                widget.controller.genderList
                                                    .firstWhere((item) =>
                                                        item.id.toString() ==
                                                        widget.controller
                                                            .genderId.value)
                                                    .name!;

                                            print(widget
                                                .controller.genderName.value);
                                          },
                                          hint: Text('Select an item'),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                        CustomTextField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please Enter name";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            obscure: false,
                            controller: widget.controller.nameController,
                            label: "Name*"),

                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                    multilines: 1,
                                    suffixIcon: IconButton(
                                        splashColor: kColortransparent,
                                        onPressed: () {
                                          DateClass().selectDate(
                                              widget.controller.DOBController,
                                              false,
                                              false);
                                        },
                                        icon: Icon(Icons.date_range)),
                                    height: 7.h,
                                    validator: (value) {
                                      return null;
                                    },
                                    textInputAction: TextInputAction.next,
                                    obscure: false,
                                    ontap: () {
                                      DateClass().selectDate(
                                          widget.controller.DOBController,
                                          false,
                                          false);
                                    },
                                    // enabled: false,
                                    textInputType: TextInputType.datetime,
                                    controller: widget.controller.DOBController,
                                    label: "Date of Birth"),
                              ),
                            ],
                          ),
                        ),
                        CustomTextField(
                            ontap: () {
                              _showUserRoleBottomSheet(context: context);
                            },
                            suffixIcon: IconButton(
                                onPressed: () {
                                  _showUserRoleBottomSheet(context: context);
                                },
                                icon: Icon(Icons.list)),
                            readonly: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please select something";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            obscure: false,
                            controller: widget.controller.userRoleController,
                            label: "Role*"),

                        Obx(
                          () => widget.controller.isStaffSelected.value == true
                              ? Container(
                                  margin: EdgeInsets.all(2.w),

                                  // width: 30.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Report Branch*"),
                                      DropdownButtonFormField(
                                        isExpanded: true,
                                        autofocus: true,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please select Report Branch";
                                          }
                                          return null;
                                        },
                                        value:
                                            widget.controller.getBranchId.value,
                                        items: [
                                          DropdownMenuItem<String>(
                                            value: "",
                                            child: Text("select"),
                                          ),
                                          ...widget.controller.getAllBranchList
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item.branchAdminId
                                                        .toString(),
                                                    child: Text(
                                                        " ${item.name} - ${item.branchAdminName}"),
                                                  )),
                                        ],
                                        onChanged: (newValue) {
                                          setState(() {
                                            widget.controller.getBranchId
                                                .value = newValue!;
                                            widget
                                                .controller
                                                .reportingBranchController
                                                .text = widget
                                                    .controller.getAllBranchList
                                                    .firstWhere((item) =>
                                                        item.branchAdminId
                                                            .toString() ==
                                                        widget.controller
                                                            .getBranchId.value)
                                                    .name ??
                                                "";

                                            // widget.controller.BranchAdminId.value =
                                            //     widget.controller.getAllBranchList.firstWhere((item) => item.id.toString() == widget.controller.getBranchId.value).branchAdminId.toString();
                                          });

                                          print(
                                              "branch admin id --${widget.controller.getBranchId.value}");

                                          widget.createUserFormKey.currentState!
                                              .validate();
                                        },
                                        hint: Text('Select an item'),
                                      ),
                                    ],
                                  ))
                              : SizedBox(),
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: Obx(
                                () => Container(
                                    margin: EdgeInsets.only(
                                        top: 2.h, left: 3.w, right: 3.w),
                                    // width: 30.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DropdownButtonFormField(
                                          isExpanded: true,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please select employee type";
                                            }
                                            return null;
                                          },
                                          value: widget
                                              .controller.employeeTypeId.value,
                                          items: [
                                            DropdownMenuItem<String>(
                                              value: "",
                                              child: Text(
                                                "Select the Employee-Type*",
                                                style: TextStyle(fontSize: 17),
                                              ),
                                            ),
                                            ...widget
                                                .controller.employeeTypeList
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item.id.toString(),
                                                      child:
                                                          Text("${item.name}"),
                                                    )),
                                          ],
                                          onChanged: (newValue) {
                                            // widget.controller.validationMessageemployeeType.value = '';
                                            widget.controller.employeeTypeId
                                                .value = newValue!;

                                            print(widget.controller
                                                .employeeTypeId.value);

                                            widget.controller.employeeTypeName
                                                    .value =
                                                widget
                                                    .controller.employeeTypeList
                                                    .firstWhere((item) =>
                                                        item.id.toString() ==
                                                        widget
                                                            .controller
                                                            .employeeTypeId
                                                            .value)
                                                    .name!;

                                            print(widget.controller
                                                .employeeTypeName.value);
                                          },
                                          hint: Text('Select an item'),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                        CustomTextField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please Enter employee code";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            obscure: false,
                            controller:
                                widget.controller.employeeCodeController,
                            label: "Employee Code*"),
                        CustomTextField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please Enter Permanent Address";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            obscure: false,
                            controller:
                                widget.controller.permaentAddressController,
                            label: "Permanent Address*"),
                        CustomTextField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return null;
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            obscure: false,
                            controller:
                                widget.controller.currentAddressController,
                            label: "Current Address"),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(3.w),
                                height: 6.h,
                                child: TypeAheadField<AreaModel>(
                                  debounceDuration: Duration(milliseconds: 500),
                                  controller: widget.controller.areaController,

                                  builder:
                                      (context, areacontroller, areafocusNode) {
                                    return TextField(
                                      focusNode: areafocusNode,
                                      controller: areacontroller,
                                      decoration: InputDecoration(
                                        labelText: "Area",
                                        suffixIcon: Icon(
                                          Icons.arrow_drop_down,
                                          color: kColorblack,
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            left: 2.w, bottom: 2.w),
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
                                      ),
                                    );
                                  },

                                  // getImmediateSuggestions: true,
                                  suggestionsCallback:
                                      generalController.getAreaMasterDetails,

                                  itemBuilder: (context, AreaModel suggestion) {
                                    final area = suggestion;
                                    return ListTile(
                                      title: Text(area.name!),
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
                                    widget.controller.areaValue = suggestion;

                                    widget.controller.areaController.text =
                                        suggestion.name.toString();

                                    widget.controller.areaId.value =
                                        suggestion.id.toString();

                                    final cityId =
                                        widget.controller.areaValue!.cityId;

                                    final citylist = await generalController
                                        .getCityMasterDetails("");

                                    final selectedCity = citylist.firstWhere(
                                      (city) => city.id == cityId,
                                    );

                                    widget.controller.cityValue = selectedCity;

                                    // controller.ifCitySelected.value = true;

                                    widget.controller.cityController.text =
                                        selectedCity.name ?? "";

                                    //selecting state-----------------------

                                    final stateId = selectedCity.stateId;

                                    final statelist = await generalController
                                        .getStateDetails("");

                                    final selectedState = statelist.firstWhere(
                                      (state) => state.id == stateId,
                                    );

                                    widget.controller.StateValue =
                                        selectedState;

                                    widget.controller.stateController.text =
                                        selectedState.name ?? "";

                                    //selecting country-----------------------

                                    final countryId = selectedState.countryId;

                                    final countryList = await generalController
                                        .getCountryDetails("");

                                    final selectedCountry =
                                        countryList.firstWhere(
                                      (country) => country.id == countryId,
                                    );

                                    widget.controller.countryValue =
                                        selectedCountry;

                                    widget.controller.countryController.text =
                                        selectedCountry.name ?? "";

                                    widget.createUserFormKey.currentState!
                                        .validate();
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(3.w),
                                height: 6.h,
                                child: TypeAheadField<CityModel>(
                                  debounceDuration: Duration(milliseconds: 500),
                                  // animationStart: 0.25,

                                  // validator: (value) {
                                  //   return null;
                                  // },
                                  controller: widget.controller.cityController,
                                  builder:
                                      (context, citycontroller, cityfocusNode) {
                                    return TextField(
                                      focusNode: cityfocusNode,
                                      controller: citycontroller,
                                      decoration: InputDecoration(
                                        labelText: "City",
                                        suffixIcon: Icon(
                                          Icons.arrow_drop_down,
                                          color: kColorblack,
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            left: 2.w, bottom: 2.w),
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
                                      ),
                                    );
                                  },

                                  // getImmediateSuggestions: true,
                                  suggestionsCallback:
                                      generalController.getCityMasterDetails,
                                  // hideKeyboard: true,
                                  // hideKeyboardOnDrag: true,

                                  // hideSuggestionsOnKeyboardHide: true,

                                  itemBuilder: (context, CityModel suggestion) {
                                    final city = suggestion;
                                    return ListTile(
                                      title: Text(city.name!),
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
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.sp),
                                        ),
                                      ),
                                    );
                                  },

                                  onSelected: (CityModel suggestion) async {
                                    widget.controller.cityValue = suggestion;

                                    widget.controller.cityController.text =
                                        widget.controller.cityValue!.name
                                            .toString();

                                    widget.controller.cityId.value =
                                        suggestion.id.toString();

                                    //selecting state-----------------------

                                    final stateId = suggestion.stateId;

                                    final statelist = await generalController
                                        .getStateDetails("");

                                    final selectedState = statelist.firstWhere(
                                      (state) => state.id == stateId,
                                    );

                                    widget.controller.StateValue =
                                        selectedState;

                                    widget.controller.stateController.text =
                                        selectedState.name ?? "";

                                    //selecting country-----------------------

                                    final countryId = selectedState.countryId;

                                    final countryList = await generalController
                                        .getCountryDetails("");

                                    final selectedCountry =
                                        countryList.firstWhere(
                                      (country) => country.id == countryId,
                                    );

                                    widget.controller.countryValue =
                                        selectedCountry;

                                    widget.controller.countryController.text =
                                        selectedCountry.name ?? "";

                                    widget.createUserFormKey.currentState!
                                        .validate();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(3.w),
                                height: 6.h,
                                child: TypeAheadField<StateModel>(
                                  debounceDuration: Duration(milliseconds: 500),
                                  controller: widget.controller.stateController,
                                  builder: (context, statecontroller,
                                      statefocusNode) {
                                    return TextField(
                                      focusNode: statefocusNode,
                                      controller: statecontroller,
                                      decoration: InputDecoration(
                                        labelText: "State",
                                        suffixIcon: Icon(
                                          Icons.arrow_drop_down,
                                          color: kColorblack,
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            left: 2.w, bottom: 2.w),
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
                                      ),
                                    );
                                  },

                                  // getImmediateSuggestions: true,
                                  // hideKeyboardOnDrag: true,

                                  // hideSuggestionsOnKeyboardHide: true,

                                  itemBuilder:
                                      (context, StateModel suggestion) {
                                    final state = suggestion;
                                    return ListTile(
                                      title: Text(state.name!),
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
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.sp),
                                        ),
                                      ),
                                    );
                                  },

                                  // getImmediateSuggestions: true,
                                  suggestionsCallback:
                                      generalController.getStateDetails,

                                  onSelected: (StateModel suggestion) async {
                                    widget.controller.StateValue = suggestion;

                                    widget.controller.stateController.text =
                                        widget.controller.StateValue!.name
                                            .toString();

                                    widget.controller.stateId.value =
                                        suggestion.id.toString();

                                    //selecting country-----------------------

                                    final countryId = suggestion.countryId;
                                    final countryList = await generalController
                                        .getCountryDetails("");
                                    final selectedCountry =
                                        countryList.firstWhere((country) =>
                                            country.id == countryId);
                                    widget.controller.countryValue =
                                        selectedCountry;
                                    widget.controller.countryController.text =
                                        selectedCountry.name ?? "";
                                    widget.createUserFormKey.currentState!
                                        .validate();
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(3.w),
                                height: 6.h,
                                child: TypeAheadField<CountryMasterModel>(
                                  debounceDuration: Duration(milliseconds: 500),

                                  controller:
                                      widget.controller.countryController,
                                  builder: (context, countryController,
                                      countryfocusNode) {
                                    return TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please select country";
                                        }
                                        return null;
                                      },
                                      focusNode: countryfocusNode,
                                      controller: countryController,
                                      decoration: InputDecoration(
                                        labelText: "Country*",
                                        suffixIcon: Icon(
                                          Icons.arrow_drop_down,
                                          color: kColorblack,
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            left: 2.w, bottom: 2.w),
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
                                      ),
                                    );
                                  },
                                  suggestionsCallback:
                                      generalController.getCountryDetails,
                                  // hideKeyboard: true,
                                  // hideKeyboardOnDrag: true,

                                  // hideSuggestionsOnKeyboardHide: true,

                                  itemBuilder:
                                      (context, CountryMasterModel suggestion) {
                                    final country = suggestion;
                                    return ListTile(
                                      title: Text(country.name!),
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
                                      (CountryMasterModel suggestion) async {
                                    widget.controller.countryValue = suggestion;

                                    widget.controller.countryController.text =
                                        widget.controller.countryValue!.name
                                            .toString();

                                    widget.controller.countryId.value =
                                        suggestion.id.toString();

                                    widget.createUserFormKey.currentState!
                                        .validate();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                        CustomTextField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return null;
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            obscure: false,
                            textInputType: TextInputType.number,
                            controller: widget.controller.pincodeController,
                            label: "Pincode"),

                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                    multilines: 1,
                                    suffixIcon: IconButton(
                                      splashColor: kColortransparent,
                                      onPressed: () {
                                        DateClass().selectDate(
                                            widget.controller
                                                .dateOfJoiningController,
                                            false,
                                            false);
                                      },
                                      icon: Icon(Icons.date_range),
                                    ),
                                    ontap: () {
                                      DateClass().selectDate(
                                          widget.controller
                                              .dateOfJoiningController,
                                          false,
                                          false);
                                    },
                                    height: 7.h,
                                    validator: (value) {
                                      return null;
                                    },
                                    textInputAction: TextInputAction.next,
                                    obscure: false,
                                    textInputType: TextInputType.datetime,
                                    controller: widget
                                        .controller.dateOfJoiningController,
                                    label: "Date of joining"),
                              ),
                              Expanded(
                                child: CustomTextField(
                                    multilines: 1,
                                    suffixIcon: IconButton(
                                      splashColor: kColortransparent,
                                      onPressed: () {
                                        DateClass().selectDate(
                                            widget.controller
                                                .dateOfLeavingController,
                                            false,
                                            false);
                                      },
                                      icon: Icon(Icons.date_range),
                                    ),
                                    ontap: () {
                                      DateClass().selectDate(
                                          widget.controller
                                              .dateOfLeavingController,
                                          false,
                                          false);
                                    },
                                    height: 7.h,
                                    validator: (value) {
                                      return null;
                                    },
                                    textInputAction: TextInputAction.next,
                                    obscure: false,
                                    textInputType: TextInputType.datetime,
                                    controller: widget
                                        .controller.dateOfLeavingController,
                                    label: "Date of Leaving"),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Column(
                            children: [
                              CustomTextField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return null;
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  obscure: false,
                                  textInputType: TextInputType.number,
                                  controller:
                                      widget.controller.mobileNumController,
                                  label: "Mobile Number"),
                              CustomTextField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return null;
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  obscure: false,
                                  controller:
                                      widget.controller.telePhoneNumController,
                                  textInputType: TextInputType.number,
                                  label: "Telephone Number"),
                              CustomTextField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return null;
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  obscure: false,
                                  controller:
                                      widget.controller.commentsController,
                                  label: "Comment"),
                            ],
                          ),
                        ),

                        //  CustomTextField(
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return null;
                        //   }
                        //   return null;
                        // },
                        // textInputAction: TextInputAction.next,
                        // obscure: false,
                        // controller: controller.mobileNumController,
                        // label: "Mobile Number")
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            widget.controller.clearFunction();
                            Get.back();
                          },
                          child: Container(
                            height: 6.h,
                            width: 45.w,
                            decoration: BoxDecoration(
                                boxShadow: kElevationToShadow[2],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: Text(
                              "Back",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: kColorblack),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: widget.buttonPress,
                          child: Container(
                            height: 6.h,
                            width: 45.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.indigo,
                            ),
                            child: Center(
                                child: Text(
                              widget.buttonText,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: kColorwhite),
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showUserRoleBottomSheet({required BuildContext context}) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.w), topRight: Radius.circular(5.w))),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return UserRoleBottomSheet();
      },
    );
  }
}

class UserRoleBottomSheet extends StatefulWidget {
  const UserRoleBottomSheet({super.key});

  @override
  State<UserRoleBottomSheet> createState() => _PriorityBottomSheetState();
}

class _PriorityBottomSheetState extends State<UserRoleBottomSheet> {
  UserProfileController controller = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: 90.h,
          child: Padding(
            padding:
                EdgeInsets.only(top: 2.h, bottom: 2.h, left: 2.h, right: 2.h),
            child: Column(
              children: [
                Text("Select Role",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.sp)),
                SizedBox(height: 2.h),
                SizedBox(height: 2.h),
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.userRoleList.length,
                    itemBuilder: (context, index) {
                      final item = controller.userRoleList[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (controller.selectedUserRoleList
                                .contains(item)) {
                              controller.selectedUserRoleList.remove(item);
                            } else {
                              controller.selectedUserRoleList.add(item);
                            }
                            controller.isStaffSelected.value = controller
                                .selectedUserRoleList
                                .any((element) => element.role == "Staff");
                            controller.userRoleController.text = controller
                                .selectedUserRoleList
                                .map((item) => item.role)
                                .join(', ');
                            print(
                                "role -- name ${controller.userRoleController.text}");
                            controller.userRoleId.value = controller
                                .selectedUserRoleList
                                .map((element) => element.id)
                                .join(",");

                            print(
                                "isselected staff --${controller.isStaffSelected.value}");
                            print(controller.userRoleId.value);
                          });
                        },
                        child: ListTile(
                          title: Text(item.role!),
                          trailing: Checkbox(
                            value:
                                controller.selectedUserRoleList.contains(item),
                            onChanged: (bool? value) {
                              setState(() {
                                if (controller.selectedUserRoleList
                                    .contains(item)) {
                                  controller.selectedUserRoleList.remove(item);
                                } else {
                                  controller.selectedUserRoleList.add(item);
                                }
                                controller.isStaffSelected.value = controller
                                    .selectedUserRoleList
                                    .any((element) => element.role == "Staff");

                                controller.userRoleController.text = controller
                                    .selectedUserRoleList
                                    .map((item) => item.role)
                                    .join(', ');
                                print(controller.userRoleController.text);
                                controller.userRoleId.value = controller
                                    .selectedUserRoleList
                                    .map((element) => element.id)
                                    .join(",");
                                print(
                                    "isselected staff --${controller.isStaffSelected.value}");
                                print(controller.userRoleId.value);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                CustomButton(
                  width: 50.w,
                  title: "Close",
                  textcolor: kColorwhite,
                  ontap: () {
                    Get.back();
                  },
                  color: kColorlightBlue300,
                )
              ],
            ),
          ),
        ));
  }
}
