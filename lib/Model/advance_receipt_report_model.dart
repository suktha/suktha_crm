class AdvanceReceiptReportModel {
  final String? id;
  final String? advanceReceiptNumber;
  final String? advanceReceiptDate;
  final double? advanceAmount;
  final double? totalBalanceAdvanceAmount;
  final String? partyName;
  final String? paymentMethodName;
  final int? financialYearId;
  final String? statusName;

  AdvanceReceiptReportModel({
    this.id,
    this.advanceReceiptNumber,
    this.advanceReceiptDate,
    this.advanceAmount,
    this.totalBalanceAdvanceAmount,
    this.partyName,
    this.paymentMethodName,
    this.financialYearId,
    this.statusName,
  });

  AdvanceReceiptReportModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      advanceReceiptNumber = json['advanceReceiptNumber'] as String?,
      advanceReceiptDate = json['advanceReceiptDate'] as String?,
      advanceAmount = json['advanceAmount'] as double?,
      totalBalanceAdvanceAmount = json['totalBalanceAdvanceAmount'] as double?,
      partyName = json['partyName'] as String?,
      paymentMethodName = json['paymentMethodName'] as String?,
      financialYearId = json['financialYearId'] as int?,
      statusName = json['statusName'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'advanceReceiptNumber' : advanceReceiptNumber,
    'advanceReceiptDate' : advanceReceiptDate,
    'advanceAmount' : advanceAmount,
    'totalBalanceAdvanceAmount' : totalBalanceAdvanceAmount,
    'partyName' : partyName,
    'paymentMethodName' : paymentMethodName,
    'financialYearId' : financialYearId,
    'statusName' : statusName
  };
}