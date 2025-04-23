class EmployeeTrackerModel {
  final String? employeeName;
  final String? invoiceNumber;
  final String? materialName;
  final double? invoiceItemAmount;
  final String? invoiceDate;
  final double? commission;
  final int? employeeRating;
  final double? incentiveAmount;
  final double? balanceIncentiveAmount;

  EmployeeTrackerModel({
    this.employeeName,
    this.invoiceNumber,
    this.materialName,
    this.invoiceItemAmount,
    this.invoiceDate,
    this.commission,
    this.employeeRating,
    this.incentiveAmount,
    this.balanceIncentiveAmount,
  });

  EmployeeTrackerModel.fromJson(Map<String, dynamic> json)
      : employeeName = json['employeeName'] as String?,
        invoiceNumber = json['invoiceNumber'] as String?,
        materialName = json['materialName'] as String?,
        invoiceItemAmount = json['invoiceItemAmount'] as double?,
        invoiceDate = json['invoiceDate'] as String?,
        commission = json['commission'] as double?,
        employeeRating = json['employeeRating'] as int?,
        incentiveAmount = json['incentiveAmount'] as double?,
        balanceIncentiveAmount = json['balanceIncentiveAmount'] as double?;

  Map<String, dynamic> toJson() => {
        'employeeName': employeeName,
        'invoiceNumber': invoiceNumber,
        'materialName': materialName,
        'invoiceItemAmount': invoiceItemAmount,
        'invoiceDate': invoiceDate,
        'commission': commission,
        'employeeRating': employeeRating,
        'incentiveAmount': incentiveAmount,
        'balanceIncentiveAmount': balanceIncentiveAmount
      };
}
