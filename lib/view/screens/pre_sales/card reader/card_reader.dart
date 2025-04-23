// import 'dart:async';
// import 'dart:developer';
// import 'dart:io';
// import 'package:animate_do/animate_do.dart';
// // import 'package:contacts_service/contacts_service.dart';
// import 'package:flutter/material.dart';
// import 'package:suktha/Controller/global_controller.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:get/get.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lottie/lottie.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:sizer/sizer.dart';
// import 'package:suktha/Constants/colors.dart';
// import 'package:suktha/Constants/images.dart';
// import 'package:suktha/Controller/lead_controller.dart';
// import 'package:suktha/View/Modules/Transactions/pre%20sales/pre%20sale%20items/card%20reader/MlkitText.dart';
// import 'package:suktha/View/Modules/Transactions/pre%20sales/pre%20sale%20items/card%20reader/RecognitionResponse.dart';
// import 'package:suktha/View/Modules/Transactions/pre%20sales/pre_sale_screen.dart';
// import 'package:suktha/View/Widgets/custom_button.dart';
// import 'package:suktha/View/Widgets/custom_textfield.dart';
// import 'package:suktha/View/Widgets/snackbar.dart';
// import 'package:suktha_crm/Constants/colors.dart';
// import 'package:suktha_crm/Constants/images.dart';
// import 'package:suktha_crm/controllers/lead_controller.dart';
// import 'package:suktha_crm/view/screens/pre_sales/card%20reader/MlkitText.dart';
// import 'package:suktha_crm/view/screens/pre_sales/card%20reader/RecognitionResponse.dart';
// import 'package:suktha_crm/view/screens/pre_sales/pre_sale_screen.dart';
// import 'package:suktha_crm/view/widget/snackbar.dart';

// class CardScannerScreen extends StatefulWidget {
//   const CardScannerScreen({super.key});

//   @override
//   State<CardScannerScreen> createState() => _CardScannerScreenState();
// }

// class _CardScannerScreenState extends State<CardScannerScreen> {
//   late ImagePicker _picker;
//   late ITextRecognizer _recognizer;
//   RecognitionResponse? _response;

//   final controller = Get.put(LeadController());

//   var numberField;
//   List<String> phoneNumbers = [];
//   Set<String> nameList = Set();
//   Set<String> designationList = Set();
//   Set<String> companyNameList = Set();
//   // List to store phone numbers

//   @override
//   void initState() {
//     super.initState();
//     _picker = ImagePicker();
//     _recognizer = MLkitTextRecognizer();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     if (_recognizer is MLkitTextRecognizer) {
//       (_recognizer as MLkitTextRecognizer).dispose();
//     }
//   }

//   Future<String?> obtainImage(ImageSource source) async {
//     final file = await _picker.pickImage(
//       source: source,
//     );

//     if (file != null) {
//       var croppedImgae = await _cropImage(File(file.path));
//       return croppedImgae;
//     }
//     return null;
//   }

//   Future<String> _cropImage(File imageFile) async {
//     var croppedImgae = await ImageCropper().cropImage(
//         sourcePath: imageFile.path,
//         aspectRatio: CropAspectRatio(ratioX: 85, ratioY: 54), // Credit card aspect ratio
//         compressQuality: 100,
//         uiSettings: [
//           AndroidUiSettings(toolbarTitle: 'Cropper', toolbarColor: kColorlightBlue, toolbarWidgetColor: Colors.white, initAspectRatio: CropAspectRatioPreset.original, lockAspectRatio: false),
//           IOSUiSettings(
//             title: 'Cropper',
//           ),
//           WebUiSettings(
//             context: context,
//           ),
//         ]);

//     if (croppedImgae!.path.isNotEmpty) {
//       print("Okay");
//       controller.isStartExtractingText.value = true;
//     }

//     return croppedImgae.path;
//   }

//   void processImage(String imgPath) async {
//     final recognizedText = await _recognizer.processImage(imgPath);

//     setState(() {
//       _response = RecognitionResponse(imgPath: imgPath, recognizedText: recognizedText.text);

//       log(recognizedText.text);

//       phoneNumbers.clear();
//       nameList.clear();
//       designationList.clear();
//       controller.nameController.clear();
//       controller.designationController.clear();
//       controller.companyNameController.clear();
//       controller.addressController.clear();
//       controller.contactNumberController.clear();
//       controller.emailController.clear();
//       controller.websiteController.clear();

//       for (TextBlock block in recognizedText.blocks) {
//         for (TextLine line in block.lines) {
//           categorizeAndAssignFields(line.text, block.text);

