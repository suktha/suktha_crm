// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/controllers/global_controller.dart';
import 'package:work_Force/utils/Date.dart';
import 'package:work_Force/view/widget/custom_textfield.dart';


class MaterialListCustom extends StatelessWidget {
  final VoidCallback ontap;
  final VoidCallback onlongpress;
  final String name;
  final String quantity;
  final String amount;

  MaterialListCustom({
    super.key,
    required this.amount,
    required this.name,
    required this.quantity,
    required this.ontap,
    required this.onlongpress,
  });

  final globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      onLongPress: onlongpress,
      child: Container(
          // height: 7.h,
          color: kColorwhite,
          margin: EdgeInsets.all(0.w),
          padding: EdgeInsets.all(2.w),
          // decoration: BoxDecoration(
          //   color: Color.fromARGB(255, 241, 250, 255),
          //   boxShadow: kElevationToShadow[2],
          //   borderRadius: BorderRadius.circular(3.w),
          // ),
          child: ListTile(
            // dense: true,
            contentPadding: EdgeInsets.zero,
            leading: ClipRect(
              child: Image.network(
                  "https://cdn.vectorstock.com/i/preview-1x/65/30/default-image-icon-missing-picture-page-vector-40546530.jpg"),
            ),

            title: Text(
              name,
              style: TextStyle(color: kColorblack, fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              quantity,
              style: TextStyle(color: kColorblack, fontSize: 15.sp, fontWeight: FontWeight.normal),
            ),
            trailing: Text(
              " ${amount}",
              style: TextStyle(color: kColorblack, fontSize: 16.sp, fontWeight: FontWeight.normal),
            ),
          )),
    );
  }
}

