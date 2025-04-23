class EwayBillReportModel {
  final int? id;
  final String? invoiceHeaderId;
  final String? invoiceNumber;
  final String? eWayBillNo;
  final String? eWayBillDate;
  final dynamic ackNo;
  final dynamic ackDt;
  final String? partyName;
  final String? supplyType;
  final String? invoiceDate;
  final String? partyGstNum;
  final String? transportedGstNum;
  final String? fromAddress;
  final String? toAddress;
  final String? status;
  final int? noOfItems;
  final String? hsnCode;
  final String? hsnDescription;
  final double? assesableValue;
  final double? sgst;
  final double? cgst;
  final double? igst;
  final double? cess;
  final double? noncess;
  final double? otherValue;
  final double? invoiceValue;
  final String? eWayBillValidity;
  final String? pdfUrl;
  final String? detailedpdfUrl;

  EwayBillReportModel({
    this.id,
    this.invoiceHeaderId,
    this.invoiceNumber,
    this.eWayBillNo,
    this.eWayBillDate,
    this.ackNo,
    this.ackDt,
    this.partyName,
    this.supplyType,
    this.invoiceDate,
    this.partyGstNum,
    this.transportedGstNum,
    this.fromAddress,
    this.toAddress,
    this.status,
    this.noOfItems,
    this.hsnCode,
    this.hsnDescription,
    this.assesableValue,
    this.sgst,
    this.cgst,
    this.igst,
    this.cess,
    this.noncess,
    this.otherValue,
    this.invoiceValue,
    this.eWayBillValidity,
    this.pdfUrl,
    this.detailedpdfUrl,
  });

  EwayBillReportModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      invoiceHeaderId = json['invoiceHeaderId'] as String?,
      invoiceNumber = json['invoiceNumber'] as String?,
      eWayBillNo = json['eWayBillNo'] as String?,
      eWayBillDate = json['eWayBillDate'] as String?,
      ackNo = json['ackNo'],
      ackDt = json['ackDt'],
      partyName = json['partyName'] as String?,
      supplyType = json['supplyType'] as String?,
      invoiceDate = json['invoiceDate'] as String?,
      partyGstNum = json['partyGstNum'] as String?,
      transportedGstNum = json['transportedGstNum'] as String?,
      fromAddress = json['fromAddress'] as String?,
      toAddress = json['toAddress'] as String?,
      status = json['status'] as String?,
      noOfItems = json['noOfItems'] as int?,
      hsnCode = json['hsnCode'] as String?,
      hsnDescription = json['hsnDescription'] as String?,
      assesableValue = json['assesableValue'] as double?,
      sgst = json['sgst'] as double?,
      cgst = json['cgst'] as double?,
      igst = json['igst'] as double?,
      cess = json['cess'] as double?,
      noncess = json['noncess'] as double?,
      otherValue = json['otherValue'] as double?,
      invoiceValue = json['invoiceValue'] as double?,
      eWayBillValidity = json['eWayBillValidity'] as String?,
      pdfUrl = json['pdfUrl'] as String?,
      detailedpdfUrl = json['detailedpdfUrl'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'invoiceHeaderId' : invoiceHeaderId,
    'invoiceNumber' : invoiceNumber,
    'eWayBillNo' : eWayBillNo,
    'eWayBillDate' : eWayBillDate,
    'ackNo' : ackNo,
    'ackDt' : ackDt,
    'partyName' : partyName,
    'supplyType' : supplyType,
    'invoiceDate' : invoiceDate,
    'partyGstNum' : partyGstNum,
    'transportedGstNum' : transportedGstNum,
    'fromAddress' : fromAddress,
    'toAddress' : toAddress,
    'status' : status,
    'noOfItems' : noOfItems,
    'hsnCode' : hsnCode,
    'hsnDescription' : hsnDescription,
    'assesableValue' : assesableValue,
    'sgst' : sgst,
    'cgst' : cgst,
    'igst' : igst,
    'cess' : cess,
    'noncess' : noncess,
    'otherValue' : otherValue,
    'invoiceValue' : invoiceValue,
    'eWayBillValidity' : eWayBillValidity,
    'pdfUrl' : pdfUrl,
    'detailedpdfUrl' : detailedpdfUrl
  };
}