class ApplicationSettingsModel {
  final int? id;
  final String? deleted;
  final int? financialYearId;
  final int? stockIncreaseOnId;
  final int? stockDecreaseOnId;
  final int? itemLevelTax;
  final int? itemLevelDiscount;
  final dynamic browserPath;
  final int? salePrice;
  final int? purchasePrice;
  final int? specialPriceCalculation;
  final int? inclusiveTax;
  final dynamic barCodeStatus;
  final dynamic printStatus;
  final dynamic includeSignatureStatus;
  final dynamic helpDocument;
  final double? sgstPercentage;
  final double? cgstPercentage;
  final int? disableItemGroup;
  final int? cutomerMateriaBinding;
  final int? showOnlyCustomerMaterialInSales;
  final int? roundOffTaxTransaction;
  final int? stockCheckRequired;
  final int? itemLevelTaxPurchase;
  final dynamic enableTally;
  final dynamic allowReuse;
  final int? allowPartyCode;
  final int? allowEwayBill;
  final int? allowEinvoiceWithEwayBill;
  final dynamic enableEmailNotification;
  final dynamic eInvPassword;
  final dynamic eInvUserCode;
  final int? aliasNameEnable;
  final int? enablePosSolution;
  final dynamic enableAutoPartNo;
  final int? updateMaterialSpecFromTrans;

  ApplicationSettingsModel({
    this.id,
    this.deleted,
    this.financialYearId,
    this.stockIncreaseOnId,
    this.stockDecreaseOnId,
    this.itemLevelTax,
    this.itemLevelDiscount,
    this.browserPath,
    this.salePrice,
    this.purchasePrice,
    this.specialPriceCalculation,
    this.inclusiveTax,
    this.barCodeStatus,
    this.printStatus,
    this.includeSignatureStatus,
    this.helpDocument,
    this.sgstPercentage,
    this.cgstPercentage,
    this.disableItemGroup,
    this.cutomerMateriaBinding,
    this.showOnlyCustomerMaterialInSales,
    this.roundOffTaxTransaction,
    this.stockCheckRequired,
    this.itemLevelTaxPurchase,
    this.enableTally,
    this.allowReuse,
    this.allowPartyCode,
    this.allowEwayBill,
    this.allowEinvoiceWithEwayBill,
    this.enableEmailNotification,
    this.eInvPassword,
    this.eInvUserCode,
    this.aliasNameEnable,
    this.enablePosSolution,
    this.enableAutoPartNo,
    this.updateMaterialSpecFromTrans,
  });

  ApplicationSettingsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        deleted = json['deleted'] as String?,
        financialYearId = json['financialYearId'] as int?,
        stockIncreaseOnId = json['stockIncreaseOnId'] as int?,
        stockDecreaseOnId = json['stockDecreaseOnId'] as int?,
        itemLevelTax = json['itemLevelTax'] as int?,
        itemLevelDiscount = json['itemLevelDiscount'] as int?,
        browserPath = json['browserPath'],
        salePrice = json['salePrice'] as int?,
        purchasePrice = json['purchasePrice'] as int?,
        specialPriceCalculation = json['specialPriceCalculation'] as int?,
        inclusiveTax = json['inclusiveTax'] as int?,
        barCodeStatus = json['barCodeStatus'],
        printStatus = json['printStatus'],
        includeSignatureStatus = json['includeSignatureStatus'],
        helpDocument = json['helpDocument'],
        sgstPercentage = (json['sgstPercentage'] is String)
            ? double.tryParse(json['sgstPercentage']) // Try parsing if it's a string
            : json['sgstPercentage'] as double?,
        cgstPercentage = (json['cgstPercentage'] is String)
            ? double.tryParse(json['cgstPercentage']) // Try parsing if it's a string
            : json['cgstPercentage'] as double?,
        disableItemGroup = json['disableItemGroup'] as int?,
        cutomerMateriaBinding = json['cutomerMateriaBinding'] as int?,
        showOnlyCustomerMaterialInSales = json['showOnlyCustomerMaterialInSales'] as int?,
        roundOffTaxTransaction = json['roundOffTaxTransaction'] as int?,
        stockCheckRequired = json['stockCheckRequired'] as int?,
        itemLevelTaxPurchase = json['itemLevelTaxPurchase'] as int?,
        enableTally = json['enableTally'],
        allowReuse = json['allowReuse'],
        allowPartyCode = json['allowPartyCode'] as int?,
        allowEwayBill = json['allowEwayBill'] as int?,
        allowEinvoiceWithEwayBill = json['allowEinvoiceWithEwayBill'] as int?,
        enableEmailNotification = json['enableEmailNotification'],
        eInvPassword = json['eInvPassword'],
        eInvUserCode = json['eInvUserCode'],
        aliasNameEnable = json['aliasNameEnable'] as int?,
        enablePosSolution = json['enablePosSolution'] as int?,
        enableAutoPartNo = json['enableAutoPartNo'],
        updateMaterialSpecFromTrans = json['updateMaterialSpecFromTrans'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'deleted': deleted,
        'financialYearId': financialYearId,
        'stockIncreaseOnId': stockIncreaseOnId,
        'stockDecreaseOnId': stockDecreaseOnId,
        'itemLevelTax': itemLevelTax,
        'itemLevelDiscount': itemLevelDiscount,
        'browserPath': browserPath,
        'salePrice': salePrice,
        'purchasePrice': purchasePrice,
        'specialPriceCalculation': specialPriceCalculation,
        'inclusiveTax': inclusiveTax,
        'barCodeStatus': barCodeStatus,
        'printStatus': printStatus,
        'includeSignatureStatus': includeSignatureStatus,
        'helpDocument': helpDocument,
        'sgstPercentage': sgstPercentage,
        'cgstPercentage': cgstPercentage,
        'disableItemGroup': disableItemGroup,
        'cutomerMateriaBinding': cutomerMateriaBinding,
        'showOnlyCustomerMaterialInSales': showOnlyCustomerMaterialInSales,
        'roundOffTaxTransaction': roundOffTaxTransaction,
        'stockCheckRequired': stockCheckRequired,
        'itemLevelTaxPurchase': itemLevelTaxPurchase,
        'enableTally': enableTally,
        'allowReuse': allowReuse,
        'allowPartyCode': allowPartyCode,
        'allowEwayBill': allowEwayBill,
        'allowEinvoiceWithEwayBill': allowEinvoiceWithEwayBill,
        'enableEmailNotification': enableEmailNotification,
        'eInvPassword': eInvPassword,
        'eInvUserCode': eInvUserCode,
        'aliasNameEnable': aliasNameEnable,
        'enablePosSolution': enablePosSolution,
        'enableAutoPartNo': enableAutoPartNo,
        'updateMaterialSpecFromTrans': updateMaterialSpecFromTrans
      };
}
