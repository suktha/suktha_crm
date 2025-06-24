// import 'package:flutter/material.dart';
// import 'package:suktha/Controller/global_controller.dart';
// import 'package:flutter_swipe_action_cell/core/cell.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import 'package:suktha/Constants/colors.dart';
// import 'package:suktha/View/More%20Modules/screens/general_master/general_master_controller.dart';
// import 'package:suktha/View/More%20Modules/screens/general_master/general_master_screen.dart';
// import 'package:suktha/View/Widgets/custom_textfield.dart';
// import 'package:suktha/View/Widgets/deleteAlertDialogue.dart';

// class CustomerClassificationScreen extends StatelessWidget {
//   CustomerClassificationScreen({super.key});

//   final GeneralMasterController controller = Get.put(GeneralMasterController());
//   GlobalKey<FormState> formkey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(14.h),
//         child: AppBar(
//             title: const Text("Customer Classification"),
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
//             actions: [
//               IconButton(
//                   onPressed: () {
//                     controller.getLeadCategoryDetails();
//                   },
//                   icon: Icon(
//                     Icons.refresh,
//                     color: kColorblack,
//                   ))
//             ],
//             leading: IconButton(
//               icon: Icon(
//                 Icons.keyboard_arrow_left,
//                 color: kColorblack,
//                 size: 25.sp,
//               ),
//               onPressed: (() {
//                 controller.searchController.clear();

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
//                 return controller.searchResultCustomerClass.isEmpty
//                     ? Center(child: Text('No Result '))
//                     : ListView.builder(
//                         itemCount: controller.searchResultCustomerClass.length,
//                         physics: BouncingScrollPhysics(),
//                         // shrinkWrap: true,
//                         itemBuilder: (context, index) {
//                           var items = controller.searchResultCustomerClass[index];
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
//                                         controller.deleteDesignationDetails(items.id);
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
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       // controller.country_master_items[index].bankname=controller.bankNameController.text;

//                                       return AlertDialog(
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(20.0),
//                                           ),
//                                           title: Text('Edit your details'),
//                                           content: Form(
//                                             key: formkey,
//                                             child: Wrap(
//                                               children: [
//                                                 CustomTextField(
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return 'Please Enter designation name';
//                                                       }
//                                                       return null;
//                                                     },
//                                                     textInputAction: TextInputAction.next,
//                                                     obscure: false,
//                                                     controller: controller.designationNameController,
//                                                     label: controller.designation_items[index].designationName),
//                                               ],
//                                             ),
//                                           ),
//                                           actions: [
//                                             Padding(
//                                               padding: const EdgeInsets.only(top: 20, bottom: 20),
//                                               child: Row(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                 children: [
//                                                   ElevatedButton(
//                                                       onPressed: () {
//                                                         Get.back();
//                                                         controller.designationNameController.clear();
//                                                       },
//                                                       child: Text('   Cancel   ')),
//                                                   ElevatedButton(
//                                                       onPressed: () {
//                                                         if (formkey.currentState!.validate()) {
//                                                           print('pressed button entering to controller');
//                                                           controller.editDesignationDetails(
//                                                               id: controller.designation_items[index].id ?? 0,
//                                                               delete: controller.designation_items[index].deleted ?? '');
//                                                           Get.back();

//                                                           controller.designationNameController.clear();
//                                                         } else {
//                                                           print("not validated");
//                                                         }
//                                                       },
//                                                       child: Text('     Edit      '))
//                                                 ],
//                                               ),
//                                             )
//                                           ]);
//                                     },
//                                   );
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: Colors.grey[50],
//                                       boxShadow: kElevationToShadow[1],
//                                       border: Border.all(color: kColorlightBlue, width: 2)),
//                                   // height: 40,
//                                   child: ListTile(
//                                     title: Padding(
//                                       padding: const EdgeInsets.only(top: 20, bottom: 20),
//                                       child: Text(items.name),
//                                     ),
//                                     trailing: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         IconButton(
//                                           onPressed: () {
//                                             showDialog(
//                                               context: context,
//                                               builder: (context) {
//                                                 // controller.country_master_items[index].bankname=controller.bankNameController.text;

