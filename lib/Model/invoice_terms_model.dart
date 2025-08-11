class InvoiceTermsModel {
  String? paymentDueDate;
  String? termsAndCondition;
  String? eWayBill;
  String? modeOfDispatch;
  String? vehicleNumber;
  String? numberOfPackages;
  String? documentThrough;
  String? billToAddress;
  String? shipToAddressLine1;
  String? shipToAddressLine2;
  String? shippingPincode;
  String? shippingGstin;
  int? shippingStateId;
  int? shippingLocationId;
  String? finalDestination;
  String? flightNum;
  String? preCarrier;
  String? portOfLoading;
  String? portOfDischarge;
  String? countryOfOriginOfGoods;
  String? countryOfFinalDestination;

  InvoiceTermsModel({

    this.paymentDueDate,
    this.termsAndCondition,
    this.eWayBill,
    this.modeOfDispatch,
    this.vehicleNumber,
    this.numberOfPackages,
    this.documentThrough,
    this.billToAddress,
    this.shipToAddressLine1,
    this.shipToAddressLine2,
    this.shippingPincode,
    this.shippingGstin,
    this.shippingStateId,
    this.shippingLocationId,
    this.finalDestination,
    this.flightNum,
    this.preCarrier,
    this.portOfLoading,
    this.portOfDischarge,
    this.countryOfOriginOfGoods,
    this.countryOfFinalDestination,

});

  InvoiceTermsModel.fromJson(Map<String, dynamic> json) {
    paymentDueDate = json['paymentDueDate'] as String?;
    termsAndCondition = json['termsAndCondition'] as String?;
    eWayBill = json['eWayBill'] as String?;
    modeOfDispatch = json['modeOfDispatch'] as String?;
    vehicleNumber = json['vehicleNumber'] as String?;
    numberOfPackages = json['numberOfPackages'] as String?;
    documentThrough = json['documentThrough'] as String?;
    billToAddress = json['billToAddress'] as String?;
    shipToAddressLine1 = json['shipToAddressLine1'] as String?;
    shipToAddressLine2 = json['shipToAddressLine2'] as String?;
    shippingPincode = json['shippingPincode'] as String?;
    shippingGstin = json['shippingGstin'] as String?;
    shippingLocationId = json['shippingLocationId'] as int?;
    shippingStateId = json['shippingStateId'] as int?;
    finalDestination = json['finalDestination'] as String?;
    flightNum = json['flightNum'] as String?;
    preCarrier = json['preCarrier'] as String?;
    portOfLoading = json['portOfLoading'] as String?;
    portOfDischarge = json['portOfDischarge'] as String?;
    countryOfOriginOfGoods = json['vehicountryOfOriginOfGoodscleNumber'] as String?;
    countryOfFinalDestination = json['countryOfFinalDestination'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json["paymentDueDate"] = paymentDueDate;
    json["termsAndCondition"] = termsAndCondition;
    json["eWayBill"] = eWayBill;
    json["modeOfDispatch"] = modeOfDispatch;
    json["vehicleNumber"] = vehicleNumber;
    json["numberOfPackages"] = numberOfPackages;
    json["documentThrough"] = documentThrough;
    json["billToAddress"] = billToAddress;
    json["shipToAddressLine1"] = shipToAddressLine1;
    json["shipToAddressLine2"] = shipToAddressLine2;
    json["shippingPincode"] = shippingPincode;
    json["shippingGstin"] = shippingGstin;
    json["shippingLocationId"] = shippingLocationId;
    json["shippingStateId"] = shippingStateId;
    json["finalDestination"] = finalDestination;
    json["flightNum"] = flightNum;
    json["preCarrier"] = preCarrier;
    json["portOfLoading"] = portOfLoading;
    json["portOfDischarge"] = portOfDischarge;
    json["countryOfOriginOfGoods"] = countryOfOriginOfGoods;
    json["countryOfFinalDestination"] = countryOfFinalDestination;
    return json;
  }
}