//           Timer(Duration(seconds: 1), () {
//             controller.isExtractionCompleted.value = true;
//           });
//         }
//       }

//       if (designationList.isNotEmpty && designationList.length <= 1) {
//         controller.designationController.text = designationList.join(', ');
//       }
//       if (nameList.isNotEmpty && nameList.length <= 1) {
//         controller.designationController.text = nameList.join(', ');
//       }
//     });
//   }

//   void categorizeAndAssignFields(String textLine, String blockText) {
//     final numberRegex = RegExp(r'\b(?:\+?\d{1,3}\s*)?[0-9\s\-]{9,}\b');
//     final emailRegex = RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b');
//     final websiteRegex = RegExp(r'^www\.[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
//     final addressRegex = RegExp(r'.*,.*');
//     final nameRegex = RegExp(r'^(?!.*(?:limited|private|ltd|pvt))[A-Za-z\s]+$', caseSensitive: false);
//     final designationRegex = RegExp(r'^(?!.*\b(?:limited|private|ltd|pvt)\b)[&a-zA-Z0-9\- ()]*$', caseSensitive: false);
//     RegExp companyName = RegExp(r'\b(?:limited|private|ltd|pvt)\b', caseSensitive: false);

//     if (numberRegex.hasMatch(textLine)) {
//       print("number - " + textLine);
//       // Iterable<RegExpMatch> matches = numberRegex.allMatches(textLine);
//       // List<String> numbers = matches.map((match) => match.group(0)!).toList();

//       // phoneNumbers.addAll(numbers);
//       // print(phoneNumbers.toString());

//       controller.contactNumberController.text = textLine;
//     } else if (emailRegex.hasMatch(textLine)) {
//       Iterable<RegExpMatch> matches = emailRegex.allMatches(textLine);
//       List<String> emails = matches.map((match) => match.group(0)!).toList();

//       controller.emailController.text = emails.join(', ');
//     } else if (websiteRegex.hasMatch(textLine)) {
//       controller.websiteController.text = textLine;
//     } else if (addressRegex.hasMatch(blockText)) {
//       controller.addressController.text = blockText;
//     } else if (nameRegex.hasMatch(textLine)) {
//       Iterable<RegExpMatch> matches = nameRegex.allMatches(textLine);
//       Set<String> name = matches.map((match) => match.group(0)!).toSet();
//       print("name -" + name.toString());

//       nameList.addAll(name);
//     } else if (designationRegex.hasMatch(textLine)) {
//       Iterable<RegExpMatch> matches = designationRegex.allMatches(textLine);
//       Set<String> designation = matches.map((match) => match.group(0)!).toSet();

//       print("designation -" + designation.toString());
//       designationList.addAll(designation);
//     } else if (companyName.hasMatch(textLine)) {
//       // Iterable<RegExpMatch> matches = companyName.allMatches(textLine);
//       // Set<String> comapanyname = matches.map((match) => match.group(0)!).toSet();

//       print("company -" + textLine.toString());

//       controller.companyNameController.text = textLine;
//       // companyNameList.addAll(textLine);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
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
//                 Get.to(() => PreSaleScreen(), transition: Transition.fade, duration: Duration(milliseconds: 600));
//                 controller.isExtractionCompleted.value = false;
//                 controller.isStartExtractingText.value = false;
//               }),
//             )),
//         body: Obx(() {
//           return AnimatedSwitcher(duration: Duration(milliseconds: 600), child: bodyWidget());
//         }));
//   }

//   Widget bodyWidget() {
//     if (controller.isStartExtractingText.value) {
//       return AnimatedSwitcher(
//         duration: Duration(milliseconds: 600),
//         child: controller.isExtractionCompleted.value == false
//             ? Container(
//                 child: Column(
//                 children: [
//                   Lottie.asset(
//                     scanTextLottie,
//                   ),
//                   Text("Extracting Details From Image")
//                 ],
//               ))
//             : Padding(
//                 padding: EdgeInsets.all(2.w),
//                 child: Column(
//                   children: [
//                     Center(child: Text("Business Card Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp))),
//                     SizedBox(
//                       height: 2.h,
//                     ),
//                     Expanded(
//                       child: ListView(
//                         physics: BouncingScrollPhysics(),
//                         children: [
//                           FadeIn(
//                             duration: Duration(milliseconds: 300),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 GestureDetector(
//                                   onTap: () {
//                                     showDialog(
//                                       context: context,
//                                       builder: (context) {
//                                         return AlertDialog(
//                                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.w))),
//                                           title: Text('Upload the Card!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                                           content: SizedBox(
//                                             width: 100.w,
//                                             child: Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                               children: [
//                                                 GestureDetector(
//                                                   onTap: () async {
//                                                     final imgPath = await obtainImage(ImageSource.gallery);

