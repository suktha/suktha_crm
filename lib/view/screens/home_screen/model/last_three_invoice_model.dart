class LastThreeMonthInvoiceModel {
  final double? grandTotal;
  final double? dueAmount;
  final String? month;

  LastThreeMonthInvoiceModel({
    this.grandTotal,
    this.dueAmount,
    this.month,
  });

  LastThreeMonthInvoiceModel.fromJson(Map<String, dynamic> json)
      : grandTotal = json['grandTotal'] as double?,
        dueAmount = json['dueAmount'] as double?,
        month = json['month'] as String?;

  Map<String, dynamic> toJson() => {'grandTotal': grandTotal, 'dueAmount': dueAmount, 'month': month};
}
