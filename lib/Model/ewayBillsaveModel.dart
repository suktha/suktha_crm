class EwayBillModel {
  final int? id;
  final dynamic eWayBillNo;
  final dynamic eWayBillDate;
  final dynamic validUpto;
  final String? docDate;
  final String? docNo;
  final dynamic pdfUrl;
  final dynamic detailedpdfUrl;
  final dynamic jsonData;
  final String? invoiceHeaderId;
  final int? status;
  final dynamic error;
  final dynamic transporterId;
  final dynamic transporterName;
  final dynamic transDocNo;
  final dynamic vehicleNo;
  final dynamic portName;
  final dynamic portPin;
  final dynamic portStateId;
  final dynamic cancelledDate;
  final String? response;
  final dynamic vehicleType;
  final dynamic reasonCode;
  final dynamic reasonRemarks;
  final dynamic transactionMode;
  final dynamic remainingDistance;
  final dynamic extensionReasonCode;
  final dynamic extensionReasonRemarks;
  final dynamic fromState;
  final dynamic fromPlace;
  final dynamic fromPincode;
  final dynamic transDocDate;
  final dynamic addressLine1;
  final dynamic addressLine2;
  final dynamic addressLine3;
  final int? transDistance;
  final int? noOfItems;
  final String? hsnCode;
  final int? isCurrent;
  final dynamic cancelledReason;
  final dynamic cancelledRemarks;
  final String? eInvoiceCancelledDate;
  final int? generateTypeId;
  final String? companyAddress1;
  final String? companyAddress2;
  final String? einvPdfUrl;
  final String? ackNo;
  final String? signedQRCode;
  final String? ackDt;
  final String? irn;

  EwayBillModel({
    this.id,
    this.eWayBillNo,
    this.eWayBillDate,
    this.validUpto,
    this.docDate,
    this.docNo,
    this.pdfUrl,
    this.detailedpdfUrl,
    this.jsonData,
    this.invoiceHeaderId,
    this.status,
    this.error,
    this.transporterId,
    this.transporterName,
    this.transDocNo,
    this.vehicleNo,
    this.portName,
    this.portPin,
    this.portStateId,
    this.cancelledDate,
    this.response,
    this.vehicleType,
    this.reasonCode,
    this.reasonRemarks,
    this.transactionMode,
    this.remainingDistance,
    this.extensionReasonCode,
    this.extensionReasonRemarks,
    this.fromState,
    this.fromPlace,
    this.fromPincode,
    this.transDocDate,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.transDistance,
    this.noOfItems,
    this.hsnCode,
    this.isCurrent,
    this.cancelledReason,
    this.cancelledRemarks,
    this.eInvoiceCancelledDate,
    this.generateTypeId,
    this.companyAddress1,
    this.companyAddress2,
    this.einvPdfUrl,
    this.ackNo,
    this.signedQRCode,
    this.ackDt,
    this.irn,
  });

  EwayBillModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      eWayBillNo = json['eWayBillNo'],
      eWayBillDate = json['eWayBillDate'],
      validUpto = json['validUpto'],
      docDate = json['docDate'] as String?,
      docNo = json['docNo'] as String?,
      pdfUrl = json['pdfUrl'],
      detailedpdfUrl = json['detailedpdfUrl'],
      jsonData = json['jsonData'],
      invoiceHeaderId = json['invoiceHeaderId'] as String?,
      status = json['status'] as int?,
      error = json['error'],
      transporterId = json['transporterId'],
      transporterName = json['transporterName'],
      transDocNo = json['transDocNo'],
      vehicleNo = json['vehicleNo'],
      portName = json['portName'],
      portPin = json['portPin'],
      portStateId = json['portStateId'],
      cancelledDate = json['cancelledDate'],
      response = json['response'] as String?,
      vehicleType = json['vehicleType'],
      reasonCode = json['reasonCode'],
      reasonRemarks = json['reasonRemarks'],
      transactionMode = json['transactionMode'],
      remainingDistance = json['remainingDistance'],
      extensionReasonCode = json['extensionReasonCode'],
      extensionReasonRemarks = json['extensionReasonRemarks'],
      fromState = json['fromState'],
      fromPlace = json['fromPlace'],
      fromPincode = json['fromPincode'],
      transDocDate = json['transDocDate'],
      addressLine1 = json['addressLine1'],
      addressLine2 = json['addressLine2'],
      addressLine3 = json['addressLine3'],
      transDistance = json['transDistance'] as int?,
      noOfItems = json['noOfItems'] as int?,
      hsnCode = json['hsnCode'] as String?,
      isCurrent = json['isCurrent'] as int?,
      cancelledReason = json['cancelledReason'],
      cancelledRemarks = json['cancelledRemarks'],
      eInvoiceCancelledDate = json['eInvoiceCancelledDate'] as String?,
      generateTypeId = json['generateTypeId'] as int?,
      companyAddress1 = json['companyAddress1'] as String?,
      companyAddress2 = json['companyAddress2'] as String?,
      einvPdfUrl = json['einvPdfUrl'] as String?,
      ackNo = json['ackNo'] as String?,
      signedQRCode = json['signedQRCode'] as String?,
      ackDt = json['ackDt'] as String?,
      irn = json['irn'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'eWayBillNo' : eWayBillNo,
    'eWayBillDate' : eWayBillDate,
    'validUpto' : validUpto,
    'docDate' : docDate,
    'docNo' : docNo,
    'pdfUrl' : pdfUrl,
    'detailedpdfUrl' : detailedpdfUrl,
    'jsonData' : jsonData,
    'invoiceHeaderId' : invoiceHeaderId,
    'status' : status,
    'error' : error,
    'transporterId' : transporterId,
    'transporterName' : transporterName,
    'transDocNo' : transDocNo,
    'vehicleNo' : vehicleNo,
    'portName' : portName,
    'portPin' : portPin,
    'portStateId' : portStateId,
    'cancelledDate' : cancelledDate,
    'response' : response,
    'vehicleType' : vehicleType,
    'reasonCode' : reasonCode,
    'reasonRemarks' : reasonRemarks,
    'transactionMode' : transactionMode,
    'remainingDistance' : remainingDistance,
    'extensionReasonCode' : extensionReasonCode,
    'extensionReasonRemarks' : extensionReasonRemarks,
    'fromState' : fromState,
    'fromPlace' : fromPlace,
    'fromPincode' : fromPincode,
    'transDocDate' : transDocDate,
    'addressLine1' : addressLine1,
    'addressLine2' : addressLine2,
    'addressLine3' : addressLine3,
    'transDistance' : transDistance,
    'noOfItems' : noOfItems,
    'hsnCode' : hsnCode,
    'isCurrent' : isCurrent,
    'cancelledReason' : cancelledReason,
    'cancelledRemarks' : cancelledRemarks,
    'eInvoiceCancelledDate' : eInvoiceCancelledDate,
    'generateTypeId' : generateTypeId,
    'companyAddress1' : companyAddress1,
    'companyAddress2' : companyAddress2,
    'einvPdfUrl' : einvPdfUrl,
    'ackNo' : ackNo,
    'signedQRCode' : signedQRCode,
    'ackDt' : ackDt,
    'irn' : irn
  };
}