class PayRecReportModel {
  final String? id;
  final String? invoiceNumber;
  final String? invoiceDate;
  final double? invoiceAmount;
  final double? tdsPercentage;
  final double? tdsAmount;
  final double? amountAfterTds;
  final double? paidAmount;
  final double? payingAmount;
  final String? bankName;
  final String? paymentMethodName;
  final double? dueAmount;
  final String? partyName;
  final String? paymentDocumentNumber;
  final String? payReferenceDate;
  final String? payReferenceNumber;
  final String? statusName;
  final String? partyCode;

  PayRecReportModel({
    this.id,
    this.invoiceNumber,
    this.invoiceDate,
    this.invoiceAmount,
    this.tdsPercentage,
    this.tdsAmount,
    this.amountAfterTds,
    this.paidAmount,
    this.payingAmount,
    this.bankName,
    this.paymentMethodName,
    this.dueAmount,
    this.partyName,
    this.paymentDocumentNumber,
    this.payReferenceDate,
    this.payReferenceNumber,
    this.statusName,
    this.partyCode,
  });

  PayRecReportModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      invoiceNumber = json['invoiceNumber'] as String?,
      invoiceDate = json['invoiceDate'] as String?,
      invoiceAmount = json['invoiceAmount'] as double?,
      tdsPercentage = json['tdsPercentage'] as double?,
      tdsAmount = json['tdsAmount'] as double?,
      amountAfterTds = json['amountAfterTds'] as double?,
      paidAmount = json['paidAmount'] as double?,
      payingAmount = json['payingAmount'] as double?,
      bankName = json['bankName'] as String?,
      paymentMethodName = json['paymentMethodName'] as String?,
      dueAmount = json['dueAmount'] as double?,
      partyName = json['partyName'] as String?,
      paymentDocumentNumber = json['paymentDocumentNumber'] as String?,
      payReferenceDate = json['payReferenceDate'] as String?,
      payReferenceNumber = json['payReferenceNumber'] as String?,
      statusName = json['statusName'] as String?,
      partyCode = json['partyCode'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'invoiceNumber' : invoiceNumber,
    'invoiceDate' : invoiceDate,
    'invoiceAmount' : invoiceAmount,
    'tdsPercentage' : tdsPercentage,
    'tdsAmount' : tdsAmount,
    'amountAfterTds' : amountAfterTds,
    'paidAmount' : paidAmount,
    'payingAmount' : payingAmount,
    'bankName' : bankName,
    'paymentMethodName' : paymentMethodName,
    'dueAmount' : dueAmount,
    'partyName' : partyName,
    'paymentDocumentNumber' : paymentDocumentNumber,
    'payReferenceDate' : payReferenceDate,
    'payReferenceNumber' : payReferenceNumber,
    'statusName' : statusName,
    'partyCode' : partyCode
  };
}