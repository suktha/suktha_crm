// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:suktha_crm/Constants/colors.dart';
import 'package:suktha_crm/controllers/settings_controller.dart';
import 'package:suktha_crm/view/Account%20Settings/widgets/edit_company_details.dart';

class BasicInfoScreen extends StatefulWidget {
  BasicInfoScreen({
    super.key,
  });

  @override
  State<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  final controller = Get.find<SettingsController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onLongPress: () {},
                  child: ExpansionTile(
                    onExpansionChanged: (value) {
                      setState(() {
                        controller.contactListExpand.value = !controller.contactListExpand.value;
                      });
                    },
                    title: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.developer_board_outlined),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Contact List',
                          style: TextStyle(fontSize: 4.w),
                        ),
                        Spacer(),
                        controller.contactListExpand == true
                            ? GestureDetector(
                                onTap: () => EditFunction(context),
                                child: Icon(
                                  Icons.edit,
                                  size: 4.5.w,
                                ),
                              )
                            : SizedBox()
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Contact Person Name',
                                  style: TextStyle(fontSize: 3.6.w),
                                ),
                                Text(
                                  controller.companyDetailsValue?.contactPersonName ?? "",
                                  style: TextStyle(fontSize: 3.6.w, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Contact Number',
                                  style: TextStyle(fontSize: 3.6.w),
                                ),
                                Text(
                                  controller.companyDetailsValue?.contactPersonNumber ?? "",
                                  style: TextStyle(fontSize: 3.6.w, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Secondary Mobile',
                                  style: TextStyle(fontSize: 3.6.w),
                                ),
                                Text(
                                  controller.companyDetailsValue?.secondaryMobile ?? "--",
                                  style: TextStyle(fontSize: 3.6.w, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            // CustomTextField(validator: (value) {}, textInputAction: TextInputAction.next, obscure: false, controller: mobileNumber, label: "Mobile Number"),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Primary Mobile',
                                  style: TextStyle(fontSize: 3.6.w),
                                ),
                                Text(
                                  controller.companyDetailsValue?.primaryMobile ?? "",
                                  style: TextStyle(fontSize: 3.6.w, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Primary Telephone',
                                  style: TextStyle(fontSize: 3.6.w),
                                ),
                                Text(
                                  controller.companyDetailsValue?.primaryTelephone ?? "",
                                  style: TextStyle(fontSize: 3.6.w, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Seconday Telephone',
                                  style: TextStyle(fontSize: 3.6.w),
                                ),
                                Text(
                                  controller.companyDetailsValue?.secondaryTelephone ?? "",
                                  style: TextStyle(fontSize: 3.6.w, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            // CustomTextField(validator: (value) {}, textInputAction: TextInputAction.next, obscure: false, controller: mobileNumber, label: "Secondary Number"),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        color: Colors.grey.shade700,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        controller.companyDetailsValue?.email ?? "",
                        style: TextStyle(fontSize: 4.w),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.monetization_on_outlined,
                        color: Colors.grey.shade700,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      controller.companyDetailsValue?.companyCurrencyId == null || controller.currencyList.isEmpty
                          ? Text(
                              "--",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            )
                          : Text(
                              "${controller.currencyList.firstWhere(
                                    (element) => element.id == controller.companyDetailsValue?.companyCurrencyId,
                                  ).currencyName?.toString() ?? "--"} (${controller.currencyList.firstWhere((element) => element.id == controller.companyDetailsValue?.companyCurrencyId).shortName})",
                              style: TextStyle(fontSize: 4.w),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey.shade700,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 70.w,
                        child: Text(
                          controller.companyDetailsValue?.address ?? "",
                          style: TextStyle(fontSize: 4.w),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ExpansionTile(
                  onExpansionChanged: (value) {
                    setState(() {
                      controller.moreDetailsExpand.value = !controller.moreDetailsExpand.value;
                    });
                  },
                  title: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.more_outlined),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'More Details',
                        style: TextStyle(fontSize: 4.w),
                      ),
                      Spacer(),
                      controller.moreDetailsExpand.value == true
                          ? GestureDetector(
                              onTap: () => EditFunction(context),
                              child: Icon(
                                Icons.edit,
                                size: 4.5.w,
                              ),
                            )
                          : SizedBox()
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'City',
                                style: TextStyle(fontSize: 3.6.w),
                              ),
                              controller.companyDetailsValue?.cityId == null
                                  ? Text(
                                      "--",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    )
                                  : Obx(() => Text(controller.cityList.isEmpty ? "" : "${controller.cityList.firstWhere((element) => element.id == controller.companyDetailsValue?.cityId).name ?? ""}",
                                      style: TextStyle(fontSize: 3.6.w, fontWeight: FontWeight.bold))),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Website',
                                style: TextStyle(fontSize: 3.6.w),
                              ),
                              Text(
                                controller.companyDetailsValue?.website ?? "",
                                style: TextStyle(fontSize: 3.6.w, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Fax Number',
                                style: TextStyle(fontSize: 3.6.w),
                              ),
                              Text(
                                controller.companyDetailsValue?.faxNumber ?? "",
                                style: TextStyle(fontSize: 3.6.w, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          // CustomTextField(validator: (value) {}, textInputAction: TextInputAction.next, obscure: false, controller: mobileNumber, label: "Mobile Number"),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pin code',
                                style: TextStyle(fontSize: 3.6.w),
                              ),
                              Text(
                                controller.companyDetailsValue?.pinCode ?? "",
                                style: TextStyle(fontSize: 3.6.w, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tag Line',
                                style: TextStyle(fontSize: 3.6.w),
                              ),
                              Text(
                                controller.companyDetailsValue?.tagLine ?? "",
                                style: TextStyle(fontSize: 3.6.w, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Print Footer',
                                style: TextStyle(fontSize: 3.6.w),
                              ),
                              Text(
                                '--',
                                style: TextStyle(fontSize: 3.6.w, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          // CustomTextField(validator: (value) {}, textInputAction: TextInputAction.next, obscure: false, controller: mobileNumber, label: "Secondary Number"),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                ExpansionTile(
                  onExpansionChanged: (value) {
                    setState(() {
                      controller.companyLegalInfoExpand.value = !controller.companyLegalInfoExpand.value;
                    });
                  },
                  title: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.developer_board_outlined),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Company Legal Information',
                        style: TextStyle(fontSize: 4.w),
                      ),
                      Spacer(),
                      controller.companyLegalInfoExpand.value == true
                          ? GestureDetector(
                              onTap: () => EditFunction(context),
                              child: Icon(
                                Icons.edit,
                                size: 4.5.w,
                              ),
                            )
                          : SizedBox()
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'GST Number',
                                style: TextStyle(fontSize: 3.6.w),
                              ),
                              Text(
                                controller.companyDetailsValue?.gstNumber ?? "",
                                style: TextStyle(fontSize: 3.6.w, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'PAN Number',
                                style: TextStyle(fontSize: 3.6.w),
                              ),
                              Text(
                                controller.companyDetailsValue?.panNumber ?? "",
                                style: TextStyle(fontSize: 3.6.w, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'IEC Code',
                                style: TextStyle(fontSize: 3.6.w),
                              ),
                              Text(
                                controller.companyDetailsValue?.iecCode ?? "--",
                                style: TextStyle(fontSize: 3.6.w, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          // CustomTextField(validator: (value) {}, textInputAction: TextInputAction.next, obscure: false, controller: mobileNumber, label: "Mobile Number"),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'MSME Number',
                                style: TextStyle(fontSize: 3.6.w),
                              ),
                              Text(
                                controller.companyDetailsValue?.msmeNumber ?? "--",
                                style: TextStyle(fontSize: 3.6.w, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'CIN Number',
                                style: TextStyle(fontSize: 3.6.w),
                              ),
                              Text(
                                controller.companyDetailsValue?.cinNumber ?? "--",
                                style: TextStyle(fontSize: 3.6.w, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Obx(() => CustomUploadContainer(
                      imageData: controller.certificateImage.value ?? null,
                      title: "Upload Certificate",
                      deleteOntap: () async {
                        print("upload certificate");
                        await controller.DeleteImages(isCertificate: true, isSignature: false, isQRcode: false);
                      },
                      uploadOntap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return UploadPopUpWidget(
                              title: "Upload New Certificate",
                              buttonText: "Upload",
                              ontap: () async {
                                var file = await controller.obtainImage(source: ImageSource.gallery);

                                await controller.uploadCertificationImage(file!);

                                Get.back();
                              },
                            );
                          },
                        );
                      },
                    )),
                SizedBox(
                  height: 15,
                ),
                Obx(() => CustomUploadContainer(
                      imageData: controller.signatureImage.value ?? null,
                      title: "Upload Signature",
                      deleteOntap: () {},
                      uploadOntap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return UploadPopUpWidget(
                              title: "Upload New Signature",
                              buttonText: "Upload",
                              ontap: () async {
                                var file = await controller.obtainImage(source: ImageSource.gallery);

                                await controller.uploadSignatureImage(file!);

                                Get.back();
                              },
                            );
                          },
                        );
                      },
                    )),
                SizedBox(
                  height: 15,
                ),
                Obx(() => CustomUploadContainer(
                      imageData: controller.qrCodeImage.value ?? null,
                      title: "Upload QR Code",
                      deleteOntap: () {},
                      uploadOntap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return UploadPopUpWidget(
                              title: "Upload New QR Code",
                              buttonText: "Upload",
                              ontap: () async {
                                var file = await controller.obtainImage(source: ImageSource.gallery);

                                await controller.uploadQRcode(file!);

                                Get.back();
                              },
                            );
                          },
                        );
                      },
                    )),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void EditFunction(BuildContext context) async {
    controller.primaryMobNumController.text = controller.companyDetailsValue?.primaryMobile ?? "";
    controller.seconMobileController.text = controller.companyDetailsValue?.secondaryMobile ?? "";
    controller.contactPersonController.text = controller.companyDetailsValue?.contactPersonName ?? "";
    controller.contactPersonNumController.text = controller.companyDetailsValue?.contactPersonNumber ?? "";
    controller.primaryTelephoneNumController.text = controller.companyDetailsValue?.primaryTelephone ?? "";
    controller.secondaryTelephoneNumController.text = controller.companyDetailsValue?.secondaryTelephone ?? "";
    controller.websiteController.text = controller.companyDetailsValue?.website ?? "";
    controller.emailController.text = controller.companyDetailsValue?.email ?? "";
    controller.faxNumController.text = controller.companyDetailsValue?.faxNumber ?? "";
    controller.addressController.text = controller.companyDetailsValue?.address ?? "";
    controller.taglineController.text = controller.companyDetailsValue?.tagLine ?? "";
    controller.pincodeController.text = controller.companyDetailsValue?.pinCode ?? "";
    controller.panNumController.text = controller.companyDetailsValue?.panNumber ?? "";
    controller.iecCodeController.text = controller.companyDetailsValue?.iecCode ?? "";
    controller.msmeNumController.text = controller.companyDetailsValue?.msmeNumber ?? "";
    controller.cinNumController.text = controller.companyDetailsValue?.cinNumber ?? "";
    if (controller.companyDetailsValue?.companyCurrencyId == null) {
      print("inside-----");
      controller.currencyId.value = "";
    } else if (controller.companyDetailsValue?.companyCurrencyId != null) {
      controller.currencyId.value = controller.companyDetailsValue?.companyCurrencyId.toString() ?? "";
    }

    if (controller.companyDetailsValue?.cityId == null) {
      controller.cityId.value = "";
    } else if (controller.companyDetailsValue?.cityId != null) {
      controller.cityId.value = controller.companyDetailsValue?.cityId.toString() ?? "";
    }

    // controller.cityId.value = controller.companyDetailsValue?.cityId.toString();
    await CompanyDetailsBottomSheet(context, controller.companyDetailsValue!, controller);
  }
}

class CustomUploadContainer extends StatelessWidget {
  final String title;
  Uint8List? imageData;
  final VoidCallback uploadOntap;
  final VoidCallback deleteOntap;
  CustomUploadContainer({super.key, required this.title, required this.uploadOntap, required this.deleteOntap, this.imageData});

  // final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return imageData == null
        ? GestureDetector(
            onTap: uploadOntap,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: kColorlightBlue),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 15, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold, color: kColorwhite),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        : Row(
            children: [
              Container(
                height: 80,
                width: 35.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.w),
                  image: DecorationImage(
                    image: MemoryImage(imageData!),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Spacer(),
              Column(
                children: [
                  GestureDetector(
                      onTap: uploadOntap,
                      child: Container(
                          height: 35,
                          width: 50.w,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: kColorlightBlue),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Update",
                              style: TextStyle(
                                color: kColorwhite,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ))),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                      onTap: deleteOntap,
                      child: Container(
                          height: 35,
                          width: 50.w,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: kColorRed),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                color: kColorwhite,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )))
                ],
              )
            ],
          );
  }
}

class UploadPopUpWidget extends StatelessWidget {
  const UploadPopUpWidget({
    super.key,
    required this.ontap,
    required this.buttonText,
    required this.title,
  });

  final VoidCallback ontap;
  final String buttonText;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.w))),
      title: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      content: SizedBox(
        width: 100.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: ontap,
              child: Container(
                height: 6.h,
                width: 30.w,
                decoration: BoxDecoration(color: kColorlightBlue, borderRadius: BorderRadius.circular(5.w)),
                child: Center(
                    child: Text(
                  buttonText,
                  style: TextStyle(fontWeight: FontWeight.bold, color: kColorwhite),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
