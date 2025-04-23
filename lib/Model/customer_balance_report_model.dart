class CustomerBalanceReportModel {
  final String? id;
  final String? invoiceNumber;
  final String? invoiceDate;
  final double? invoiceAmount;
  final double? paidAmount;
  final double? dueAmount;
  final String? partyName;
  final String? gstin;
  final String? statusName;
  final String? partyCode;

  CustomerBalanceReportModel({
    this.id,
    this.invoiceNumber,
    this.invoiceDate,
    this.invoiceAmount,
    this.paidAmount,
    this.dueAmount,
    this.partyName,
    this.gstin,
    this.statusName,
    this.partyCode,
  });

  CustomerBalanceReportModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      invoiceNumber = json['invoiceNumber'] as String?,
      invoiceDate = json['invoiceDate'] as String?,
      invoiceAmount = json['invoiceAmount'] as double?,
      paidAmount = json['paidAmount'] as double?,
      dueAmount = json['dueAmount'] as double?,
      partyName = json['partyName'] as String?,
      gstin = json['gstin'] as String?,
      statusName = json['statusName'] as String?,
      partyCode = json['partyCode'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'invoiceNumber' : invoiceNumber,
    'invoiceDate' : invoiceDate,
    'invoiceAmount' : invoiceAmount,
    'paidAmount' : paidAmount,
    'dueAmount' : dueAmount,
    'partyName' : partyName,
    'gstin' : gstin,
    'statusName' : statusName,
    'partyCode' : partyCode
  };
}