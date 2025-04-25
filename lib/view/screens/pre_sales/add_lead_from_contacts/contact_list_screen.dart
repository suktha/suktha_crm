import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:suktha_crm/Constants/colors.dart';
import 'package:suktha_crm/Constants/images.dart';
import 'package:suktha_crm/Model/lead_model.dart';
import 'package:suktha_crm/Model/material_models.dart';
import 'package:suktha_crm/controllers/lead_contact_details_controller.dart';
import 'package:suktha_crm/view/bottom_navigation/bottom_navigation_mainscreen.dart';
import 'package:suktha_crm/view/screens/pre_sales/add_lead_from_contacts/selected_contact_screen.dart';
import 'package:suktha_crm/view/screens/pre_sales/lead_managment/view_lead_managment/view_lead_management.dart';
import 'package:suktha_crm/view/widget/shimmer_loading.dart';

class ContactListScreen extends StatefulWidget {
  final List<MaterialModel>? materialList;
  final List<MaterialModel>? serviceList;
  bool? isFromHomeScreen;

  ContactListScreen({super.key, this.materialList, this.serviceList, this.isFromHomeScreen});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final contactController = Get.put(LeadContactDetaisController());

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact List"),
        titleTextStyle: TextStyle(color: kColorblack, fontWeight: FontWeight.bold, fontSize: 19.sp),
        backgroundColor: kColorwhite,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (contactController.isSearchClicked.value == false) {
                    contactController.isSearchClicked.value = true;
                  } else if (contactController.isSearchClicked.value == true) {
                    contactController.searchController.clear();

                    contactController.isSearchClicked.value = false;
                  }
                });
              },
              icon: Icon(
                Icons.search,
                color: kColorblack,
              )),
          IconButton(
              onPressed: () async {
                List<LeadModel> leadData = [];

                for (int i = 0; i < contactController.selectedContacts.length; i++) {
                  bool alreadyExists = contactController.leadList.any((lead) => lead.leadName == contactController.contactNames[i] && lead.mobileNo == contactController.contactNumbers[i]);

                  print("Inside");
                  if (!alreadyExists) {
                    leadData.add(
                      LeadModel(leadName: contactController.contactNames[i], mobileNo: contactController.contactNumbers[i], quickLead: 1, isExistingCustomer: null),
                    );
                  }
                }

                contactController.leadList.addAll(leadData);

                print("leaddddd----$leadData");
                print('Leads Added: ${contactController.leadList.length}');
                contactController.leadList.forEach((lead) {
                  print(lead.toJson());
                  print('Name: ${lead.leadName}, Phone: ${lead.mobileNo},quick Lead: ${lead.quickLead}');
                });

                Get.to(
                  () => ShowSelectedContactsScreen(
                    contactController: contactController,
                    materialList: widget.materialList,
                    serviceList: widget.serviceList,
                  ),
                );
              },
              icon: Icon(
                Icons.check,
                color: kColorblack,
              ))
        ],
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: kColorblack,
            size: 25.sp,
          ),
          onPressed: (() {
            contactController.leadList.clear();
            contactController.selectedContacts.clear();

            contactController.contactNames.clear();
            contactController.contactNumbers.clear();
            contactController.isListLoading.value = true;

            widget.isFromHomeScreen == true ? Get.offAll(() => const BottomNavigationMainscreen(initialIndex: 1)) : Get.offAll(() => LeadManagementListScreen());
            // Get.to(() => LeadManagementListScreen());
          }),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          contactController.isSearchClicked == true
              ? FadeInRightBig(
                  duration: Durations.long2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 15, right: 15),
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: contactController.searchController,
                              onChanged: (value) {
                                contactController.filterContact(value);
                              },
                              decoration: InputDecoration(
                                hintText: 'Search Contacts',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                hintStyle: TextStyle(color: kColorgrey),
                                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: kColorLightGrey),
            child: Obx(() => Padding(
                  padding: const EdgeInsets.only(left: 19.0, right: 15, top: 10, bottom: 10),
                  child: Text(
                    contactController.selectedContacts.length <= 1 ? "${contactController.selectedContacts.length} Contact selected" : "${contactController.selectedContacts.length} Contacts selected",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                )),
          ),
          // contactController.selectedContacts.length == 0
          //     ? SizedBox()
          //     : Container(
          //         width: double.infinity,
          //         decoration: BoxDecoration(color: Colors.green.shade300),
          //         child: Padding(
          //           padding: const EdgeInsets.only(left: 19.0, right: 15, top: 5, bottom: 5),
          //           child: Text(
          //             "Please save the selected contacts",
          //             style: TextStyle(fontSize: 12.sp, color: kColorwhite),
          //           ),
          //         ),
          //       ),
          SizedBox(
            height: 3.h,
          ),
          Obx(
            () => contactController.isListLoading == true
                ? ListLoading()
                : contactController.filteredContacts.isEmpty
                    ? Expanded(
                        child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FadeIn(
                                delay: const Duration(milliseconds: 300),
                                duration: const Duration(milliseconds: 300),
                                child: LottieBuilder.asset(
                                  emptyLottie,
                                  height: 35.w,
                                )),
                            SizedBox(
                              height: 3.h,
                            ),
                            FadeIn(
                              delay: const Duration(milliseconds: 500),
                              duration: const Duration(milliseconds: 500),
                              child: Text(
                                "Your Contact List is Empty",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                              ),
                            )
                          ],
                        ),
                      ))
                    : Obx(() => Expanded(
                            child: ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: contactController.filteredContacts.length,
                          itemBuilder: (context, index) {
                            var contact = contactController.filteredContacts[index];
                            bool hasValidPhoneNumber = contact['phone'] != null && contact['phone']!.isNotEmpty && contact['phone']!.length >= 10;

                            // If the contact doesn't have a valid phone number, skip it
                            if (!hasValidPhoneNumber) {
                              return Container(); // Return an empty container if no valid phone number
                            }

                            return Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    setState(() {
                                      if (contactController.selectedContacts.contains(contact)) {
                                        contactController.selectedContacts.remove(contact);
                                        contactController.contactNames.remove(contact['name'] ?? "");
                                        contactController.contactNumbers.remove(contact['phone'] ?? "");
                                        contactController.isMandatoryFieldAdded[index] = false;
                                      } else {
                                        contactController.selectedContacts.add(contact);
                                        contactController.contactNames.add(contact['name'] ?? "");
                                        contactController.contactNumbers.add(contact['phone'] ?? "");
                                      }

                                      // Debugging
                                      print("Selected Names: ${contactController.contactNames}");
                                      print("Selected Numbers: ${contactController.contactNumbers}");
                                    });
                                  },
                                  title: Text(contact['name'] ?? ""),
                                  // leading: contact.avatar!.isEmpty
                                  //     ? Container(
                                  //         height: 60,
                                  //         width: 60,
                                  //         decoration: BoxDecoration(color: kColorgreyShade300, border: Border.all(color: kColorgreyShade300), borderRadius: BorderRadius.circular(100)),
                                  //         child: ClipRRect(
                                  //             borderRadius: BorderRadius.circular(50),
                                  //             child: Icon(
                                  //               Icons.person_pin,
                                  //               size: 13.w,
                                  //               color: kColorwhite,
                                  //             )),
                                  //       )
                                  //     : Container(
                                  //         height: 60,
                                  //         width: 60,
                                  //         child: ClipRRect(
                                  //           borderRadius: BorderRadius.circular(50),
                                  //           child: Image.memory(
                                  //             contact.avatar!,
                                  //             fit: BoxFit.cover,
                                  //           ),
                                  //         ),
                                  //       ),
                                  trailing: Checkbox(
                                    value: contactController.selectedContacts.contains(contact),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        if (contactController.selectedContacts.contains(contact)) {
                                          contactController.selectedContacts.remove(contact);
                                          contactController.contactNames.remove(contact['name'] ?? "");
                                          contactController.contactNumbers.remove(contact['phone'] ?? "");
                                        } else {
                                          contactController.selectedContacts.add(contact);
                                          contactController.contactNames.add(contact['name'] ?? "");
                                          contactController.contactNumbers.add(contact['phone'] ?? "");
                                        }

                                        // Debugging
                                        print("Selected Names: ${contactController.contactNames}");
                                        print("Selected Numbers: ${contactController.contactNumbers}");
                                      });
                                    },
                                  ),
                                ),
                                Divider()
                              ],
                            );
                          },
                        ))),
          )
        ],
      ),
    );
  }
}
