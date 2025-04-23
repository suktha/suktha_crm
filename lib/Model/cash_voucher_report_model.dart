class CashVoucherReportModel {
  final String? id;
  final double? amount;
  final String? voucherNumber;
  final int? voucherId;
  final String? voucherDate;
  final int? voucherTypeId;
  final dynamic comments;
  final String? paidTo;
  final String? chequeNumber;
  final int? companyId;
  final int? financialYearId;
  final dynamic bankName;
  final dynamic chequeDate;
  final String? itemId;
  final dynamic description;
  final double? itemAmount;
  final int? expenseHeaderId;
  final String? expenseName;

  CashVoucherReportModel({
    this.id,
    this.amount,
    this.voucherNumber,
    this.voucherId,
    this.voucherDate,
    this.voucherTypeId,
    this.comments,
    this.paidTo,
    this.chequeNumber,
    this.companyId,
    this.financialYearId,
    this.bankName,
    this.chequeDate,
    this.itemId,
    this.description,
    this.itemAmount,
    this.expenseHeaderId,
    this.expenseName,
  });

  CashVoucherReportModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      amount = json['amount'] as double?,
      voucherNumber = json['voucherNumber'] as String?,
      voucherId = json['voucherId'] as int?,
      voucherDate = json['voucherDate'] as String?,
      voucherTypeId = json['voucherTypeId'] as int?,
      comments = json['comments'],
      paidTo = json['paidTo'] as String?,
      chequeNumber = json['chequeNumber'] as String?,
      companyId = json['companyId'] as int?,
      financialYearId = json['financialYearId'] as int?,
      bankName = json['bankName'],
      chequeDate = json['chequeDate'],
      itemId = json['itemId'] as String?,
      description = json['description'],
      itemAmount = json['itemAmount'] as double?,
      expenseHeaderId = json['expenseHeaderId'] as int?,
      expenseName = json['expenseName'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'amount' : amount,
    'voucherNumber' : voucherNumber,
    'voucherId' : voucherId,
    'voucherDate' : voucherDate,
    'voucherTypeId' : voucherTypeId,
    'comments' : comments,
    'paidTo' : paidTo,
    'chequeNumber' : chequeNumber,
    'companyId' : companyId,
    'financialYearId' : financialYearId,
    'bankName' : bankName,
    'chequeDate' : chequeDate,
    'itemId' : itemId,
    'description' : description,
    'itemAmount' : itemAmount,
    'expenseHeaderId' : expenseHeaderId,
    'expenseName' : expenseName
  };
}