//                                                 return AlertDialog(
//                                                     shape: RoundedRectangleBorder(
//                                                       borderRadius: BorderRadius.circular(20.0),
//                                                     ),
//                                                     title: Text('Edit your details'),
//                                                     content: Form(
//                                                       key: formkey,
//                                                       child: Wrap(
//                                                         children: [
//                                                           CustomTextField(
//                                                               validator: (value) {
//                                                                 if (value!.isEmpty) {
//                                                                   return 'Please Enter designation name';
//                                                                 }
//                                                                 return null;
//                                                               },
//                                                               textInputAction: TextInputAction.next,
//                                                               obscure: false,
//                                                               controller: controller.designationNameController,
//                                                               label: controller.designation_items[index].designationName),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     actions: [
//                                                       Padding(
//                                                         padding: const EdgeInsets.only(top: 20, bottom: 20),
//                                                         child: Row(
//                                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                           children: [
//                                                             ElevatedButton(
//                                                                 onPressed: () {
//                                                                   Get.back();
//                                                                   controller.designationNameController.clear();
//                                                                 },
//                                                                 child: Text('   Cancel   ')),
//                                                             ElevatedButton(
//                                                                 onPressed: () {
//                                                                   if (formkey.currentState!.validate()) {
//                                                                     print('pressed button entering to controller');
//                                                                     controller.editDesignationDetails(
//                                                                         id: controller.designation_items[index].id ?? 0,
//                                                                         delete: controller.designation_items[index].deleted ?? '');
//                                                                     Get.back();

//                                                                     controller.designationNameController.clear();
//                                                                   } else {
//                                                                     print("not validated");
//                                                                   }
//                                                                 },
//                                                                 child: Text('     Edit      '))
//                                                           ],
//                                                         ),
//                                                       )
//                                                     ]);
//                                               },
//                                             );
//                                           },
//                                           icon: Icon(Icons.edit),
//                                         ),
//                                         // Add some space between icons
//                                         IconButton(
//                                           onPressed: () {
//                                             print(items.id);
//                                             customDeleteAlertDialogue(context, () {
//                                               controller.deleteDesignationDetails(items.id);
//                                               Get.back();
//                                             });
//                                             // controller.deleteCountryDetails(items.id);
//                                           },
//                                           icon: Icon(Icons.delete),
//                                         )
//                                       ],
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
//                             context: context,
//                             builder: (context) {
//                               return AlertDialog(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20.0),
//                                 ),
//                                 title: Text('Add your Designation'),
//                                 content: Form(
//                                   key: formkey,
//                                   child: Wrap(
//                                     children: [
//                                       CustomTextField(
//                                           validator: (value) {
//                                             if (value!.isEmpty) {
//                                               return 'Please Enter designation name';
//                                             }
//                                             return null;
//                                           },
//                                           textInputAction: TextInputAction.next,
//                                           obscure: false,
//                                           controller: controller.designationNameController,
//                                           label: 'Designation Name'),
//                                     ],
//                                   ),
//                                 ),
//                                 actions: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       ElevatedButton(
//                                           onPressed: () {
//                                             Get.back();
//                                             controller.designationNameController.clear();
//                                           },
//                                           child: Text('   Cancel   ')),
//                                       ElevatedButton(
//                                           onPressed: () {
//                                             if (formkey.currentState!.validate()) {
//                                               controller.postDesignationDetails();
//                                             } else {
//                                               print("Not validated");
//                                             }
//                                           },
//                                           child: Text('     Add      '))
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 15,
//                                   )
//                                 ],
//                               );
//                             });
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           width: 200,
//                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: kColorlightBlue),
//                           child: Padding(
//                             padding: const EdgeInsets.all(15),
//                             child: Text(
//                               'Add ',
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
