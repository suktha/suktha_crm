// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Constants/shared_pref_keys.dart';
import 'package:work_Force/Model/Material_category_model.dart';
import 'package:work_Force/Model/get_party_master_model.dart';
import 'package:work_Force/Model/global_settings_model.dart';
import 'package:work_Force/Model/login_model.dart' as loginModel;
import 'package:work_Force/Model/material_list_model.dart';
import 'package:work_Force/Model/taxes_model.dart';
import 'package:work_Force/Model/unit_model.dart';
import 'package:work_Force/controllers/material_master_controller.dart';
import 'package:work_Force/view/screens/settings_module/Masters/Masters%20Items/Material%20Master/View%20Material%20Master/list_material_master.dart';
import 'package:work_Force/view/widget/LoadingScreenwithText.dart';
import 'package:work_Force/view/widget/custom_button.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';
import '../../../../../../../Model/type_model.dart';

// ignore: must_be_immutable
class AddMaterialMasterScreen extends StatefulWidget {
  final bool isEdit;

  List<MaterialListModel>? getList;

  MaterialListModel? materialMasterSaved;

  AddMaterialMasterScreen({
    super.key,
    required this.isEdit,
    this.materialMasterSaved,
  });

  @override
  State<AddMaterialMasterScreen> createState() =>
      _AddMaterialMasterScreenState();
}

class _AddMaterialMasterScreenState extends State<AddMaterialMasterScreen> {
  TypeModel? materialTypeValue;
  TaxesModel? taxValue;
  UnitsModel? unitValue;

  @override
  void initState() {
    super.initState();
    checkAliasName();

    widget.isEdit ? isEdited() : null;
  }

  GlobalSetting? globalSettings;

  checkAliasName() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final globalSettingsDecoded = json.decode(
        sharedPreferences.getString(SharedPrefKeys().GlobalSettingsKey)!);
    setState(() {
      globalSettings = GlobalSetting.fromJson(globalSettingsDecoded);
    });

