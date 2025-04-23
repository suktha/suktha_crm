class SettingsModel {
  final GlobalSetting? globalSetting;
  final List<NumberRangeConfigurations>? numberRangeConfigurations;
  final List<Taxes>? taxes;
  final List<UnitOfMeasurements>? unitOfMeasurements;
  final List<TermsAndConditions>? termsAndConditions;
  final dynamic roles;
  final List<PrintCopies>? printCopies;

  SettingsModel({
    this.globalSetting,
    this.numberRangeConfigurations,
    this.taxes,
    this.unitOfMeasurements,
    this.termsAndConditions,
    this.roles,
    this.printCopies,
  });

  SettingsModel.fromJson(Map<String, dynamic> json)
    : globalSetting = (json['globalSetting'] as Map<String,dynamic>?) != null ? GlobalSetting.fromJson(json['globalSetting'] as Map<String,dynamic>) : null,
      numberRangeConfigurations = (json['numberRangeConfigurations'] as List?)?.map((dynamic e) => NumberRangeConfigurations.fromJson(e as Map<String,dynamic>)).toList(),
      taxes = (json['taxes'] as List?)?.map((dynamic e) => Taxes.fromJson(e as Map<String,dynamic>)).toList(),
      unitOfMeasurements = (json['unitOfMeasurements'] as List?)?.map((dynamic e) => UnitOfMeasurements.fromJson(e as Map<String,dynamic>)).toList(),
      termsAndConditions = (json['termsAndConditions'] as List?)?.map((dynamic e) => TermsAndConditions.fromJson(e as Map<String,dynamic>)).toList(),
      roles = json['roles'],
      printCopies = (json['printCopies'] as List?)?.map((dynamic e) => PrintCopies.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'globalSetting' : globalSetting?.toJson(),
    'numberRangeConfigurations' : numberRangeConfigurations?.map((e) => e.toJson()).toList(),
    'taxes' : taxes?.map((e) => e.toJson()).toList(),
    'unitOfMeasurements' : unitOfMeasurements?.map((e) => e.toJson()).toList(),
    'termsAndConditions' : termsAndConditions?.map((e) => e.toJson()).toList(),
    'roles' : roles,
    'printCopies' : printCopies?.map((e) => e.toJson()).toList()
  };
}

class GlobalSetting {
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
  final dynamic sgstPercentage;
  final dynamic cgstPercentage;
  final int? disableItemGroup;
  final int? cutomerMateriaBinding;
  final int? showOnlyCustomerMaterialInSales;
  final int? roundOffTaxTransaction;
  final int? stockCheckRequired;
  final int? itemLevelTaxPurchase;
  final dynamic enableTally;
  final int? allowReuse;
  final int? allowPartyCode;
  final int? allowEwayBill;
  final int? allowEinvoiceWithEwayBill;
  final dynamic enableEmailNotification;
  final String? eInvPassword;
  final String? eInvUserCode;
  final int? aliasNameEnable;

  GlobalSetting({
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
  });