//                                                     Get.back();
//                                                     if (imgPath != null) {
//                                                       processImage(imgPath);
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     height: 6.h,
//                                                     width: 30.w,
//                                                     decoration: BoxDecoration(color: kColorlightBlue, borderRadius: BorderRadius.circular(5.w)),
//                                                     child: Center(
//                                                         child: Text(
//                                                       "Gallery",
//                                                       style: TextStyle(fontWeight: FontWeight.bold, color: kColorwhite),
//                                                     )),
//                                                   ),
//                                                 ),
//                                                 GestureDetector(
//                                                   onTap: () async {
//                                                     final imgPath = await obtainImage(ImageSource.camera);
//                                                     Get.back();

//                                                     if (imgPath != null) {
//                                                       processImage(imgPath);
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     height: 6.h,
//                                                     width: 30.w,
//                                                     decoration: BoxDecoration(color: kColorlightBlue, borderRadius: BorderRadius.circular(5.w)),
//                                                     child: Center(
//                                                         child: Text(
//                                                       "Camera",
//                                                       style: TextStyle(fontWeight: FontWeight.bold, color: kColorwhite),
//                                                     )),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                     );
//                                   },
//                                   child: Container(
//                                     height: 23.h,
//                                     width: 80.w,
//                                     decoration: BoxDecoration(
//                                       color: kColorwhite,
//                                       boxShadow: kElevationToShadow[2],
//                                       borderRadius: BorderRadius.circular(2.w),
//                                       image: _response?.imgPath != null
//                                           ? DecorationImage(
//                                               image: FileImage(File(_response!.imgPath)),
//                                               fit: BoxFit.cover,
//                                             )
//                                           : null,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 3.h,
//                           ),
//                           FadeIn(
//                             duration: Duration(milliseconds: 400),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 GestureDetector(
//                                   onTap: () async {
//                                     controller.extractedTextController.text = _response!.recognizedText;

//                                     showDialog(
//                                       context: context,
//                                       builder: (context) {
//                                         return AlertDialog(
//                                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.w))),
//                                           title: Text('Extracted Text', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                                           content: SizedBox(
//                                             // height: 20.h,
//                                             width: 100.w,
//                                             child: TextField(
//                                               maxLines: null,
//                                               controller: controller.extractedTextController,
//                                               decoration: InputDecoration(label: Text("Select Text"), border: OutlineInputBorder(borderRadius: BorderRadius.circular(3.w))),
//                                             ),
//                                           ),
//                                           actions: [
//                                             TextButton(
//                                                 onPressed: () {
//                                                   Clipboard.setData(
//                                                     ClipboardData(text: _response!.recognizedText),
//                                                   );

//                                                   Get.back();
//                                                   customSnackbar("Text Copied", "", "normal");
//                                                 },
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.center,
//                                                   children: [
//                                                     Text("Copy All Text"),
//                                                     SizedBox(
//                                                       width: 2.w,
//                                                     ),
//                                                     Icon(Icons.copy)
//                                                   ],
//                                                 ))
//                                           ],
//                                         );
//                                       },
//                                     );
//                                   },
//                                   child: Container(
//                                     padding: EdgeInsets.all(3.w),
//                                     decoration: BoxDecoration(boxShadow: kElevationToShadow[2], color: kColorlightBlue300, borderRadius: BorderRadius.circular(4.w)),
//                                     child: Center(
//                                         child: Row(
//                                       children: [
//                                         Text("Copy Text", style: TextStyle(fontWeight: FontWeight.bold, color: kColorwhite)),
//                                         SizedBox(
//                                           width: 2.w,
//                                         ),
//                                         Icon(
//                                           Icons.copy,
//                                           color: kColorwhite,
//                                         )
//                                       ],
//                                     )),
//                                   ),
//                                 ),
//                                 GestureDetector(
//                                   onTap: () async {
//                                     showDialog(
//                                       context: context,
//                                       builder: (context) {
//                                         return AlertDialog(
//                                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.w))),
//                                           title: Text('Upload the Card!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                                           content: SizedBox(
//                                             width: 100.w,
//                                             child: Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                               children: [
//                                                 GestureDetector(
//                                                   onTap: () async {
//                                                     final imgPath = await obtainImage(ImageSource.gallery);

