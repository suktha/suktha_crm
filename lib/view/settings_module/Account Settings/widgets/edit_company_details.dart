// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/Model/company_model.dart';
import 'package:work_Force/controllers/settings_controller.dart';
import 'package:work_Force/utils/validations/validations.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';

CompanyDetailsBottomSheet(BuildContext context, CompanyModel companyDetails, SettingsController controller) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return FadeInUp(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Padding(
            padding: EdgeInsets.only(top: 6.h, left: 3.w, right: 3.w, bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          ' Edit Company Profile',
                          style: TextStyle(fontSize: 22, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold, color: kColorblack),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            controller.contactListExpand.value = false;
                            controller.companyLegalInfoExpand.value = false;
                            controller.moreDetailsExpand.value = false;
                            Get.back();
                          },
                          child: CircleAvatar(
                            radius: 4.4.w,
                            child: Icon(
                              Icons.close,
                            ),
                          ),
                        )
                        // IconButton(onPressed: () {}, icon: )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          CustomTextField(
                              textInputType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return null;
                                } else if (!Validate().validateMobile(value)) {
                                  return 'Please enter valid Mobile Number';
                                }

                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              obscure: false,
                              controller: controller.primaryMobNumController,
                              label: 'Primary Mobile'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              textInputType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return null;
                                } else if (!Validate().validateMobile(value)) {
                                  return 'Please enter valid Mobile Number';
                                }

                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              obscure: false,
                              controller: controller.seconMobileController,
                              label: 'Secondary Mobile'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              textInputType: TextInputType.name,
                              validator: (value) {
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              obscure: false,
                              controller: controller.contactPersonController,
                              label: 'Contact Person'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              textInputType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return null;
                                } else if (!Validate().validateMobile(value)) {
                                  return 'Please enter valid Mobile Number';
                                }

                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              obscure: false,
                              controller: controller.contactPersonNumController,
                              label: 'Contact Number'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              textInputType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return null;
                                } else if (value.length <= 5) {
                                  return 'Please enter valid Telephone Number';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              obscure: false,
                              controller: controller.primaryTelephoneNumController,
                              label: 'Primary Telephone'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              textInputType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return null;
                                } else if (value.length <= 5) {
                                  return 'Please enter valid Telephone Number';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              obscure: false,
                              controller: controller.secondaryTelephoneNumController,
                              label: 'Secondary Telephone'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              textInputType: TextInputType.name,
                              validator: (value) {
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              obscure: false,
                              controller: controller.websiteController,
                              label: 'Website'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              textInputType: TextInputType.emailAddress,
                              validator: (value) {
                                if (Validate().validateEmail(value)) {
                                  return null;
                                } else {
                                  return "Please enter valid Email";
                                }
                              },
                              textInputAction: TextInputAction.next,
                              obscure: false,
                              controller: controller.emailController,
                              label: 'Email*'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              textInputType: TextInputType.number,
                              validator: (value) {
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              obscure: false,
                              controller: controller.faxNumController,
                              label: 'Fax Number'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              textInputType: TextInputType.streetAddress,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter valid Address';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              obscure: false,
                              controller: controller.addressController,
                              label: 'Address*'),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => Container(
                                margin: EdgeInsets.all(2.w),
                                height: 8.h,
                                // width: 30.w,
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a currency';
                                    }
                                    return null;
                                  },
                                  // underline: Divider(
                                  //   color: kColorgrey,
                                  //   thickness: 1,
                                  //   height: 1,
                                  // ),
                                  value: controller.currencyId.value,
                                  items: [
                                    DropdownMenuItem<String>(
                                      value: "",
                                      child: Text("Currency*"),
                                    ),
                                    ...controller.currencyList.map((item) => DropdownMenuItem<String>(
                                          value: item.id.toString(),
                                          child: Text("${item.currencyName} (${item.shortName})"),
                                        )),
                                  ],
                                  onChanged: (newValue) {
                                    controller.currencyId.value = newValue!;

                                    print(controller.currencyId.value);

                                    controller.currencyName.value = controller.currencyList.firstWhere((item) => item.id.toString() == controller.currencyId.value).currencyName!;

                                    print(controller.currencyName.value);
                                    controller.shortName.value = controller.currencyList.firstWhere((item) => item.id.toString() == controller.currencyId.value).shortName!;
                                    print(controller.shortName.value);
                                  },
                                  hint: Text('Select an item'),
                                )),
                          ),
                          CustomTextField(
                              textInputType: TextInputType.text,
                              validator: (value) {
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              obscure: false,
                              controller: controller.taglineController,
                              label: 'Tag Line'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              textInputType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return null; // Don't validate if empty
                                }
                                if (value.length <= 5) {
                                  return 'Please enter a valid Pincode';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              obscure: false,
                              controller: controller.pincodeController,
                              label: 'Pin code'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              textInputType: TextInputType.text,
                              validator: (value) {
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              obscure: false,
                              controller: controller.printFooterController,
                              label: 'Print Footer'),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => Container(
                                margin: EdgeInsets.all(2.w),
                                height: 8.h,
                                // width: 30.w,
                                child: DropdownButtonFormField(
                                  isExpanded: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please select the city";
                                    }
                                    return null;
                                  },
                                  value: controller.cityId.value,
                                  items: [
                                    DropdownMenuItem<String>(
                                      value: "",
                                      child: Text("City*"),
                                    ),
                                    ...controller.cityList.map((item) => DropdownMenuItem<String>(
                                          value: item.id.toString(),
                                          child: Text("${item.name}"),
                                        )),
                                  ],
                                  onChanged: (newValue) {
                                    controller.cityId.value = newValue!;

                                    print(controller.cityId.value);

                                    controller.cityName.value = controller.cityList.firstWhere((item) => item.id.toString() == controller.cityId.value).name!;

                                    print(controller.cityName.value);
                                  },
                                  hint: Text('Select an item'),
                                )),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            // height: 5.5.h,
                            decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(3.5.w)),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                'Company Legal Information',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.7.sp, color: kColorblack),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              textInputType: TextInputType.text,
                              validator: (value) {
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              obscure: false,
                              controller: controller.panNumController,
                              label: 'PAN Number'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              textInputType: TextInputType.text,
                              validator: (value) {
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              obscure: false,
                              controller: controller.iecCodeController,
                              label: 'IEC Code'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              textInputType: TextInputType.text,
                              validator: (value) {
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              obscure: false,
                              controller: controller.msmeNumController,
                              label: 'MSME Number'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              textInputType: TextInputType.text,
                              validator: (value) {
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              obscure: false,
                              controller: controller.cinNumController,
                              label: 'CIN Number'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 5.5.h,
                              width: 45.w,
                              decoration: BoxDecoration(color: kColorwhite, boxShadow: kElevationToShadow[2], borderRadius: BorderRadius.circular(3.5.w)),
                              child: Center(
                                child: Text(
                                  'Close',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: kColorblack),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                final value = CompanyModel(
                                    address: controller.addressController.text,
                                    addressesListDTO: [],
                                    ceritificateImagePath: companyDetails.ceritificateImagePath,
                                    cinNumber: controller.cinNumController.text,
                                    cityId: int.parse(controller.cityId.value),
                                    companyCurrencyId: int.parse(controller.currencyId.value),
                                    companyLogoPath: companyDetails.companyLogoPath,
                                    contactPersonName: controller.contactPersonController.text,
                                    contactPersonNumber: controller.contactPersonNumController.text,
                                    countryId: companyDetails.countryId,
                                    deleted: companyDetails.deleted,
                                    email: controller.emailController.text,
                                    enableTrailAccount: companyDetails.enableTrailAccount,
                                    faxNumber: controller.faxNumController.text,
                                    gstNumber: companyDetails.gstNumber,
                                    gstRegistrationTypeId: companyDetails.gstRegistrationTypeId,
                                    id: companyDetails.id,
                                    iecCode: controller.iecCodeController.text,
                                    materialIds: companyDetails.materialIds,
                                    msmeNumber: controller.msmeNumController.text,
                                    name: companyDetails.name,
                                    panDate: companyDetails.panDate,
                                    panNumber: controller.panNumController.text,
                                    paymentId: companyDetails.paymentId,
                                    pinCode: controller.pincodeController.text,
                                    planId: companyDetails.planId,
                                    primaryMobile: controller.primaryMobNumController.text,
                                    primaryTelephone: controller.primaryTelephoneNumController.text,
                                    referedId: companyDetails.referedId,
                                    refereeEmail: companyDetails.refereeEmail,
                                    schemeType: companyDetails.schemeType,
                                    secondaryMobile: controller.seconMobileController.text,
                                    secondaryTelephone: controller.secondaryTelephoneNumController.text,
                                    signatureImagePath: companyDetails.signatureImagePath,
                                    stateId: companyDetails.stateId,
                                    statusId: companyDetails.statusId,
                                    subject: companyDetails.subject,
                                    subscriptionEnd: companyDetails.subscriptionEnd,
                                    subscriptionId: companyDetails.subscriptionId,
                                    subscriptionStart: companyDetails.subscriptionStart,
                                    tagLine: controller.taglineController.text,
                                    tinDate: companyDetails.tinDate,
                                    tinNumber: companyDetails.tinNumber,
                                    website: controller.websiteController.text);
                                controller.companyDetailsValue = value;
                                await controller.saveCompanyDetails([]);
                              }
                            },
                            child: Container(
                              height: 5.5.h,
                              width: 45.w,
                              decoration: BoxDecoration(color: kColorlightBlue, boxShadow: kElevationToShadow[2], borderRadius: BorderRadius.circular(3.5.w)),
                              child: Center(
                                child: Text(
                                  'Save',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: kColorwhite),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
