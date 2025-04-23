class GeneratedEwayBillModel {
  final dynamic ewayBillNo;
  final dynamic ewayBillDate;
  final dynamic validUpto;
  final dynamic alert;
  final String? docDate;
  final String? docNo;
  final dynamic pdfUrl;
  final dynamic detailedpdfUrl;
  final dynamic errorLogIds;
  final dynamic jsonData;
  final String? message;
  final bool? flag;

  GeneratedEwayBillModel({
    this.ewayBillNo,
    this.ewayBillDate,
    this.validUpto,
    this.alert,
    this.docDate,
    this.docNo,
    this.pdfUrl,
    this.detailedpdfUrl,
    this.errorLogIds,
    this.jsonData,
    this.message,
    this.flag,
  });

  GeneratedEwayBillModel.fromJson(Map<String, dynamic> json)
    : ewayBillNo = json['ewayBillNo'],
      ewayBillDate = json['ewayBillDate'],
      validUpto = json['validUpto'],
      alert = json['alert'],
      docDate = json['docDate'] as String?,
      docNo = json['docNo'] as String?,
      pdfUrl = json['pdfUrl'],
      detailedpdfUrl = json['detailedpdfUrl'],
      errorLogIds = json['error_log_ids'],
      jsonData = json['jsonData'],
      message = json['message'] as String?,
      flag = json['flag'] as bool?;

  Map<String, dynamic> toJson() => {
    'ewayBillNo' : ewayBillNo,
    'ewayBillDate' : ewayBillDate,
    'validUpto' : validUpto,
    'alert' : alert,
    'docDate' : docDate,
    'docNo' : docNo,
    'pdfUrl' : pdfUrl,
    'detailedpdfUrl' : detailedpdfUrl,
    'error_log_ids' : errorLogIds,
    'jsonData' : jsonData,
    'message' : message,
    'flag' : flag
  };
}