//                                                     Get.back();
//                                                     if (imgPath != null) {
//                                                       processImage(imgPath);
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     height: 6.h,
//                                                     width: 30.w,
//                                                     decoration: BoxDecoration(color: kColorlightBlue, borderRadius: BorderRadius.circular(5.w)),
//                                                     child: Center(
//                                                         child: Text(
//                                                       "Gallery",
//                                                       style: TextStyle(fontWeight: FontWeight.bold, color: kColorwhite),
//                                                     )),
//                                                   ),
//                                                 ),
//                                                 GestureDetector(
//                                                   onTap: () async {
//                                                     final imgPath = await obtainImage(ImageSource.camera);
//                                                     Get.back();

//                                                     if (imgPath != null) {
//                                                       processImage(imgPath);
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     height: 6.h,
//                                                     width: 30.w,
//                                                     decoration: BoxDecoration(color: kColorlightBlue, borderRadius: BorderRadius.circular(5.w)),
//                                                     child: Center(
//                                                         child: Text(
//                                                       "Camera",
//                                                       style: TextStyle(fontWeight: FontWeight.bold, color: kColorwhite),
//                                                     )),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                     );
//                                   },
//                                   child: Container(
//                                     padding: EdgeInsets.all(3.w),
//                                     decoration: BoxDecoration(boxShadow: kElevationToShadow[2], color: kColorlightBlue300, borderRadius: BorderRadius.circular(4.w)),
//                                     child: Center(
//                                         child: Row(
//                                       children: [
//                                         Text("Change Image", style: TextStyle(fontWeight: FontWeight.bold, color: kColorwhite)),
//                                         SizedBox(
//                                           width: 2.w,
//                                         ),
//                                         Icon(
//                                           Icons.image,
//                                           color: kColorwhite,
//                                         )
//                                       ],
//                                     )),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 1.h,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 4.w),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: 2.w),
//                                   child: TypeAheadFormField(
//                                     textFieldConfiguration: TextFieldConfiguration(controller: controller.nameController, decoration: InputDecoration(label: Text("Name"))),
//                                     itemBuilder: (context, itemData) {
//                                       return ListTile(
//                                         title: Text(itemData),
//                                       );
//                                     },
//                                     suggestionsCallback: (pattern) {
//                                       return nameList;
//                                     },
//                                     onSuggestionSelected: (suggestion) {
//                                       controller.nameController.text = suggestion;
//                                     },
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: 2.w),
//                                   child: TypeAheadFormField(
//                                     textFieldConfiguration: TextFieldConfiguration(controller: controller.designationController, decoration: InputDecoration(label: Text("Designation"))),
//                                     itemBuilder: (context, itemData) {
//                                       return ListTile(
//                                         title: Text(itemData),
//                                       );
//                                     },
//                                     suggestionsCallback: (pattern) {
//                                       return designationList;
//                                     },
//                                     onSuggestionSelected: (suggestion) {
//                                       controller.designationController.text = suggestion;
//                                     },
//                                   ),
//                                 ),
//                                 FadeIn(
//                                   duration: Duration(milliseconds: 700),
//                                   child: CustomTextField(
//                                       validator: (value) {
//                                         return null;
//                                       },
//                                       textInputAction: TextInputAction.next,
//                                       obscure: false,
//                                       controller: controller.companyNameController,
//                                       label: "Company Name"),
//                                 ),
//                                 FadeIn(
//                                   duration: Duration(milliseconds: 800),
//                                   child: CustomTextField(
//                                       validator: (value) {
//                                         return null;
//                                       },
//                                       textInputAction: TextInputAction.next,
//                                       obscure: false,
//                                       multilines: null,
//                                       controller: controller.addressController,
//                                       label: "Address"),
//                                 ),
//                                 FadeIn(
//                                   duration: Duration(milliseconds: 900),
//                                   child: CustomTextField(
//                                       validator: (value) {
//                                         return null;
//                                       },
//                                       textInputAction: TextInputAction.next,
//                                       obscure: false,
//                                       controller: controller.contactNumberController,
//                                       label: "Contact Number"),
//                                 ),
//                                 FadeIn(
//                                   duration: Duration(milliseconds: 1000),
//                                   child: CustomTextField(
//                                       validator: (value) {
//                                         return null;
//                                       },
//                                       textInputAction: TextInputAction.next,
//                                       obscure: false,
//                                       controller: controller.emailController,
//                                       label: "Email"),
//                                 ),
//                                 FadeIn(
//                                   duration: Duration(milliseconds: 1100),
//                                   child: CustomTextField(
//                                       validator: (value) {
//                                         return null;
//                                       },
//                                       textInputAction: TextInputAction.next,
//                                       obscure: false,
//                                       controller: controller.websiteController,
//                                       label: "Webiste"),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Center(
//                     //   child: CustomButton(
//                     //     width: 50.w,
//                     //     title: "Add to Contacts",
//                     //     textcolor: kColorwhite,
//                     //     ontap: () async {
//                     //       // addContact();
//                     //     },
//                     //     color: kColorlightBlue500,
//                     //   ),
//                     // )
//                   ],
//                 ),
//               ),
//       );
//     }
//     return FadeIn(
//       duration: Duration(seconds: 1),
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
//         child: Column(
//           children: [
//             Lottie.asset(
//               businessCardLottie,
//             ),
//             // SizedBox(height: 4.h),s
//             Text(
//               "Upload Business card",
//               style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 3.h),

