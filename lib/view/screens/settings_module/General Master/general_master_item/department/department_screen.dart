// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:suktha/Controller/global_controller.dart';
// import 'package:flutter_swipe_action_cell/core/cell.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:sizer/sizer.dart';
// import 'package:suktha/Constants/colors.dart';
// import 'package:suktha/View/More%20Modules/screens/general_master/general_master_controller.dart';
// import 'package:suktha/View/More%20Modules/screens/general_master/general_master_screen.dart';
// import 'package:suktha/View/Widgets/custom_popup_with_widget.dart';
// import 'package:suktha/View/Widgets/custom_textfield.dart';
// import 'package:suktha/View/Widgets/deleteAlertDialogue.dart';

// class DepartmentScreen extends StatefulWidget {
//   DepartmentScreen({super.key});

//   @override
//   State<DepartmentScreen> createState() => _DepartmentScreenState();
// }

// class _DepartmentScreenState extends State<DepartmentScreen> {
//   final GeneralMasterController controller = Get.put(GeneralMasterController());

//   GlobalKey<FormState> formkey = GlobalKey<FormState>();
//   @override
//   void initState() {
//     super.initState();
//     controller.getDepartmentDetails();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(14.h),
//         child: AppBar(
//             title: const Text("Department"),
//             actions: [
//               IconButton(
//                   onPressed: () async {
//                     controller.searchController.clear();
//                     controller.search("");
//                     controller.searchResultDepartment.clear();
//                     await controller.getDepartmentDetails();
//                     // await controller.getCountryDetails("");
//                   },
//                   icon: Icon(
//                     Icons.refresh,
//                     color: kColorblack,
//                   ))
//             ],
//             bottom: PreferredSize(
//               preferredSize: Size.fromHeight(14.h),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20.0, right: 20),
//                     child: Container(
//                       height: 6.h,
//                       // width: 75.w,
//                       decoration: BoxDecoration(
//                         boxShadow: kElevationToShadow[4],
//                         color: kColorwhite,
//                         borderRadius: BorderRadius.circular(3.w),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             child: TextField(
//                               onChanged: (value) => controller.search(value),
//                               controller: controller.searchController,
//                               decoration: InputDecoration(
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 hintText: 'Search Here',
//                                 hintStyle: TextStyle(color: kColorgrey),
//                                 contentPadding: EdgeInsets.symmetric(horizontal: 20),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             titleTextStyle: TextStyle(color: kColorblack, fontWeight: FontWeight.bold, fontSize: 18.sp),
//             centerTitle: false,
//             backgroundColor: kColorwhite,
//             elevation: 0,
//             leading: IconButton(
//               icon: Icon(
//                 Icons.keyboard_arrow_left,
//                 color: kColorblack,
//                 size: 25.sp,
//               ),
//               onPressed: (() {
//                 controller.searchController.clear();
//                 controller.search("");
//                 Get.to(() => GeneralMasterScreen(), transition: Transition.fade, duration: Duration(milliseconds: 600));
//                 // Get.back();
//               }),
//             )),
//       ),
//       body: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 8.0, bottom: 75, right: 8, top: 8),
//             child: Obx(
//               () {
//                 return controller.searchResultDepartment.isEmpty
//                     ? Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             FadeIn(delay: const Duration(milliseconds: 300), duration: const Duration(milliseconds: 300), child: LottieBuilder.asset("assets/lottie/empty.json")),
//                             SizedBox(
//                               height: 3.h,
//                             ),
//                             FadeIn(
//                               delay: const Duration(milliseconds: 500),
//                               duration: const Duration(milliseconds: 500),
//                               child: Text(
//                                 "Your Department is Empty ",
//                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                           ],
//                         ),
//                       )
//                     : ListView.builder(
//                         itemCount: controller.searchResultDepartment.length,
//                         physics: BouncingScrollPhysics(),
//                         // shrinkWrap: true,
//                         itemBuilder: (context, index) {
//                           var items = controller.searchResultDepartment[index];
//                           return SwipeActionCell(
//                             key: UniqueKey(),
//                             trailingActions: <SwipeAction>[
//                               SwipeAction(
//                                   performsFirstActionWithFullSwipe: false,
//                                   backgroundRadius: 6.w,
//                                   widthSpace: 20.w,
//                                   title: "Delete",
//                                   style: TextStyle(fontWeight: FontWeight.bold, color: kColorwhite),
//                                   onTap: (CompletionHandler handler) async {
//                                     customDeleteAlertDialogue(
//                                       context,
//                                       () async {
//                                         print(items.id);
//                                         controller.deleteDepartmentDetails(items.id);
//                                         Get.back();
//                                       },
//                                     );
//                                   },
//                                   color: Colors.red),
//                             ],
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: GestureDetector(
//                                 onTap: () {
//                                   controller.departmentNameController.text = controller.department_items[index].departmentName ?? "";

//                                   showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       return Form(
//                                           key: formkey,
//                                           child: CustomPopup(
//                                               children: [
//                                                 CustomTextField(
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return 'Please Enter department name';
//                                                       }
//                                                       return null;
//                                                     },
//                                                     textInputAction: TextInputAction.next,
//                                                     obscure: false,
//                                                     controller: controller.departmentNameController,
//                                                     label: "Department Name")
//                                               ],
//                                               title: "Edit Your Department",
//                                               onCancelPressed: () {
//                                                 Get.back();
//                                                 controller.departmentNameController.clear();
//                                               },
//                                               onUpdatePressed: () {
//                                                 if (formkey.currentState!.validate()) {
//                                                   print('pressed button entering to controller');
//                                                   controller.editDepartmentDetails(id: controller.department_items[index].id ?? 0, delete: controller.department_items[index].deleted ?? '');
//                                                   Get.back();

//                                                   controller.departmentNameController.clear();
//                                                 } else {
//                                                   print("not validated");
//                                                 }
//                                               },
//                                               saveButtonText: "Edit"));
//                                     },
//                                   );
//                                 },
//                                 child: FadeInRightBig(
//                                   duration: Duration(milliseconds: 800),
//                                   child: Container(
//                                     // height: 80,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: Colors.grey[50],
//                                       boxShadow: kElevationToShadow[1],
//                                     ),
//                                     // height: 40,
//                                     child: ListTile(
//                                       title: Text(
//                                         "Department",
//                                         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey.shade700),
//                                       ),
//                                       subtitle: Text(
//                                         "${items.departmentName ?? ''}",
//                                         style: TextStyle(fontWeight: FontWeight.w500, color: kColorblack, fontSize: 16),
//                                       ),
//                                       trailing: Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Container(
//                                             height: 40,
//                                             width: 40,
//                                             decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30), boxShadow: kElevationToShadow[1]),
//                                             child: IconButton(
//                                               onPressed: () {
//                                                 controller.departmentNameController.text = controller.department_items[index].departmentName ?? "";

//                                                 showDialog(
//                                                   context: context,
//                                                   builder: (context) {
//                                                     return Form(
//                                                         key: formkey,
//                                                         child: CustomPopup(
//                                                             children: [
//                                                               CustomTextField(
//                                                                   validator: (value) {
//                                                                     if (value!.isEmpty) {
//                                                                       return 'Please Enter department name';
//                                                                     }
//                                                                     return null;
//                                                                   },
//                                                                   textInputAction: TextInputAction.next,
//                                                                   obscure: false,
//                                                                   controller: controller.departmentNameController,
//                                                                   label: "Department Name")
//                                                             ],
//                                                             title: "Edit Your Department",
//                                                             onCancelPressed: () {
//                                                               Get.back();
//                                                               controller.departmentNameController.clear();
//                                                             },
//                                                             onUpdatePressed: () {
//                                                               if (formkey.currentState!.validate()) {
//                                                                 print('pressed button entering to controller');
//                                                                 controller.editDepartmentDetails(
//                                                                     id: controller.department_items[index].id ?? 0, delete: controller.department_items[index].deleted ?? '');
//                                                                 Get.back();

//                                                                 controller.departmentNameController.clear();
//                                                               } else {
//                                                                 print("not validated");
//                                                               }
//                                                             },
//                                                             saveButtonText: "Edit"));
//                                                   },
//                                                 );
//                                               },
//                                               icon: Icon(
//                                                 Icons.edit,
//                                                 size: 20,
//                                                 color: kColorlightBlue,
//                                               ),
//                                             ),
//                                           ),
//                                           // Add some space between icons
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Container(
//                                             height: 40,
//                                             width: 40,
//                                             decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30), boxShadow: kElevationToShadow[1]),
//                                             child: IconButton(
//                                               onPressed: () {
//                                                 print(items.id);
//                                                 customDeleteAlertDialogue(context, () {
//                                                   controller.deleteDepartmentDetails(items.id);
//                                                   Get.back();
//                                                 });
//                                                 // controller.deleteCountryDetails(items.id);
//                                               },
//                                               icon: Icon(
//                                                 Icons.delete,
//                                                 color: kColorRed,
//                                                 size: 20,
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       );
//               },
//             ),
//           ),
//           Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 color: Colors.white,
//                 width: double.infinity,
//                 child: Center(
//                   child: GestureDetector(
//                       onTap: () {
//                         showDialog(
//                           context: context,
//                           builder: (context) {
//                             return Form(
//                                 key: formkey,
//                                 child: CustomPopup(
//                                     children: [
//                                       CustomTextField(
//                                           validator: (value) {
//                                             if (value!.isEmpty) {
//                                               return 'Please Enter department name';
//                                             }
//                                             return null;
//                                           },
//                                           textInputAction: TextInputAction.next,
//                                           obscure: false,
//                                           controller: controller.departmentNameController,
//                                           label: 'Department Name'),
//                                     ],
//                                     title: 'Add Your Department',
//                                     onCancelPressed: () {
//                                       Get.back();
//                                       controller.departmentNameController.clear();
//                                     },
//                                     onUpdatePressed: () {
//                                       if (formkey.currentState!.validate()) {
//                                         controller.postDepartmentnDetails();
//                                       } else {
//                                         print("Not validated");
//                                       }
//                                     },
//                                     saveButtonText: "Add"));
//                           },
//                         );
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           width: 200,
//                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: kColorlightBlue),
//                           child: Padding(
//                             padding: const EdgeInsets.all(15),
//                             child: Text(
//                               'Add Department',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 20,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       )),
//                 ),
//               ))
//         ],
//       ),
//     );
//   }
// }
