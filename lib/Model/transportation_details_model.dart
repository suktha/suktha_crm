class TransportationDetailsModel {
  String? eWayBill;
  String? personName;
  String? inspectedBy;
  String? modeOfDispatch;
  String? vehicleNumber;
  String? dispatchDate;
  String? totalPackages;
  String? dispatchTime;
  String? deliveryNote;
  String? termsAndCondition;

  TransportationDetailsModel({
    this.eWayBill,
    this.personName,
    this.inspectedBy,
    this.modeOfDispatch,
    this.vehicleNumber,
    this.dispatchDate,
    this.totalPackages,
    this.dispatchTime,
    this.deliveryNote,
    this.termsAndCondition,
  });

  TransportationDetailsModel.fromJson(Map<String, dynamic> json) {
    eWayBill = json['eWayBill'] as String?;
    personName = json['personName'] as String?;
    inspectedBy = json['inspectedBy'] as String?;
    modeOfDispatch = json['modeOfDispatch'] as String?;
    vehicleNumber = json['vehicleNumber'] as String?;
    dispatchDate = json['dispatchDate'] as String?;
    totalPackages = json['totalPackages'] as String?;
    dispatchTime = json['dispatchTime'] as String?;
    deliveryNote = json['deliveryNote'] as String?;
    termsAndCondition = json['termsAndCondition'] as String?;
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['eWayBill'] = eWayBill;

    json['personName'] = personName;
    json['inspectedBy'] = inspectedBy;
    json['modeOfDispatch'] = modeOfDispatch;
    json['vehicleNumber'] = vehicleNumber;
    json['dispatchDate'] = dispatchDate;
    json['totalPackages'] = totalPackages;
    json['dispatchTime'] = dispatchTime;
    json['deliveryNote'] = deliveryNote;
    json['termsAndCondition'] = termsAndCondition;

    return json;
  }
}