Future<dynamic> productDetailsPOPup(
  VoidCallback closeTap,
  bool itemlevel,
  BuildContext context,
  Key formKey,
  TextEditingController slnoController,
  TextEditingController materialController,
  TextEditingController partnumController,
  TextEditingController hsnController,
  TextEditingController unitController,
  TextEditingController quantityController,
  TextEditingController priceController,
  TextEditingController amountController,
  TextEditingController remarksController,
  TextEditingController descriptionProductController,
  TextEditingController discountPercentController,
  TextEditingController discountAmountController,
  TextEditingController amountAfterDiscountController,
  TextEditingController sgstpercentController,
  TextEditingController sgstAmountController,
  TextEditingController cgstPercentController,
  TextEditingController cgstAmountController,
  TextEditingController igstAmountController,
  TextEditingController igstPercentController,
  TextEditingController amountAfterTaxController,
  VoidCallback ontapDelete,
  Function(String) hsnONchanged,
  Function(String) descriptionOnchanged,
  Function(String) priceOnchanged,
  Function(String) remarksOnchanged,
  Function(String) quantityOnchanged,
  Function(String) discountPercentOnchanged,
  Function(String) discountAmountOnchanged,
  VoidCallback confirmTap, {
  bool? isDisableQty = true,
  bool? isRecuringService = false,
  int? serviceFrequencyDays,
  TextEditingController? enddateController,
  TextEditingController? startdateController,
}) {
  print("COMMENTS --inside the product list pop up-- ${descriptionProductController.text}");

  // final formKey = GlobalKey<FormState>();
  final globalController = Get.find<GlobalController>();

  return showDialog(
    barrierDismissible: true,
    barrierColor: kColorblack45,
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(
          backgroundColor: Colors.white,

          actionsPadding: EdgeInsets.symmetric(horizontal: 10.w),

          actions: [
            Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: Row(
                children: [
                  // SizedBox(width: 2.w,),
                  CircleAvatar(
                    radius: 6.w,
                    backgroundColor: Colors.red,
                    child: Center(
                      child: IconButton(
                        onPressed: ontapDelete,
                        icon: Icon(
                          Icons.delete,
                          color: kColorwhite,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 6.w,
                    backgroundColor: Colors.lightBlue[300],
                    child: Center(
                      child: IconButton(
                        onPressed: confirmTap,
                        icon: Icon(
                          Icons.done,
                          color: kColorwhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],

          // insetPadding: EdgeInsets.all(5.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.w),
          ),
          elevation: 6,
          content: SizedBox(
            width: 100.w,

            // height: itemlevel == true ? 50.h : 47.h,
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: closeTap,
                        icon: Icon(
                          Icons.close,
                          color: kColorblack,
                        )),
                    Row(
                      children: [
                        Expanded(
                            // flex: 1,
                            child: CustomTextField(
                          multilines: 1,
                          validator: (value) {
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          obscure: false,

                          controller: slnoController,

                          label: "SL NO",
                          height: 6.h,
                          readonly: true,
                          // labelBehavior: FloatingLabelBehavior.always,
                        )),
                        SizedBox(
                          width: 2.w,
                        ),
                        Expanded(
                            // flex: 1,
                            child: CustomTextField(
                          multilines: 1,
                          validator: (value) {
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          obscure: false,
                          controller: materialController,

                          label: "Material",
                          height: 6.h,
                          readonly: true,
                          // labelBehavior: FloatingLabelBehavior.always,
                        )),
                      ],
                    ),
                    CustomTextField(
                      multilines: 1,
                      validator: (value) {
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      obscure: false,
                      controller: partnumController,

                      label: "Part Number",
                      height: 6.h,
                      readonly: true,
                      // labelBehavior: FloatingLabelBehavior.always,
                    ),
                    Row(
                      children: [
                        Expanded(
                            // flex: 2,
                            child: CustomTextField(
                          multilines: 1,
                          validator: (value) {
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          obscure: false,
                          controller: hsnController,
                          onchanged: hsnONchanged,

                          label: "HSN/SAC",
                          height: 6.h,
                          enabled: true,
                          // labelBehavior: FloatingLabelBehavior.always,
                        )),
                        SizedBox(
                          width: 1.w,
                        ),
                        Expanded(
                            // flex: 1,
                            child: CustomTextField(
                          multilines: 1,
                          validator: (value) {
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          obscure: false,
                          controller: unitController,

                          label: "UOM*",
                          height: 6.h,
                          readonly: true,
                          // labelBehavior: FloatingLabelBehavior.always,
                        )),
                      ],
                    ),
                    isRecuringService == true
                        ? Column(
                            children: [
                              CustomTextField(
                                  ontap: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Do you want auto calculation for End Date based on Service Frequency..?",
                                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                Get.back();

                                                DateFormat format = DateFormat("dd/MM/yyyy");
                                                DateTime initialDate = DateTime.now();

                                                if (startdateController!.text.isNotEmpty) {
                                                  try {
                                                    initialDate = format.parse(startdateController.text);
                                                  } catch (e) {
                                                    print("Invalid date format: ${startdateController.text}");
                                                  }
                                                }
                                                final DateTime? pickedDate = await showDatePicker(
                                                    context: context,
                                                    initialDate: initialDate,
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2101));

                                                if (pickedDate != null) {
                                                  startdateController.text = format.format(pickedDate);

                                                  print("start date - ${startdateController.text}");
                                                  print("serviceFrequencyDays - $serviceFrequencyDays");

                                                  enddateController!.text = DateClass()
                                                      .showDate(pickedDate.add(Duration(days: serviceFrequencyDays! - 1)).toString());
                                                  print("enddateController - ${enddateController.text}");
                                                }

                                                // DateClass().selectDate(
                                                //     currentdateTimeNow: startdateController!.text, startdateController, false, false);
                                              },
                                              child: Text(
                                                "Yes",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Get.back();

                                                DateClass().selectDate(
                                                    currentdateTimeNow: startdateController.text, startdateController, false, false);
                                              },
                                              child: Text(
                                                "No",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp, color: kColorblack),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  multilines: 1,
                                  suffixIcon: IconButton(
                                      splashColor: kColortransparent,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                "Do you want auto calculation for End Date based on Service Frequency..?",
                                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () async {
                                                    Get.back();

                                                    DateFormat format = DateFormat("dd/MM/yyyy");
                                                    DateTime initialDate = DateTime.now();

                                                    if (startdateController!.text.isNotEmpty) {
                                                      try {
                                                        initialDate = format.parse(startdateController.text);
                                                      } catch (e) {
                                                        print("Invalid date format: ${startdateController.text}");
                                                      }
                                                    }
                                                    final DateTime? pickedDate = await showDatePicker(
                                                        context: context,
                                                        initialDate: initialDate,
                                                        firstDate: DateTime(2000),
                                                        lastDate: DateTime(2101));

                                                    if (pickedDate != null) {
                                                      startdateController.text = format.format(pickedDate);

                                                      print("start date - ${startdateController.text}");
                                                      print("serviceFrequencyDays - $serviceFrequencyDays");

                                                      enddateController!.text = DateClass()
                                                          .showDate(pickedDate.add(Duration(days: serviceFrequencyDays! - 1)).toString());
                                                      print("enddateController - ${enddateController.text}");
                                                    }

                                                    // DateClass().selectDate(
                                                    //     currentdateTimeNow: startdateController!.text, startdateController, false, false);
                                                  },
                                                  child: Text(
                                                    "Yes",
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Get.back();

                                                    DateClass().selectDate(
                                                        currentdateTimeNow: startdateController!.text, startdateController, false, false);
                                                  },
                                                  child: Text(
                                                    "No",
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp, color: kColorblack),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.date_range)),
                                  // height: 6.h,
                                  validator: (value) {
                                    if (startdateController.text.isNotEmpty && enddateController!.text.isNotEmpty) {
                                      try {
                                        DateTime startDate = DateFormat("dd/MM/yyyy").parse(startdateController.text);
                                        DateTime endDate = DateFormat("dd/MM/yyyy").parse(enddateController.text);

                                        if (startDate.isAfter(endDate)) {
                                          return "Cannot be greater than the end date. ";
                                        }
                                      } catch (e) {
                                        return "Invalid date format.";
                                      }
                                    } // Valid input
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  obscure: false,
                                  readonly: true,
                                  controller: startdateController!,
                                  // controller: taxController.purchaseOrderDateController,
                                  label: "Start Date"),
                              CustomTextField(
                                  multilines: 1,
                                  ontap: () =>
                                      DateClass().selectDate(enddateController, false, false, currentdateTimeNow: enddateController.text),
                                  suffixIcon: IconButton(
                                      splashColor: kColortransparent,
                                      onPressed: () {
                                        DateClass()
                                            .selectDate(enddateController!, false, false, currentdateTimeNow: enddateController.text);
                                      },
                                      icon: const Icon(Icons.date_range)),
                                  height: 6.h,
                                  validator: (value) {
                                    if (startdateController.text.isNotEmpty && enddateController!.text.isNotEmpty) {
                                      try {
                                        DateTime startDate = DateFormat("dd/MM/yyyy").parse(startdateController.text);
                                        DateTime endDate = DateFormat("dd/MM/yyyy").parse(enddateController.text);

                                        if (endDate.isBefore(startDate)) {
                                          return "Cannot be lesser than the start date. ";
                                        }
                                      } catch (e) {
                                        return "Invalid date format.";
                                      }
                                    }
                                    //
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  obscure: false,
                                  readonly: true,
                                  controller: enddateController!,
                                  // controller: taxController.purchaseOrderDateController,
                                  label: "End Date"),
                            ],
                          )
                        : const SizedBox(),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                          multilines: 1,
                          validator: (value) {
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          obscure: false,
                          textInputType: TextInputType.number,
                          controller: quantityController,

                          label: "Quantity",
                          onchanged: quantityOnchanged,

                          height: 6.h,
                          enabled: isDisableQty,
                          // labelBehavior: FloatingLabelBehavior.always,
                        )),
                        SizedBox(
                          width: 1.w,
                        ),
                        Expanded(
                            // flex: 2,
                            child: CustomTextField(
                          multilines: 1,
                          validator: (value) {
                            try {
                              if (value.isEmpty) {
                                return "Add Price";
                              } else if (double.parse(value) < 1) {
                                return "Price must be at least 1";
                              }
                            } catch (e) {
                              return "Invalid input";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          obscure: false,
                          controller: priceController,
                          textInputType: TextInputType.number,

                          label: "Price",
                          onEditingComplete: () {},
                          onchanged: priceOnchanged,

                          height: 6.h,
                          enabled: true,
                          // labelBehavior: FloatingLabelBehavior.always,
                        )),
                        itemlevel == true
                            ? Expanded(
                                // flex: 1,
                                child: CustomTextField(
                                multilines: 1,
                                validator: (value) {
                                  return null;
                                },
                                textInputAction: TextInputAction.next,
                                obscure: false,
                                controller: amountController,

                                textInputType: TextInputType.number,

                                label: "Amount",
                                height: 6.h,
                                readonly: true,
                                // labelBehavior: FloatingLabelBehavior.always,
                              ))
                            : const SizedBox(),
                      ],
                    ),
                    itemlevel == true
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      // flex: 1,
                                      child: CustomTextField(
                                    multilines: 1,
                                    validator: (value) {
                                      return null;
                                    },
                                    textInputAction: TextInputAction.next,
                                    obscure: false,

                                    textInputType: TextInputType.number,

                                    controller: discountPercentController,

                                    label: "Disc %",
                                    onchanged: discountPercentOnchanged,

                                    height: 6.h,
                                    enabled: true,
                                    // labelBehavior: FloatingLabelBehavior.always,
                                  )),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Expanded(
                                      // flex: 2,
                                      child: CustomTextField(
                                    multilines: 1,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return;
                                      }
                                      return null;
                                    },
                                    textInputAction: TextInputAction.next,
                                    obscure: false,
                                    controller: discountAmountController,
                                    label: "Disc Amt",
                                    textInputType: TextInputType.number,
                                    onEditingComplete: () {},
                                    onchanged: discountAmountOnchanged,
                                    height: 6.h,
                                    enabled: true,
                                  )),
                                  itemlevel == true
                                      ? Expanded(
                                          // flex: 1,
                                          child: CustomTextField(
                                          multilines: 1,
                                          validator: (value) {
                                            return null;
                                          },
                                          textInputAction: TextInputAction.next,
                                          obscure: false,
                                          controller: amountAfterDiscountController,
                                          label: "Amt after Disc",
                                          height: 6.h,
                                          readonly: true,
                                        ))
                                      : const SizedBox(),
                                ],
                              ),
                              globalController.isStateLevel.value
                                  ? Row(
                                      children: [
                                        Expanded(
                                            // flex: 1,
                                            child: CustomTextField(
                                          multilines: 1,
                                          validator: (value) {
                                            return null;
                                          },
                                          textInputAction: TextInputAction.next,
                                          obscure: false,
                                          controller: sgstpercentController,
                                          label: "SGST %",
                                          height: 6.h,
                                          readonly: true,
                                        )),
                                        SizedBox(width: 1.w),
                                        Expanded(
                                            // flex: 2,
                                            child: CustomTextField(
                                          multilines: 1,
                                          validator: (value) {
                                            return null;
                                          },
                                          textInputAction: TextInputAction.next,
                                          obscure: false,
                                          controller: sgstAmountController,
                                          label: "SGST Amount",
                                          height: 6.h,
                                          readonly: true,
                                        )),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                            // flex: 1,
                                            child: CustomTextField(
                                          multilines: 1,
                                          validator: (value) {
                                            return null;
                                          },
                                          textInputAction: TextInputAction.next,
                                          obscure: false,
                                          controller: igstPercentController,
                                          label: "IGST %",
                                          height: 6.h,
                                          readonly: true,
                                        )),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        Expanded(
                                            // flex: 2,
                                            child: CustomTextField(
                                          multilines: 1,
                                          validator: (value) {
                                            return null;
                                          },
                                          textInputAction: TextInputAction.next,
                                          obscure: false,
                                          controller: igstAmountController,
                                          label: "IGST Amount",
                                          height: 6.h,
                                          readonly: true,
                                        )),
                                      ],
                                    ),
                              globalController.isStateLevel.value
                                  ? Row(
                                      children: [
                                        Expanded(
                                            // flex: 1,
                                            child: CustomTextField(
                                          multilines: 1,
                                          validator: (value) {
                                            return null;
                                          },
                                          textInputAction: TextInputAction.next,
                                          obscure: false,
                                          controller: cgstPercentController,
                                          label: "CGST %",
                                          height: 6.h,
                                          readonly: true,
                                        )),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        Expanded(
                                          // flex: 2,
                                          child: CustomTextField(
                                            multilines: 1,
                                            validator: (value) {
                                              return null;
                                            },
                                            textInputAction: TextInputAction.next,
                                            obscure: false,
                                            controller: cgstAmountController,
                                            label: "CGST Amount",
                                            height: 6.h,
                                            readonly: true,
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                            ],
                          )
                        : const SizedBox(),
                    itemlevel == false
                        ? CustomTextField(
                            multilines: 1,
                            validator: (value) {
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            obscure: false,
                            controller: amountController,

                            label: "Amount",
                            height: 6.h,
                            readonly: true,
                            // labelBehavior: FloatingLabelBehavior.always,
                          )
                        : CustomTextField(
                            multilines: 1,
                            validator: (value) {
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            obscure: false,
                            controller: amountAfterTaxController,

                            label: "Amount After tax",
                            height: 6.h,
                            readonly: true,
                            // labelBehavior: FloatingLabelBehavior.always,
                          ),
                    CustomTextField(
                      multilines: null,
                      validator: (value) {
                        return null;
                      },
                      textInputAction: TextInputAction.newline,
                      obscure: false,
                      controller: remarksController,

                      label: "Remarks",
                      height: 6.h,
                      onchanged: remarksOnchanged,

                      enabled: true,
                      // labelBehavior: FloatingLabelBehavior.always,
                    ),
                    CustomTextField(
                      multilines: null,
                      validator: (value) {
                        return null;
                      },
                      textInputAction: TextInputAction.newline,
                      obscure: false,
                      controller: descriptionProductController,

                      label: "Description",
                      height: 6.h,
                      onchanged: descriptionOnchanged,

                      enabled: true,
                      // labelBehavior: FloatingLabelBehavior.always,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
