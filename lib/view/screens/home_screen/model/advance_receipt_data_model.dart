class AdvanceReceiptDataModel {
  final String? month;
  final String? monthName;
  final int? count;
  final int? totalAmount;

  AdvanceReceiptDataModel({
    this.month,
    this.monthName,
    this.count,
    this.totalAmount,
  });

  AdvanceReceiptDataModel.fromJson(Map<String, dynamic> json)
      : month = json['month'] as String?,
        monthName = json['monthName'] as String?,
        count = json['count'] as int?,
        totalAmount = json['totalAmount'] as int?;

  Map<String, dynamic> toJson() => {'month': month, 'monthName': monthName, 'count': count, 'totalAmount': totalAmount};
}
