// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:suktha_crm/Constants/colors.dart';
import 'package:suktha_crm/Model/lead_model.dart';
import 'package:suktha_crm/Model/material_models.dart';
import 'package:suktha_crm/controllers/lead_controller.dart';
import 'package:suktha_crm/validations/Date.dart';

import '../controller/get_location_controller.dart';

class LocationWidget extends StatefulWidget {
  final int? index;
  final List<LeadModel>? LeadValueList;
  LeadModel? leadValue;
  bool IsClikedLocation;
  final List<MaterialModel> materialList;
  final List<MaterialModel> serviceList;

  LocationWidget({super.key, this.index, this.LeadValueList, required this.leadValue, required this.IsClikedLocation, required this.materialList, required this.serviceList});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  final GetLocationController locationController = Get.put(GetLocationController());

  final leadController = Get.put(LeadController());

  @override
  void initState() {
    if (widget.IsClikedLocation) {
      assignFunction();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 60.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(top: 1.h, left: 3.w, right: 3.w, bottom: MediaQuery.of(context).viewInsets.bottom),
      margin: EdgeInsets.all(2.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                " Add Location",
                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    locationController.searchedAddress.value = "";
                    locationController.searchController.clear();
                    locationController.isSearchClicked.value = false;
                    locationController.isSaved.value = false;

                    Get.back();
                  },
                  icon: Icon(
                    Icons.close,
                    color: kColorblack45,
                  ))
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  height: 5.4.h,
                  child: TextField(
                    controller: locationController.searchController,
                    onChanged: (value) {
                      locationController.isSaved.value = false;
                      locationController.searchLocation(value);
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), hintText: 'Search location', hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 4.7.h,
                  decoration: BoxDecoration(boxShadow: kElevationToShadow[2], borderRadius: BorderRadius.circular(15), color: kColorlightBlue),
                  child: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: kColorwhite,
                      size: 23,
                    ),
                    onPressed: () {
                      print("tapped");
                      locationController.isSaved.value = false;
                      locationController.searchLocation(locationController.searchController.text);
                    },
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity, // Set the desired width
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                ),
                backgroundColor: kColorwhite,
                elevation: 5, // Adjust the shadow intensity as needed
              ).copyWith(
                elevation: ButtonStyleButton.allOrNull(5.0), // Box shadow
                shadowColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.5)), // Color of the shadow
              ),
              onPressed: () async {
                print("index---${widget.index}");
                locationController.searchedAddress.value = "";
                locationController.searchController.clear();
                locationController.isSearchClicked.value = false;

                await locationController.getCurrentLocation(widget.index, widget.LeadValueList);
                print(locationController.isSaved.value);
              },
              child: Text(
                'Get Current Location',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Obx(
            () {
              if (locationController.loading.value) {
                // Show loading indicator while fetching the data
                return CircularProgressIndicator();
              } else if (locationController.searchedAddress.value.isNotEmpty) {
                // Show the ListTile with the icon only if searchedAddress is not empty
                return Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: kColorLightGrey),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        var designation = locationController.searchResults[0];
                        locationController.openGoogleMaps(designation.latitude, designation.longitude);
                      },
                      title: Text(
                        locationController.searchedAddress.value,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      leading: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.indigo.shade600,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                // Return an empty container or another placeholder widget when there is no data
                return SizedBox(); // or Container() or any placeholder widget
              }
            },
          ),

          Expanded(
            flex: 6,
            child: SizedBox(),
          ),

          SizedBox(height: 10),
          Obx(
            () => locationController.isSearchClicked.value == true
                ? SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                        ),
                        // backgroundColor: kColorwhite,
                        elevation: 5, // Adjust the shadow intensity as needed
                      ).copyWith(
                        elevation: ButtonStyleButton.allOrNull(5.0), // Box shadow
                        shadowColor: WidgetStateProperty.all(Colors.grey.withOpacity(0.5)), // Color of the shadow
                      ),
                      onPressed: () async {
                        print("index---${widget.index}");
                        // var destination = locationController.searchedLocation.value;
                        Get.back();

                        leadController.UpdateLead(
                            isLeadGenEdit: false, leadvalues: widget.leadValue, latitude: locationController.latitudeController.text, longitude: locationController.longitudeController.text);
                        // locationController.addPositionByIndex(index!, destination!, LeadValueList);

                        locationController.searchedAddress.value = "";
                        locationController.searchController.clear();
                        locationController.isSearchClicked.value = false;
                      },
                      child: Text(
                        'Save Location',
                        style: TextStyle(fontSize: 4.w, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : SizedBox(),
          ),
          // Spacer(),
          Obx(
            () => locationController.isSaved.value == true
                ? SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                        ),
                        // backgroundColor: Colors.green,
                        elevation: 5, // Adjust the shadow intensity as needed
                      ).copyWith(
                        elevation: ButtonStyleButton.allOrNull(5.0), // Box shadow
                        shadowColor: WidgetStateProperty.all(Colors.grey.withOpacity(0.5)), // Color of the shadow
                      ),
                      onPressed: () async {
                        print("index---${widget.index}");
                        Get.back();
                        leadController.UpdateLead(
                            isLeadGenEdit: false, leadvalues: widget.leadValue, latitude: locationController.latitudeController.text, longitude: locationController.longitudeController.text);

                        locationController.searchedAddress.value = "";
                        locationController.searchController.clear();
                        locationController.isSaved.value = false;
                      },
                      child: Text(
                        'Save Current Location',
                        style: TextStyle(fontSize: 4.w, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : SizedBox(),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  assignFunction() async {
    leadController.addressController.text = widget.leadValue!.address ?? "";
    leadController.isNewcustomer.value = widget.leadValue!.isExistingCustomer == 0 ? true : false;
    leadController.leadGenerationNumController.text = widget.leadValue!.leadGenerationNumber ?? "";
    leadController.leadDateController.text = DateClass().showDate(widget.leadValue!.leadGenerationDate ?? "");
    leadController.leadDateController.text = DateClass().showDate(widget.leadValue!.leadGenerationDate ?? "");
    leadController.nameController.text = widget.leadValue!.leadName ?? "";
    leadController.contactPersonController.text = widget.leadValue!.contactPerson ?? "";
    leadController.mobileNoController.text = widget.leadValue!.mobileNo ?? "";
    leadController.emailController.text = widget.leadValue!.email ?? "";
    leadController.addressController.text = widget.leadValue!.address ?? "";

    leadController.followUpDateController.text = DateClass().showDate(widget.leadValue!.followUpDate ?? "");

    if (widget.leadValue!.followUpTime != null) {
      await leadController.getFollowUpTime();

      leadController.followUpTimeList.firstWhereOrNull((element) => element["id"] == widget.leadValue!.followUpTime)["time"];

      leadController.followUpTimecontroller.text = leadController.followUpTimeList.firstWhereOrNull((element) => element["id"] == widget.leadValue!.followUpTime)["time"];
    }
    leadController.amountController.text = widget.leadValue!.amount?.toString() ?? "";

    leadController.leadCommentsControler.text = widget.leadValue!.leadComments ?? "";
    leadController.userCommentsController.text = widget.leadValue!.userComments ?? "";

    //------ interested product ----
    // await controller.getMaterialsList();

    if (widget.leadValue!.interestedProductId != null && widget.leadValue!.interestedProductId!.isNotEmpty) {
      List interestedProductIds = widget.leadValue!.interestedProductId!.first.toString().split(',').map((id) => int.parse(id)).toList();
      leadController.selectedMaterialItem.clear();
      for (var item in widget.materialList) {
        if (interestedProductIds.contains(item.id)) {
          leadController.selectedMaterialItem.add(item);
        }
      }
      leadController.intrestedProductController.text = leadController.selectedMaterialItem.map((item) => item.name).join(', ');
    }

    print("interested ----------product----${leadController.intrestedProductController.text}");

    //------ interested service ----

    print("----int id -- ${widget.leadValue!.interestedServiceId!.length}");

    if (widget.leadValue!.interestedServiceId != null && widget.leadValue!.interestedServiceId!.where((id) => id.trim().isNotEmpty).isNotEmpty) {
      var interestedServiceId = widget.leadValue!.interestedServiceId!.first.split(',').map((id) => int.parse(id)).toList();
      leadController.selectedServiceItem.clear();
      for (var item in widget.serviceList) {
        if (interestedServiceId.contains(item.id)) {
          leadController.selectedServiceItem.add(item);
        }
      }
      leadController.intrestedServiceController.text = leadController.selectedServiceItem.map((item) => item.name).join(', ');
    }

    //

    await leadController.getStatusById();

    leadController.statusController.text = widget.leadValue!.statusName ?? "";
    leadController.selectedStatusValue.id = widget.leadValue!.statusId;

    print("status id -- ${leadController.selectedStatusValue.id}");

    //--asigned to
    if (widget.leadValue!.assignedToId != null) {
      await leadController.getUserList();

      leadController.selectedUserValue = leadController.userList.firstWhere((value) => value.id == widget.leadValue!.assignedToId);
      leadController.assignController.text = leadController.selectedUserValue.name ?? "";
    }

    //--source
    await leadController.getSourceList();
    leadController.selectedSourceValue = leadController.sourceList.firstWhere((value) => value.id == widget.leadValue!.sourceId);
    leadController.sourceController.text = leadController.selectedSourceValue.name ?? "";

    //- priority
    leadController.selectedPriorityValue = leadController.priorityList.firstWhere((value) => value.id == widget.leadValue!.priorityId);
    leadController.priorityController.text = leadController.selectedPriorityValue.name ?? "";
    //--conversionchance
    leadController.selectedConversionChanceValue = leadController.conversionChanceList.firstWhere((value) => value.id == widget.leadValue!.conversionChanceId);
    leadController.conversionChanceController.text = leadController.selectedConversionChanceValue.name ?? "";

    //--area'
    if (widget.leadValue!.areaId != null) {
      await leadController.getAreaList();

      leadController.selectedAreaValue = leadController.areaList.firstWhere((city) => city.id == widget.leadValue!.areaId);
      leadController.areaController.text = leadController.selectedAreaValue.name ?? "";
    }

    //--city
    await leadController.getCityList();
    widget.leadValue!.cityId == null ? null : leadController.selectedCityValue = leadController.cityList.firstWhere((value) => value.id == widget.leadValue!.cityId);
    leadController.cityController.text = leadController.selectedCityValue.name ?? "";

    //--state
    await leadController.getStateList();
    widget.leadValue!.stateId == null ? null : leadController.selectedStateValue = leadController.stateList.firstWhere((value) => value.id == widget.leadValue!.stateId);
    leadController.stateController.text = leadController.selectedStateValue.name ?? "";

    //--country
    await leadController.getCountryList();
    widget.leadValue!.countryId == null ? null : leadController.selectedCountryValue = leadController.countryList.firstWhere((value) => value.id == widget.leadValue!.countryId);
    leadController.countryController.text = leadController.selectedCountryValue.name ?? " ";
  }
}
