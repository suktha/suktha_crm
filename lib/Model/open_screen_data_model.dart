class TransactionValuesCustomModel {
  String? partyName;
  String? statusName;
  String? transactionNumber;
  String? transactionDate;
  String? partyAddress;
  String? partyContactNumber;
  String? partyEmail;
  double? discountAmount;
  double? discountPercent;
  double? totalTaxableAmount;
  double? grandTotal;
  double? taxRate;
  double? cgstTaxRate;
  double? cgstTaxPercentage;
  double? sgstTaxRate;
  double? sgstTaxPercentage;
  double? igstTaxRate;
  double? igstTaxPercentage;
  double? taxPercent;
  String? internalNote;
  String? interalRefNum;
  String? refDate;
  String? remarks;
  int? transactionTypeId;
  String? id;
  String? japserFileName;
  String? headerTextName;
  String? partyId;
  List<TransactionItems>? transacionItems;

  TransactionValuesCustomModel({
    this.partyName,
    this.statusName,
    this.refDate,
    this.interalRefNum,
    this.remarks,
    this.transactionNumber,
    this.discountAmount,
    this.discountPercent,
    this.totalTaxableAmount,
    this.grandTotal,
    this.taxRate,
    this.cgstTaxPercentage,
    this.cgstTaxRate,
    this.sgstTaxPercentage,
    this.sgstTaxRate,
    this.igstTaxPercentage,
    this.igstTaxRate,
    this.taxPercent,
    this.transactionDate,
    this.transacionItems,
    this.partyAddress,
    this.partyContactNumber,
    this.partyEmail,
    this.internalNote,
    this.headerTextName,
    this.id,
    this.japserFileName,
    this.partyId,
    this.transactionTypeId,
  });

  TransactionValuesCustomModel.fromJson(Map<String, dynamic> json) {
    partyName = json['partyName'];
    interalRefNum = json['interalRefNum'];
    refDate = json['refDate'];
    remarks = json['remarks'];
    statusName = json['statusName'];
    transactionNumber = json['transactionNumber'];
    discountAmount = json['discountAmount'];
    discountPercent = json['discountPercent'];
    totalTaxableAmount = json['totalTaxableAmount'];
    grandTotal = json['grandTotal'];
    taxRate = json['taxRate'];
    cgstTaxPercentage = json['cgstTaxPercentage'];
    cgstTaxRate = json['cgstTaxRate'];
    sgstTaxPercentage = json['sgstTaxPercentage'];
    sgstTaxRate = json['sgstTaxRate'];
    igstTaxPercentage = json['igstTaxPercentage'];
    igstTaxRate = json['igstTaxRate'];
    taxPercent = json['taxPercent'];
    transactionDate = json['transactionDate'];
    internalNote = json['internalNote;'];
    if (json['transacionItems'] != null) {
      transacionItems = <TransactionItems>[];
      json['transacionItems'].forEach((v) {
        transacionItems!.add(new TransactionItems.fromJson(v));
      });
    }
    statusName = json['statusName'];
    partyName = json['partyName'];
    partyAddress = json['partyAddress'];
    partyContactNumber = json['partyContactNumber'];
    partyEmail = json['partyEmail'];
    partyEmail = json['partyEmail'];
    internalNote = json['internalNote'];
    transactionTypeId = json['transactionTypeId'];
    id = json['id'];
    headerTextName = json['headerTextName'];
    japserFileName = json['japserFileName'];
    partyId = json['partyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partyName'] = this.partyName;
    data['transactionNumber'] = this.transactionNumber;
    data['discountAmount'] = this.discountAmount;
    data['discountPercent'] = this.discountPercent;
    data['totalTaxableAmount'] = this.totalTaxableAmount;
    data['grandTotal'] = this.grandTotal;
    data['taxRate'] = this.taxRate;
    data['cgstTaxPercentage'] = this.cgstTaxPercentage;
    data['cgstTaxRate'] = this.cgstTaxRate;
    data['sgstTaxPercentage'] = this.sgstTaxPercentage;
    data['sgstTaxRate'] = this.sgstTaxRate;
    data['igstTaxRate'] = this.igstTaxRate;
    data['igstTaxPercentage'] = this.igstTaxPercentage;
    data['transactionDate'] = this.transactionDate;
    data['internalNote;'] = this.internalNote;
    if (this.transacionItems != null) {
      data['transacionItems'] = this.transacionItems!.map((v) => v.toJson()).toList();
    }
    data['statusName'] = this.statusName;
    data['partyName'] = this.partyName;
    data['partyAddress'] = this.partyAddress;
    data['partyContactNumber'] = this.partyContactNumber;
    data['partyEmail'] = this.partyEmail;
    data['partyEmail'] = this.partyEmail;
    data['internalNote'] = this.internalNote;
    data['transactionTypeId'] = this.transactionTypeId;
    data['japserFileName'] = this.japserFileName;
    data['partyId'] = this.partyId;
    data['id'] = this.id;
    data['headerTextName'] = this.headerTextName;
    return data;
  }
}