//             GestureDetector(
//               onTap: () async {
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.w))),
//                       title: Text('Upload the Card!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                       content: SizedBox(
//                         width: 100.w,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             GestureDetector(
//                               onTap: () async {
//                                 final imgPath = await obtainImage(ImageSource.gallery);

//                                 Get.back();
//                                 if (imgPath != null) {
//                                   processImage(imgPath);
//                                 }
//                               },
//                               child: Container(
//                                 height: 6.h,
//                                 width: 30.w,
//                                 decoration: BoxDecoration(color: kColorlightBlue, borderRadius: BorderRadius.circular(5.w)),
//                                 child: Center(
//                                     child: Text(
//                                   "Gallery",
//                                   style: TextStyle(fontWeight: FontWeight.bold, color: kColorwhite),
//                                 )),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () async {
//                                 final imgPath = await obtainImage(ImageSource.camera);
//                                 Get.back();

//                                 if (imgPath != null) {
//                                   processImage(imgPath);
//                                 }
//                               },
//                               child: Container(
//                                 height: 6.h,
//                                 width: 30.w,
//                                 decoration: BoxDecoration(color: kColorlightBlue, borderRadius: BorderRadius.circular(5.w)),
//                                 child: Center(
//                                     child: Text(
//                                   "Camera",
//                                   style: TextStyle(fontWeight: FontWeight.bold, color: kColorwhite),
//                                 )),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//               child: Container(
//                 height: 6.h,
//                 width: 35.w,
//                 decoration: BoxDecoration(color: kColorlightBlue, borderRadius: BorderRadius.circular(5.w)),
//                 child: Center(
//                     child: Text(
//                   "Upload",
//                   style: TextStyle(fontWeight: FontWeight.bold, color: kColorwhite),
//                 )),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Future<void> addContact() async {
//   //   try {
//   //     // Check and request contacts permission if not granted
//   //     PermissionStatus permission = await Permission.contacts.status;
//   //     if (permission != PermissionStatus.granted) {
//   //       print("Contacts permission not granted. Requesting...");
//   //       await Permission.contacts.request();
//   //       PermissionStatus newPermission = await Permission.contacts.status;

//   //       if (newPermission == PermissionStatus.granted) {
//   //         print("Contacts permission granted. Adding contact...");
//   //         // Continue with contact creation logic
//   //         Contact newContact = Contact(
//   //           givenName: controller.nameController.text,
//   //           familyName: "",
//   //           phones: [
//   //             Item(
//   //               label: 'mobile',
//   //               value: controller.contactNumberController.text,
//   //             )
//   //           ],
//   //         );
//   //         await ContactsService.addContact(newContact);

//   //         customSnackbar("Contact Saved", "Contact Successfully Saved", "success");
//   //         print("Contact added successfully.");
//   //       } else {
//   //         print("Contacts permission still not granted.");
//   //       }
//   //     } else {
//   //       print("Contacts permission already granted. Adding contact...");
//   //       // Continue with contact creation logic
//   //       Contact newContact = Contact(
//   //         givenName: controller.nameController.text,
//   //         familyName: "",
//   //         phones: [
//   //           Item(
//   //             label: 'mobile',
//   //             value: controller.contactNumberController.text,
//   //           )
//   //         ],
//   //       );
//   //       await ContactsService.addContact(newContact);
//   //       customSnackbar("Contact Saved", "Contact Successfully Saved", "success");
//   //       print("Contact added successfully.");
//   //     }
//   //   } catch (e) {
//   //     print("Error adding contact: $e");
//   //     // Handle any exceptions that may occur during the process
//   //   }
//   // }
// }

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

abstract class ITextRecognizer {
  Future<RecognizedText> processImage(String imgPath);
}