    print("--alias Name -- ${globalSettings!.aliasNameEnable}");
  }

  final controller = Get.put(MaterialMasterController());

  final formkey = GlobalKey<FormState>();

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
                    Get.offAll(MaterialMasterScreen());
                  },
                  icon: Icon(
                    Icons.close,
                    color: kColorblack,
                  ),
                ),
              )
            ],
            title: const Text("Material Master"),
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
                Get.back();
              }),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formkey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(children: [
                  Text(
                    "Enter The Basic Informations",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                  ),
                  SizedBox(height: 2.h),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(children: [
                        CustomTextField(
                            multilines: 1,
                            maxLength: 50,
                            height: 5.h,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enter The Name*";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            obscure: false,
                            enabled: true,
                            controller: controller.nameController,
                            label: "Name*"),
                        Container(
                          margin: EdgeInsets.all(2.w),
                          height: 6.h,
                          child: TypeAheadField<TypeModel>(
                            debounceDuration: const Duration(milliseconds: 500),
                            controller: controller.materialTypeController,

                            builder: (context, materialTypecontroller,
                                materialTypefocusNode) {
                              return TextFormField(
                                  enabled: true,
                                  readOnly: true,
                                  controller: materialTypecontroller,
                                  focusNode: materialTypefocusNode,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Select Material Type*";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Material Type*",
                                    suffixIcon: Icon(
                                      Icons.arrow_drop_down,
                                      color: kColorblack,
                                    ),
                                    contentPadding: EdgeInsets.only(left: 2.w),
                                    labelStyle: TextStyle(
                                        overflow: TextOverflow.fade,
                                        fontSize: 16.sp,
                                        color: const Color.fromARGB(
                                            255, 78, 78, 78),
                                        fontWeight: FontWeight.w700),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: kColorRed),
                                    ),
                                    disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: kColorgrey),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: kColorgrey),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: kColorgrey),
                                    ),
                                  ));
                            },

                            // getImmediateSuggestions: true,
                            suggestionsCallback: controller.getMaterialTypeList,
                            // hideKeyboard: true,
                            // hideKeyboardOnDrag: true,

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
                              materialTypeValue = suggestion;

                              controller.materialTypeController.text =
                                  materialTypeValue!.name.toString();
                            },
                          ),
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
                                  controller: controller.hsnController,
                                  label: "HSN"),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(2.w),
                                height: 6.h,
                                child: TypeAheadField<UnitsModel>(
                                  debounceDuration:
                                      const Duration(milliseconds: 500),
                                  controller: controller.unitController,

                                  builder:
                                      (context, unitcontroller, unitfocusNode) {
                                    return TextFormField(
                                        readOnly: true,
                                        enabled: true,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Select Unit*";
                                          }
                                          return null;
                                        },
                                        controller: unitcontroller,
                                        focusNode: unitfocusNode,
                                        decoration: InputDecoration(
                                          labelText: "Unit*",
                                          suffixIcon: Icon(
                                            Icons.arrow_drop_down,
                                            color: kColorblack,
                                          ),
                                          contentPadding:
                                              EdgeInsets.only(left: 2.w),
                                          labelStyle: TextStyle(
                                              overflow: TextOverflow.fade,
                                              fontSize: 16.sp,
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
                                  suggestionsCallback: controller.getUnitLists,
                                  // hideKeyboardOnDrag: true,
                                  // hideSuggestionsOnKeyboardHide: false,

                                  itemBuilder:
                                      (context, UnitsModel suggestion) {
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

                                  onSelected: (UnitsModel suggestion) {
                                    unitValue = suggestion;

                                    controller.unitController.text =
                                        unitValue!.name.toString();

                                    controller.unitId = unitValue!.id;
                                  },
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
                                  enabled: false,
                                  controller: controller.openingStockController,
                                  label: "Current Stock"),
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
                                  controller: controller.openingStockController,
                                  label: "Opening Stock"),
                            ),
                          ],
                        ),
                        CustomTextField(
                            multilines: 1,
                            height: 6.h,
                            maxLength: 50,
                            validator: (value) {
                              return null;
                            },
                            textInputType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            obscure: false,
                            controller: controller.partNumberController,
                            label: "Part Number"),
                        CustomTextField(
                            multilines: 1,
                            height: 6.h,
                            validator: (value) {
                              return null;
                            },
                            textInputType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            obscure: false,
                            controller: controller.minimumStockController,
                            label: "Minimum Stock"),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(2.w),
                                height: 6.h,
                                child: TypeAheadField<MaterialCategoryModel>(
                                  controller: controller.categoryController,
                                  builder: (context, categorycontroller,
                                      categoryfocusNode) {
                                    return TextFormField(
                                        enabled: true,
                                        readOnly: true,
                                        controller: categorycontroller,
                                        focusNode: categoryfocusNode,
                                        decoration: InputDecoration(
                                          labelText: "Category",
                                          suffixIcon: Icon(
                                            Icons.arrow_drop_down,
                                            color: kColorblack,
                                          ),
                                          contentPadding:
                                              EdgeInsets.only(left: 2.w),
                                          labelStyle: TextStyle(
                                              overflow: TextOverflow.fade,
                                              fontSize: 16.sp,
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
                                  itemBuilder: (context,
                                      MaterialCategoryModel suggestion) {
                                    return ListTile(
                                      title: Text(suggestion.name ?? ""),
                                    );
                                  },
                                  onSelected:
                                      (MaterialCategoryModel suggestion) {
                                    controller.categoryId.value =
                                        suggestion.id ?? 0;
                                    controller.categoryController.text =
                                        suggestion.name ?? "";

                                    print(controller.categoryController.text);
                                  },
                                  suggestionsCallback: (search) =>
                                      controller.fetchCategory(),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(2.w),
                                height: 6.h,
                                child: TypeAheadField<PartyDTO>(
                                  controller: controller.partyController,
                                  builder: (context, partycontroller,
                                      partyfocusNode) {
                                    return TextFormField(
                                        enabled: true,
                                        readOnly: true,
                                        controller: partycontroller,
                                        focusNode: partyfocusNode,
                                        decoration: InputDecoration(
                                          labelText: "Party",
                                          suffixIcon: Icon(
                                            Icons.arrow_drop_down,
                                            color: kColorblack,
                                          ),
                                          contentPadding:
                                              EdgeInsets.only(left: 2.w),
                                          labelStyle: TextStyle(
                                              overflow: TextOverflow.fade,
                                              fontSize: 16.sp,
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
                                  itemBuilder: (context, PartyDTO suggestion) {
                                    return ListTile(
                                      title: Text(suggestion.name ?? ""),
                                    );
                                  },
                                  onSelected: (PartyDTO suggestion) {
                                    controller.partyId.value =
                                        suggestion.id ?? 0;
                                    controller.partyController.text =
                                        suggestion.name ?? "";

                                    print(controller.partyController.text);
                                  },
                                  suggestionsCallback: (search) =>
                                      controller.fetchPartyList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(2.w),
                                height: 6.h,
                                child: TypeAheadField<TaxesModel>(
                                  debounceDuration:
                                      const Duration(milliseconds: 500),
                                  controller: controller.taxController,
                                  builder:
                                      (context, taxcontroller, taxfocusNode) {
                                    return TextFormField(
                                        readOnly: true,
                                        enabled: true,
                                        controller: taxcontroller,
                                        focusNode: taxfocusNode,
                                        decoration: InputDecoration(
                                          labelText: "Tax",
                                          suffixIcon: Icon(
                                            Icons.arrow_drop_down,
                                            color: kColorblack,
                                          ),
                                          contentPadding:
                                              EdgeInsets.only(left: 2.w),
                                          labelStyle: TextStyle(
                                              overflow: TextOverflow.fade,
                                              fontSize: 16.sp,
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
                                  suggestionsCallback: controller.getTaxesList,
                                  // hideKeyboard: true,
                                  // hideKeyboardOnDrag: true,

                                  itemBuilder:
                                      (context, TaxesModel suggestion) {
                                    final value = suggestion;
                                    return ListTile(
                                      title:
                                          Text("${value.name}@${value.rate}"),
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

                                  onSelected: (TaxesModel suggestion) {
                                    taxValue = suggestion;

                                    controller.taxController.text =
                                        "${taxValue!.name}@${taxValue!.rate}";

                                    controller.taxid = taxValue!.id;

                                    print("tax id --- ${controller.taxid}");
                                  },
                                ),
                              ),
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
                                  controller: controller.mrpController,
                                  label: "Mrp"),
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
                                  controller: controller.buyingPriceController,
                                  label: "Buying Price"),
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
                                  controller: controller.sellingPriceController,
                                  label: "Selling Price"),
                            ),
                          ],
                        ),
                        globalSettings?.aliasNameEnable == 1
                            ? CustomTextField(
                                multilines: 1,
                                maxLength: 50,
                                height: 6.h,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Enter The Alias Name*";
                                  }
                                  return null;
                                },
                                textInputType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                obscure: false,
                                controller: controller.aliasNameController,
                                label: "Alias Name*")
                            : const SizedBox.shrink(),
                        CustomTextField(
                            multilines: null,
                            maxLength: 2000,
                            height: 6.h,
                            validator: (value) {
                              return null;
                            },
                            textInputType: TextInputType.multiline,
                            textInputAction: TextInputAction.next,
                            obscure: false,
                            controller: controller.specificationController,
                            label: "Specification"),
                      ]),
                    ),
                  ),
                  Center(
                    child: CustomButton(
                      width: 50.w,
                      title: "Save",
                      color: const Color.fromARGB(255, 58, 192, 255),
                      textcolor: kColorwhite,
                      ontap: () async {
                        if (formkey.currentState!.validate()) {
                          controller.isPageLoading.value = true;

                          final SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();

                          final logindecoded = json
                              .decode(sharedPreferences.getString('userMap')!);
                          final loginDetails =
                              loginModel.LoginModel.fromJson(logindecoded);

                          MaterialListModel? item;

                          widget.isEdit == true
                              ? item = widget.materialMasterSaved
                              : null;

                          controller.saveMaterailValue = MaterialListModel(
                            buyingPrice:
                                controller.buyingPriceController.text.isEmpty
                                    ? null
                                    : double.parse(
                                        controller.buyingPriceController.text),
                            cessPercentage:
                                widget.isEdit ? item!.cessPercentage : null,
                            companyId: widget.isEdit
                                ? item!.companyId
                                : loginDetails.user!.company!.id,
                            deleted: widget.isEdit ? item!.deleted : null,
                            discountPercentage:
                                widget.isEdit ? item!.discountPercentage : null,
                            hsnCode: controller.hsnController.text.isEmpty
                                ? null
                                : double.parse(controller.hsnController.text),
                            id: widget.isEdit ? item!.id : null,
                            imagePath: widget.isEdit ? item!.imagePath : null,
                            isContainer:
                                widget.isEdit ? item!.isContainer : null,
                            materialImagePath:
                                widget.isEdit ? item!.materialImagePath : null,
                            materialTypeId: widget.isEdit
                                ? item!.materialTypeId
                                : materialTypeValue!.id,
                            materialTypeName:
                                controller.materialTypeController.text,
                            minimumStock:
                                controller.minimumStockController.text.isEmpty
                                    ? null
                                    : double.parse(
                                        controller.minimumStockController.text),
                            mrp: controller.mrpController.text.isEmpty
                                ? null
                                : double.parse(controller.mrpController.text),
                            name: controller.nameController.text,
                            openingStock: widget.isEdit
                                ? item!.openingStock
                                : controller.openingStockController.text.isEmpty
                                    ? null
                                    : double.parse(
                                        controller.openingStockController.text),
                            outName: widget.isEdit ? item!.outName : null,
                            outPartNumber:
                                widget.isEdit ? item!.outPartNumber : null,
                            partNumber: controller.partNumberController.text,
                            partyId:  controller.partyId.value == 0
                                    ? null
                                    : controller.partyId.value,
                            categoryId: controller.categoryId.value == 0
                                ? null
                                : controller.categoryId.value,
                            price:
                                controller.sellingPriceController.text.isEmpty
                                    ? null
                                    : double.parse(
                                        controller.sellingPriceController.text),
                            specification:
                                controller.specificationController.text,
                            stock: widget.isEdit
                                ? item!.stock
                                : controller.openingStockController.text.isEmpty
                                    ? null
                                    : double.parse(
                                        controller.openingStockController.text),
                            supplyTypeId:
                                widget.isEdit ? item!.supplyTypeId : 1,
                            taxId: controller.taxid,
                            unitOfMeasurementId:
                                controller.unitId ?? item!.unitOfMeasurementId,
                            unitOfMeasurementName:
                                controller.unitController.text,
                            aliasName: controller.aliasNameController.text,
                            commission: 0,
                            isBomExists: null,
                            serviceExecutionModeId: null,
                            serviceType: null,
                            qualifiedTeamMembers: null,
                            serviceAvailability: null,
                            serviceStartDate: null,
                            serviceEndDate: null,
                            serviceStatus: null,
                            serviceTypeName: null,
                            subscriptionBasedServices: [],
                          );
                          controller.saveMaterialMaster();
                        }
                      },
                    ),
                  )
                ]),
              ),
            ),
          ),
        ),
        Obx(() => loadingScreenWithText(
            isPageLoading: controller.isPageLoading.value)),
      ],
    );
  }

  void isEdited() async {
    controller.isPageLoading.value = true;

    await controller.getTaxesList("");
    await controller.fetchCategory();
    await controller.fetchPartyList();

    final item = widget.materialMasterSaved;

    controller.nameController.text = item!.name ?? "";
    controller.materialTypeController.text = item.materialTypeName ?? "";
    controller.hsnController.text = item.hsnCode ?? "";
    controller.currentStockController.text =
        item.stock.toString() == "null" ? "" : item.stock.toString();
    controller.unitController.text = item.unitOfMeasurementName ?? "";
    controller.openingStockController.text =
        item.openingStock.toString() == "null"
            ? ""
            : item.openingStock.toString();
    controller.partNumberController.text = item.partNumber ?? "";
    controller.minimumStockController.text =
        item.minimumStock.toString() == "null"
            ? ""
            : item.minimumStock.toString();
    // controller.taxController.text = item.taxId ?? "";
    controller.mrpController.text = item.mrp?.toString() ?? "";
    controller.buyingPriceController.text = item.buyingPrice?.toString() ?? "";
    controller.sellingPriceController.text = item.price?.toString() ?? "";
    controller.specificationController.text = item.specification ?? "";
    controller.aliasNameController.text = item.aliasName ?? "";

    if (item.taxId != null) {
      final variable = controller.taxList
          .firstWhere((e) => e.id.toString() == item.taxId.toString());

      controller.taxController.text = "${variable.name}@${variable.rate}";
      controller.taxid = variable.id;
    }

    print("categoryid----${item.categoryId}");
    if (item.categoryId != null) {
      final variable = controller.categoryList
          .firstWhere((e) => e.id.toString() == item.categoryId.toString());

      controller.categoryController.text = "${variable.name}";
      controller.categoryId.value = variable.id ?? 0;
    }

    if (item.partyId != null) {
      final variable = controller.partyList
          .firstWhere((e) => e.id.toString() == item.partyId.toString());

      controller.partyController.text = "${variable.name}";
      controller.partyId.value = variable.id ?? 0;
    }

    controller.isPageLoading.value = false;
  }
}

class MyBottomSheet extends StatefulWidget {
  const MyBottomSheet({super.key});

  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  final TextEditingController _textFieldController = TextEditingController();
  final List<String> _items = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 30.h,
        padding: EdgeInsets.all(3.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Expense Information",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
            CustomTextField(
                multilines: 1,
                height: 6.h,
                validator: (value) {
                  return null;
                },
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
                obscure: false,
                controller: TextEditingController(),
                label: "Expense Name"),
            const SizedBox(height: 16.0),
            const Spacer(),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                setState(() {
                  _items.add(_textFieldController.text);
                  _textFieldController.clear();
                });
              },
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _items.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_items[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
