class SubscriptionDueReportModel {
  final String? id;
  final String? invoiceNumber;
  final String? invoiceDate;
  final String? partyName;
  final double? totalTaxableAmount;
  final double? cgstTaxRate;
  final double? cgstTaxAmount;
  final double? sgstTaxRate;
  final double? sgstTaxAmount;
  final double? igstTaxRate;
  final double? igstTaxAmount;
  final double? advanceAmount;
  final double? grandTotal;
  final String? description;
  final double? quantity;
  final double? price;
  final double? discountAmount;
  final String? statusName;
  final String? uom;
  final double? amountAfterDiscount;
  final int? inclusiveTax;
  final double? taxableAmount;
  final String? partNumber;
  final String? invoiceHeaderId;
  final String? partyCode;
  final String? hsnCode;
  final String? gstNumber;
  final String? internalReferenceNumber;
  final double? discountPercent;
  final double? roundOffAmount;
  final dynamic purchaseOrderDate;
  final String? purchaseOrderNumber;
  final String? serviceStartDate;
  final String? serviceEndDate;
  final String? contactPersonName;
  final String? contactPersonNumber;
  final String? email;

  SubscriptionDueReportModel({
    this.id,
    this.invoiceNumber,
    this.invoiceDate,
    this.partyName,
    this.totalTaxableAmount,
    this.cgstTaxRate,
    this.cgstTaxAmount,
    this.sgstTaxRate,
    this.sgstTaxAmount,
    this.igstTaxRate,
    this.igstTaxAmount,
    this.advanceAmount,
    this.grandTotal,
    this.description,
    this.quantity,
    this.price,
    this.discountAmount,
    this.statusName,
    this.uom,
    this.amountAfterDiscount,
    this.inclusiveTax,
    this.taxableAmount,
    this.partNumber,
    this.invoiceHeaderId,
    this.partyCode,
    this.hsnCode,
    this.gstNumber,
    this.internalReferenceNumber,
    this.discountPercent,
    this.roundOffAmount,
    this.purchaseOrderDate,
    this.purchaseOrderNumber,
    this.serviceStartDate,
    this.serviceEndDate,
    this.contactPersonName,
    this.contactPersonNumber,
    this.email,
  });

  SubscriptionDueReportModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        invoiceNumber = json['invoiceNumber'] as String?,
        invoiceDate = json['invoiceDate'] as String?,
        partyName = json['partyName'] as String?,
        totalTaxableAmount = json['totalTaxableAmount'] as double?,
        cgstTaxRate = json['cgstTaxRate'] as double?,
        cgstTaxAmount = json['cgstTaxAmount'] as double?,
        sgstTaxRate = json['sgstTaxRate'] as double?,
        sgstTaxAmount = json['sgstTaxAmount'] as double?,
        igstTaxRate = json['igstTaxRate'] as double?,
        igstTaxAmount = json['igstTaxAmount'] as double?,
        advanceAmount = json['advanceAmount'] as double?,
        grandTotal = json['grandTotal'] as double?,
        description = json['description'] as String?,
        quantity = json['quantity'] as double?,
        price = json['price'] as double?,
        discountAmount = json['discountAmount'] as double?,
        statusName = json['statusName'] as String?,
        uom = json['uom'] as String?,
        amountAfterDiscount = json['amountAfterDiscount'] as double?,
        inclusiveTax = json['inclusiveTax'] as int?,
        taxableAmount = json['taxableAmount'] as double?,
        partNumber = json['partNumber'] as String?,
        invoiceHeaderId = json['invoiceHeaderId'] as String?,
        partyCode = json['partyCode'] as String?,
        hsnCode = json['hsnCode'] as String?,
        gstNumber = json['gstNumber'] as String?,
        internalReferenceNumber = json['internalReferenceNumber'] as String?,
        discountPercent = json['discountPercent'] as double?,
        roundOffAmount = json['roundOffAmount'] as double?,
        purchaseOrderDate = json['purchaseOrderDate'],
        purchaseOrderNumber = json['purchaseOrderNumber'] as String?,
        serviceStartDate = json['serviceStartDate'] as String?,
        serviceEndDate = json['serviceEndDate'] as String?,
        contactPersonName = json['contactPersonName'] as String?,
        contactPersonNumber = json['contactPersonNumber'] as String?,
        email = json['email'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'invoiceNumber': invoiceNumber,
        'invoiceDate': invoiceDate,
        'partyName': partyName,
        'totalTaxableAmount': totalTaxableAmount,
        'cgstTaxRate': cgstTaxRate,
        'cgstTaxAmount': cgstTaxAmount,
        'sgstTaxRate': sgstTaxRate,
        'sgstTaxAmount': sgstTaxAmount,
        'igstTaxRate': igstTaxRate,
        'igstTaxAmount': igstTaxAmount,
        'advanceAmount': advanceAmount,
        'grandTotal': grandTotal,
        'description': description,
        'quantity': quantity,
        'price': price,
        'discountAmount': discountAmount,
        'statusName': statusName,
        'uom': uom,
        'amountAfterDiscount': amountAfterDiscount,
        'inclusiveTax': inclusiveTax,
        'taxableAmount': taxableAmount,
        'partNumber': partNumber,
        'invoiceHeaderId': invoiceHeaderId,
        'partyCode': partyCode,
        'hsnCode': hsnCode,
        'gstNumber': gstNumber,
        'internalReferenceNumber': internalReferenceNumber,
        'discountPercent': discountPercent,
        'roundOffAmount': roundOffAmount,
        'purchaseOrderDate': purchaseOrderDate,
        'purchaseOrderNumber': purchaseOrderNumber,
        'serviceStartDate': serviceStartDate,
        'serviceEndDate': serviceEndDate,
        'contactPersonName': contactPersonName,
        'contactPersonNumber': contactPersonNumber,
        'email': email,
      };
}
