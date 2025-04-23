class SalesTaxModel {
  final String? id;
  final String? partyName;
  final String? gstNumber;
  final String? invoiceNumber;
  final String? invoiceDate;
  final double? netAmount;
  final double? cgstTaxPercent;
  final double? cgstTaxAmount;
  final double? sgstTaxPercent;
  final double? sgstTaxAmount;
  final dynamic igstTaxPercent;
  final dynamic igstTaxAmount;
  final double? grandTotal;
  final String? statusName;
  final String? partyCode;

  SalesTaxModel({
    this.id,
    this.partyName,
    this.gstNumber,
    this.invoiceNumber,
    this.invoiceDate,
    this.netAmount,
    this.cgstTaxPercent,
    this.cgstTaxAmount,
    this.sgstTaxPercent,
    this.sgstTaxAmount,
    this.igstTaxPercent,
    this.igstTaxAmount,
    this.grandTotal,
    this.statusName,
    this.partyCode,
  });

  SalesTaxModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      partyName = json['partyName'] as String?,
      gstNumber = json['gstNumber'] as String?,
      invoiceNumber = json['invoiceNumber'] as String?,
      invoiceDate = json['invoiceDate'] as String?,
      netAmount = json['netAmount'] as double?,
      cgstTaxPercent = json['cgstTaxPercent'] as double?,
      cgstTaxAmount = json['cgstTaxAmount'] as double?,
      sgstTaxPercent = json['sgstTaxPercent'] as double?,
      sgstTaxAmount = json['sgstTaxAmount'] as double?,
      igstTaxPercent = json['igstTaxPercent'],
      igstTaxAmount = json['igstTaxAmount'],
      grandTotal = json['grandTotal'] as double?,
      statusName = json['statusName'] as String?,
      partyCode = json['partyCode'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'partyName' : partyName,
    'gstNumber' : gstNumber,
    'invoiceNumber' : invoiceNumber,
    'invoiceDate' : invoiceDate,
    'netAmount' : netAmount,
    'cgstTaxPercent' : cgstTaxPercent,
    'cgstTaxAmount' : cgstTaxAmount,
    'sgstTaxPercent' : sgstTaxPercent,
    'sgstTaxAmount' : sgstTaxAmount,
    'igstTaxPercent' : igstTaxPercent,
    'igstTaxAmount' : igstTaxAmount,
    'grandTotal' : grandTotal,
    'statusName' : statusName,
    'partyCode' : partyCode
  };
}