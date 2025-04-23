class TransactionNumberingModel {
  final int? id;
  final String? deleted;
  final int? transactionTypeId;
  final String? transactionTypeName;
  final String? prefix;
  final dynamic postfix;
  final int? startNumber;
  final int? autoNumber;
  final int? autoNumberReset;
  final dynamic termsAndConditionCheck;
  final String? delimiter;
  final int? financialYearCheck;
  final dynamic printTemplateId;
  final int? printTemplateTopSize;
  final dynamic isZeroPrefix;
  final dynamic isJasperPrint;
  final dynamic jasperFileName;
  final String? printHeaderText;
  final dynamic allowShipingAddress;

  TransactionNumberingModel({
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

  TransactionNumberingModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        deleted = json['deleted'] as String?,
        transactionTypeId = json['transactionTypeId'] as int?,
        transactionTypeName = json['transactionTypeName'] as String?,
        prefix = json['prefix'] as String?,
        postfix = json['postfix'],
        startNumber = json['startNumber'] as int?,
        autoNumber = json['autoNumber'] as int?,
        autoNumberReset = json['autoNumberReset'] as int?,
        termsAndConditionCheck = json['termsAndConditionCheck'],
        delimiter = json['delimiter'] as String?,
        financialYearCheck = json['financialYearCheck'] as int?,
        printTemplateId = json['printTemplateId'],
        printTemplateTopSize = json['printTemplateTopSize'] as int?,
        isZeroPrefix = json['isZeroPrefix'],
        isJasperPrint = json['isJasperPrint'],
        jasperFileName = json['jasperFileName'],
        printHeaderText = json['printHeaderText'] as String?,
        allowShipingAddress = json['allowShipingAddress'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'deleted': deleted,
        'transactionTypeId': transactionTypeId,
        'transactionTypeName': transactionTypeName,
        'prefix': prefix,
        'postfix': postfix,
        'startNumber': startNumber,
        'autoNumber': autoNumber,
        'autoNumberReset': autoNumberReset,
        'termsAndConditionCheck': termsAndConditionCheck,
        'delimiter': delimiter,
        'financialYearCheck': financialYearCheck,
        'printTemplateId': printTemplateId,
        'printTemplateTopSize': printTemplateTopSize,
        'isZeroPrefix': isZeroPrefix,
        'isJasperPrint': isJasperPrint,
        'jasperFileName': jasperFileName,
        'printHeaderText': printHeaderText,
        'allowShipingAddress': allowShipingAddress
      };
}
