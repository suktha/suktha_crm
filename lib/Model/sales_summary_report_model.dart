class SalesSummaryReportModel {
  final String? id;
  final String? invoiceNumber;
  final String? invoiceDate;
  final dynamic sourceInvoiceNumber;
  final dynamic sourceInvoiceDate;
  final String? partyName;
  final double? totalTaxableAmount;
  final dynamic cgstTaxRate;
  final double? cgstTaxAmount;
  final dynamic sgstTaxRate;
  final double? sgstTaxAmount;
  final dynamic igstTaxRate;
  final double? discountAmount;
  final double? igstTaxAmount;
  final dynamic advanceAmount;
  final double? grandTotal;
  final String? statusName;
  final double? amount;
  final int? inclusiveTax;
  final String? partyCode;
  final double? tcsPercentage;
  final double? tcsAmount;
  final String? gstNumber;

  SalesSummaryReportModel({
    this.id,
    this.invoiceNumber,
    this.invoiceDate,
    this.sourceInvoiceNumber,
    this.sourceInvoiceDate,
    this.partyName,
    this.totalTaxableAmount,
    this.cgstTaxRate,
    this.cgstTaxAmount,
    this.sgstTaxRate,
    this.sgstTaxAmount,
    this.igstTaxRate,
    this.discountAmount,
    this.igstTaxAmount,
    this.advanceAmount,
    this.grandTotal,
    this.statusName,
    this.amount,
    this.inclusiveTax,
    this.partyCode,
    this.tcsPercentage,
    this.tcsAmount,
    this.gstNumber,
  });

  SalesSummaryReportModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      invoiceNumber = json['invoiceNumber'] as String?,
      invoiceDate = json['invoiceDate'] as String?,
      sourceInvoiceNumber = json['sourceInvoiceNumber'],
      sourceInvoiceDate = json['sourceInvoiceDate'],
      partyName = json['partyName'] as String?,
      totalTaxableAmount = json['totalTaxableAmount'] as double?,
      cgstTaxRate = json['cgstTaxRate'],
      cgstTaxAmount = json['cgstTaxAmount'] as double?,
      sgstTaxRate = json['sgstTaxRate'],
      sgstTaxAmount = json['sgstTaxAmount'] as double?,
      igstTaxRate = json['igstTaxRate'],
      discountAmount = json['discountAmount'] as double?,
      igstTaxAmount = json['igstTaxAmount'] as double?,
      advanceAmount = json['advanceAmount'],
      grandTotal = json['grandTotal'] as double?,
      statusName = json['statusName'] as String?,
      amount = json['amount'] as double?,
      inclusiveTax = json['inclusiveTax'] as int?,
      partyCode = json['partyCode'] as String?,
      tcsPercentage = json['tcsPercentage'] as double?,
      tcsAmount = json['tcsAmount'] as double?,
      gstNumber = json['gstNumber'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'invoiceNumber' : invoiceNumber,
    'invoiceDate' : invoiceDate,
    'sourceInvoiceNumber' : sourceInvoiceNumber,
    'sourceInvoiceDate' : sourceInvoiceDate,
    'partyName' : partyName,
    'totalTaxableAmount' : totalTaxableAmount,
    'cgstTaxRate' : cgstTaxRate,
    'cgstTaxAmount' : cgstTaxAmount,
    'sgstTaxRate' : sgstTaxRate,
    'sgstTaxAmount' : sgstTaxAmount,
    'igstTaxRate' : igstTaxRate,
    'discountAmount' : discountAmount,
    'igstTaxAmount' : igstTaxAmount,
    'advanceAmount' : advanceAmount,
    'grandTotal' : grandTotal,
    'statusName' : statusName,
    'amount' : amount,
    'inclusiveTax' : inclusiveTax,
    'partyCode' : partyCode,
    'tcsPercentage' : tcsPercentage,
    'tcsAmount' : tcsAmount,
    'gstNumber' : gstNumber
  };
}