class TransactionItems {
  String? imageUrl;
  int? slNo;
  int? materialId;
  double? quantity;
  double? price;
  double? amount;
  double? taxPercentage;
  double? taxRate;
  double? cgstTaxRate;
  double? cgstTaxPercentage;
  double? sgstTaxRate;
  double? sgstTaxPercentage;
  double? igstTaxRate;
  double? igstTaxPercentage;
  double? amountAfterTax;
  double? discountPercentage;
  double? discountAmount;
  double? amountAfterDiscount;
  String? remarks;
  String? partNumber;
  String? hsnOrSac;
  String? itemName;
  String? uom;
  String? specification;

  TransactionItems(
      {this.imageUrl,
      this.slNo,
      this.materialId,
      this.quantity,
      this.price,
      this.amount,
      this.taxPercentage,
      this.taxRate,
      this.cgstTaxPercentage,
      this.cgstTaxRate,
      this.sgstTaxPercentage,
      this.sgstTaxRate,
      this.igstTaxPercentage,
      this.igstTaxRate,
      this.amountAfterTax,
      this.discountPercentage,
      this.discountAmount,
      this.amountAfterDiscount,
      this.remarks,
      this.partNumber,
      this.hsnOrSac,
      this.itemName,
      this.uom,
      this.specification});

  TransactionItems.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    slNo = json['slNo'];
    materialId = json['materialId'];
    quantity = json['quantity'];
    price = json['price'];
    amount = json['amount'];
    taxPercentage = json['taxPercentage'];
    taxRate = json['taxRate'];
    cgstTaxPercentage = json['cgstTaxPercentage'];
    cgstTaxRate = json['cgstTaxRate'];
    sgstTaxPercentage = json['sgstTaxPercentage'];
    sgstTaxRate = json['sgstTaxRate'];
    igstTaxPercentage = json['igstTaxPercentage'];
    igstTaxRate = json['igstTaxRate'];
    amountAfterTax = json['amountAfterTax'];
    discountPercentage = json['discountPercentage'];
    discountAmount = json['discountAmount'];
    amountAfterDiscount = json['amountAfterDiscount'];

    remarks = json['remarks'];
    partNumber = json['partNumber'];
    hsnOrSac = json['hsnOrSac'];
    itemName = json['itemName'];
    uom = json['uom'];
    specification = json['specification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['imageUrl'] = this.imageUrl;
    data['slNo'] = this.slNo;
    data['materialId'] = this.materialId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['taxPercentage'] = this.taxPercentage;
    data['taxRate'] = this.taxRate;
    data['cgstTaxPercentage'] = this.cgstTaxPercentage;
    data['cgstTaxRate'] = this.cgstTaxRate;
    data['sgstTaxPercentage'] = this.sgstTaxPercentage;
    data['sgstTaxRate'] = this.sgstTaxRate;
    data['igstTaxRate'] = this.igstTaxRate;
    data['igstTaxPercentage'] = this.igstTaxPercentage;
    data['amountAfterTax'] = this.amountAfterTax;
    data['discountPercentage'] = this.discountPercentage;
    data['discountAmount'] = this.discountAmount;
    data['amountAfterDiscount'] = this.amountAfterDiscount;
    data['remarks'] = this.remarks;
    data['partNumber'] = this.partNumber;
    data['hsnOrSac'] = this.hsnOrSac;
    data['itemName'] = this.itemName;
    data['uom'] = this.uom;
    data['specification'] = this.specification;
    return data;
  }
}