  GlobalSetting.fromJson(Map<String, dynamic> json)
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
      sgstPercentage = json['sgstPercentage'],
      cgstPercentage = json['cgstPercentage'],
      disableItemGroup = json['disableItemGroup'] as int?,
      cutomerMateriaBinding = json['cutomerMateriaBinding'] as int?,
      showOnlyCustomerMaterialInSales = json['showOnlyCustomerMaterialInSales'] as int?,
      roundOffTaxTransaction = json['roundOffTaxTransaction'] as int?,
      stockCheckRequired = json['stockCheckRequired'] as int?,
      itemLevelTaxPurchase = json['itemLevelTaxPurchase'] as int?,
      enableTally = json['enableTally'],
      allowReuse = json['allowReuse'] as int?,
      allowPartyCode = json['allowPartyCode'] as int?,
      allowEwayBill = json['allowEwayBill'] as int?,
      allowEinvoiceWithEwayBill = json['allowEinvoiceWithEwayBill'] as int?,
      enableEmailNotification = json['enableEmailNotification'],
      eInvPassword = json['eInvPassword'] as String?,
      eInvUserCode = json['eInvUserCode'] as String?,
      aliasNameEnable = json['aliasNameEnable'] as int?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'deleted' : deleted,
    'financialYearId' : financialYearId,
    'stockIncreaseOnId' : stockIncreaseOnId,
    'stockDecreaseOnId' : stockDecreaseOnId,
    'itemLevelTax' : itemLevelTax,
    'itemLevelDiscount' : itemLevelDiscount,
    'browserPath' : browserPath,
    'salePrice' : salePrice,
    'purchasePrice' : purchasePrice,
    'specialPriceCalculation' : specialPriceCalculation,
    'inclusiveTax' : inclusiveTax,
    'barCodeStatus' : barCodeStatus,
    'printStatus' : printStatus,
    'includeSignatureStatus' : includeSignatureStatus,
    'helpDocument' : helpDocument,
    'sgstPercentage' : sgstPercentage,
    'cgstPercentage' : cgstPercentage,
    'disableItemGroup' : disableItemGroup,
    'cutomerMateriaBinding' : cutomerMateriaBinding,
    'showOnlyCustomerMaterialInSales' : showOnlyCustomerMaterialInSales,
    'roundOffTaxTransaction' : roundOffTaxTransaction,
    'stockCheckRequired' : stockCheckRequired,
    'itemLevelTaxPurchase' : itemLevelTaxPurchase,
    'enableTally' : enableTally,
    'allowReuse' : allowReuse,
    'allowPartyCode' : allowPartyCode,
    'allowEwayBill' : allowEwayBill,
    'allowEinvoiceWithEwayBill' : allowEinvoiceWithEwayBill,
    'enableEmailNotification' : enableEmailNotification,
    'eInvPassword' : eInvPassword,
    'eInvUserCode' : eInvUserCode,
    'aliasNameEnable' : aliasNameEnable
  };
}

class NumberRangeConfigurations {
  final int? id;
  final String? deleted;
  final int? transactionTypeId;
  final String? transactionTypeName;
  final String? prefix;
  final String? postfix;
  final int? startNumber;
  final int? autoNumber;
  final int? autoNumberReset;
  final dynamic termsAndConditionCheck;
  final String? delimiter;
  final int? financialYearCheck;
  final int? printTemplateId;
  final int? printTemplateTopSize;
  final int? isZeroPrefix;
  final int? isJasperPrint;
  final String? jasperFileName;
  final String? printHeaderText;
  final int? allowShipingAddress;

  NumberRangeConfigurations({
    this.id,
    this.deleted,
    this.transactionTypeId,
    this.transactionTypeName,
    this.prefix,
    this.postfix,
    this.startNumber,
    this.autoNumber,
    this.autoNumberReset,
    this.termsAndConditionCheck,
    this.delimiter,
    this.financialYearCheck,
    this.printTemplateId,
    this.printTemplateTopSize,
    this.isZeroPrefix,
    this.isJasperPrint,
    this.jasperFileName,
    this.printHeaderText,
    this.allowShipingAddress,
  });

  NumberRangeConfigurations.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      deleted = json['deleted'] as String?,
      transactionTypeId = json['transactionTypeId'] as int?,
      transactionTypeName = json['transactionTypeName'] as String?,
      prefix = json['prefix'] as String?,
      postfix = json['postfix'] as String?,
      startNumber = json['startNumber'] as int?,
      autoNumber = json['autoNumber'] as int?,
      autoNumberReset = json['autoNumberReset'] as int?,
      termsAndConditionCheck = json['termsAndConditionCheck'],
      delimiter = json['delimiter'] as String?,
      financialYearCheck = json['financialYearCheck'] as int?,
      printTemplateId = json['printTemplateId'] as int?,
      printTemplateTopSize = json['printTemplateTopSize'] as int?,
      isZeroPrefix = json['isZeroPrefix'] as int?,
      isJasperPrint = json['isJasperPrint'] as int?,
      jasperFileName = json['jasperFileName'] as String?,
      printHeaderText = json['printHeaderText'] as String?,
      allowShipingAddress = json['allowShipingAddress'] as int?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'deleted' : deleted,
    'transactionTypeId' : transactionTypeId,
    'transactionTypeName' : transactionTypeName,
    'prefix' : prefix,
    'postfix' : postfix,
    'startNumber' : startNumber,
    'autoNumber' : autoNumber,
    'autoNumberReset' : autoNumberReset,
    'termsAndConditionCheck' : termsAndConditionCheck,
    'delimiter' : delimiter,
    'financialYearCheck' : financialYearCheck,
    'printTemplateId' : printTemplateId,
    'printTemplateTopSize' : printTemplateTopSize,
    'isZeroPrefix' : isZeroPrefix,
    'isJasperPrint' : isJasperPrint,
    'jasperFileName' : jasperFileName,
    'printHeaderText' : printHeaderText,
    'allowShipingAddress' : allowShipingAddress
  };
}

