class CustomerPoReportModel {
  final String? id;
  final String? purchaseOrderNumber;
  final String? purchaseOrderDate;
  final String? customerName;
  final String? materialName;
  final dynamic partNumber;
  final double? quantity;
  final String? unitOfMeasurementName;
  final double? price;
  final double? amount;
  final double? totalAmount;
  final double? discountAmount;
  final dynamic cgstTaxPercentage;
  final double? cgstTaxAmount;
  final dynamic sgstTaxPercentage;
  final double? sgstTaxAmount;
  final double? igstTaxPercentage;
  final double? igstTaxAmount;
  final String? statusName;
  final dynamic internalReferenceNumber;
  final dynamic remarks;
  final String? partyCode;

  CustomerPoReportModel({
    this.id,
    this.purchaseOrderNumber,
    this.purchaseOrderDate,
    this.customerName,
    this.materialName,
    this.partNumber,
    this.quantity,
    this.unitOfMeasurementName,
    this.price,
    this.amount,
    this.totalAmount,
    this.discountAmount,
    this.cgstTaxPercentage,
    this.cgstTaxAmount,
    this.sgstTaxPercentage,
    this.sgstTaxAmount,
    this.igstTaxPercentage,
    this.igstTaxAmount,
    this.statusName,
    this.internalReferenceNumber,
    this.remarks,
    this.partyCode,
  });

  CustomerPoReportModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      purchaseOrderNumber = json['purchaseOrderNumber'] as String?,
      purchaseOrderDate = json['purchaseOrderDate'] as String?,
      customerName = json['customerName'] as String?,
      materialName = json['materialName'] as String?,
      partNumber = json['partNumber'],
      quantity = json['quantity'] as double?,
      unitOfMeasurementName = json['unitOfMeasurementName'] as String?,
      price = json['price'] as double?,
      amount = json['amount'] as double?,
      totalAmount = json['totalAmount'] as double?,
      discountAmount = json['discountAmount'] as double?,
      cgstTaxPercentage = json['cgstTaxPercentage'],
      cgstTaxAmount = json['cgstTaxAmount'] as double?,
      sgstTaxPercentage = json['sgstTaxPercentage'],
      sgstTaxAmount = json['sgstTaxAmount'] as double?,
      igstTaxPercentage = json['igstTaxPercentage'] as double?,
      igstTaxAmount = json['igstTaxAmount'] as double?,
      statusName = json['statusName'] as String?,
      internalReferenceNumber = json['internalReferenceNumber'],
      remarks = json['remarks'],
      partyCode = json['partyCode'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'purchaseOrderNumber' : purchaseOrderNumber,
    'purchaseOrderDate' : purchaseOrderDate,
    'customerName' : customerName,
    'materialName' : materialName,
    'partNumber' : partNumber,
    'quantity' : quantity,
    'unitOfMeasurementName' : unitOfMeasurementName,
    'price' : price,
    'amount' : amount,
    'totalAmount' : totalAmount,
    'discountAmount' : discountAmount,
    'cgstTaxPercentage' : cgstTaxPercentage,
    'cgstTaxAmount' : cgstTaxAmount,
    'sgstTaxPercentage' : sgstTaxPercentage,
    'sgstTaxAmount' : sgstTaxAmount,
    'igstTaxPercentage' : igstTaxPercentage,
    'igstTaxAmount' : igstTaxAmount,
    'statusName' : statusName,
    'internalReferenceNumber' : internalReferenceNumber,
    'remarks' : remarks,
    'partyCode' : partyCode
  };
}