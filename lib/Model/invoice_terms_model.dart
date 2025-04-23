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
    json["paymentDueDate"] = this.paymentDueDate;
    json["termsAndCondition"] = this.termsAndCondition;
    json["eWayBill"] = this.eWayBill;
    json["modeOfDispatch"] = this.modeOfDispatch;
    json["vehicleNumber"] = this.vehicleNumber;
    json["numberOfPackages"] = this.numberOfPackages;
    json["documentThrough"] = this.documentThrough;
    json["billToAddress"] = this.billToAddress;
    json["shipToAddressLine1"] = this.shipToAddressLine1;
    json["shipToAddressLine2"] = this.shipToAddressLine2;
    json["shippingPincode"] = this.shippingPincode;
    json["shippingGstin"] = this.shippingGstin;
    json["shippingLocationId"] = this.shippingLocationId;
    json["shippingStateId"] = this.shippingStateId;
    json["finalDestination"] = this.finalDestination;
    json["flightNum"] = this.flightNum;
    json["preCarrier"] = this.preCarrier;
    json["portOfLoading"] = this.portOfLoading;
    json["portOfDischarge"] = this.portOfDischarge;
    json["countryOfOriginOfGoods"] = this.countryOfOriginOfGoods;
    json["countryOfFinalDestination"] = this.countryOfFinalDestination;
    return json;
  }
}