class Taxes {
  final int? id;
  final String? name;
  final double? rate;
  final String? deleted;
  final int? taxTypeId;

  Taxes({
    this.id,
    this.name,
    this.rate,
    this.deleted,
    this.taxTypeId,
  });

  Taxes.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = json['name'] as String?,
      rate = json['rate'] as double?,
      deleted = json['deleted'] as String?,
      taxTypeId = json['taxTypeId'] as int?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'rate' : rate,
    'deleted' : deleted,
    'taxTypeId' : taxTypeId
  };
}

class UnitOfMeasurements {
  final int? id;
  final dynamic createdDateTime;
  final dynamic createdBy;
  final String? updatedDateTime;
  final String? updatedBy;
  final String? deleted;
  final String? name;

  UnitOfMeasurements({
    this.id,
    this.createdDateTime,
    this.createdBy,
    this.updatedDateTime,
    this.updatedBy,
    this.deleted,
    this.name,
  });

  UnitOfMeasurements.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      createdDateTime = json['createdDateTime'],
      createdBy = json['createdBy'],
      updatedDateTime = json['updatedDateTime'] as String?,
      updatedBy = json['updatedBy'] as String?,
      deleted = json['deleted'] as String?,
      name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'createdDateTime' : createdDateTime,
    'createdBy' : createdBy,
    'updatedDateTime' : updatedDateTime,
    'updatedBy' : updatedBy,
    'deleted' : deleted,
    'name' : name
  };
}

class TermsAndConditions {
  final int? id;
  final String? name;
  final String? termsAndCondition;
  final dynamic paymentTerms;
  final dynamic deliveryTerms;
  final int? defaultTermsAndCondition;
  final int? transactionTypeId;
  final String? deleted;

  TermsAndConditions({
    this.id,
    this.name,
    this.termsAndCondition,
    this.paymentTerms,
    this.deliveryTerms,
    this.defaultTermsAndCondition,
    this.transactionTypeId,
    this.deleted,
  });

  TermsAndConditions.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = json['name'] as String?,
      termsAndCondition = json['termsAndCondition'] as String?,
      paymentTerms = json['paymentTerms'],
      deliveryTerms = json['deliveryTerms'],
      defaultTermsAndCondition = json['defaultTermsAndCondition'] as int?,
      transactionTypeId = json['transactionTypeId'] as int?,
      deleted = json['deleted'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'termsAndCondition' : termsAndCondition,
    'paymentTerms' : paymentTerms,
    'deliveryTerms' : deliveryTerms,
    'defaultTermsAndCondition' : defaultTermsAndCondition,
    'transactionTypeId' : transactionTypeId,
    'deleted' : deleted
  };
}

class PrintCopies {
  final int? id;
  final dynamic createdDateTime;
  final dynamic createdBy;
  final dynamic updatedDateTime;
  final dynamic updatedBy;
  final String? deleted;
  final String? name;

  PrintCopies({
    this.id,
    this.createdDateTime,
    this.createdBy,
    this.updatedDateTime,
    this.updatedBy,
    this.deleted,
    this.name,
  });

  PrintCopies.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      createdDateTime = json['createdDateTime'],
      createdBy = json['createdBy'],
      updatedDateTime = json['updatedDateTime'],
      updatedBy = json['updatedBy'],
      deleted = json['deleted'] as String?,
      name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'createdDateTime' : createdDateTime,
    'createdBy' : createdBy,
    'updatedDateTime' : updatedDateTime,
    'updatedBy' : updatedBy,
    'deleted' : deleted,
    'name' : name
  };
}