class QuotationSummaryModel {
  final String? id;
  final String? quotationNumber;
  final String? quotationDate;
  final String? partyName;
  final double? totalTaxableAmount;
  final dynamic cgstTaxRate;
  final double? cgstTaxAmount;
  final dynamic sgstTaxRate;
  final double? sgstTaxAmount;
  final dynamic igstTaxRate;
  final double? discountAmount;
  final double? igstTaxAmount;
  final double? grandTotal;
  final String? statusName;
  final double? amount;
  final int? inclusiveTax;
  final String? partyCode;

  QuotationSummaryModel({
    this.id,
    this.quotationNumber,
    this.quotationDate,
    this.partyName,
    this.totalTaxableAmount,
    this.cgstTaxRate,
    this.cgstTaxAmount,
    this.sgstTaxRate,
    this.sgstTaxAmount,
    this.igstTaxRate,
    this.discountAmount,
    this.igstTaxAmount,
    this.grandTotal,
    this.statusName,
    this.amount,
    this.inclusiveTax,
    this.partyCode,
  });

  QuotationSummaryModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      quotationNumber = json['quotationNumber'] as String?,
      quotationDate = json['quotationDate'] as String?,
      partyName = json['partyName'] as String?,
      totalTaxableAmount = json['totalTaxableAmount'] as double?,
      cgstTaxRate = json['cgstTaxRate'],
      cgstTaxAmount = json['cgstTaxAmount'] as double?,
      sgstTaxRate = json['sgstTaxRate'],
      sgstTaxAmount = json['sgstTaxAmount'] as double?,
      igstTaxRate = json['igstTaxRate'],
      discountAmount = json['discountAmount'] as double?,
      igstTaxAmount = json['igstTaxAmount'] as double?,
      grandTotal = json['grandTotal'] as double?,
      statusName = json['statusName'] as String?,
      amount = json['amount'] as double?,
      inclusiveTax = json['inclusiveTax'] as int?,
      partyCode = json['partyCode'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'quotationNumber' : quotationNumber,
    'quotationDate' : quotationDate,
    'partyName' : partyName,
    'totalTaxableAmount' : totalTaxableAmount,
    'cgstTaxRate' : cgstTaxRate,
    'cgstTaxAmount' : cgstTaxAmount,
    'sgstTaxRate' : sgstTaxRate,
    'sgstTaxAmount' : sgstTaxAmount,
    'igstTaxRate' : igstTaxRate,
    'discountAmount' : discountAmount,
    'igstTaxAmount' : igstTaxAmount,
    'grandTotal' : grandTotal,
    'statusName' : statusName,
    'amount' : amount,
    'inclusiveTax' : inclusiveTax,
    'partyCode' : partyCode
  };
}