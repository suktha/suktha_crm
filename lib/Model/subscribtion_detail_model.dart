class SubscriptionDetailsModel {
  final String? paymentId;
  final String? subscriptionId;
  final String? paymentDate;
  final String? startDate;
  final String? expiredate;
  final String? plandetails;
  final double? amountPaid;
  final String? status;
  final dynamic refundAmt;
  final dynamic subcriptionCancelledCharges;

  SubscriptionDetailsModel({
    this.paymentId,
    this.subscriptionId,
    this.paymentDate,
    this.startDate,
    this.expiredate,
    this.plandetails,
    this.amountPaid,
    this.status,
    this.refundAmt,
    this.subcriptionCancelledCharges,
  });

  SubscriptionDetailsModel.fromJson(Map<String, dynamic> json)
      : paymentId = json['paymentId'] as String?,
        subscriptionId = json['subscriptionId'] as String?,
        paymentDate = json['paymentDate'] as String?,
        startDate = json['startDate'] as String?,
        expiredate = json['expiredate'] as String?,
        plandetails = json['plandetails'] as String?,
        amountPaid = json['amountPaid'] as double?,
        status = json['status'] as String?,
        refundAmt = json['refundAmt'],
        subcriptionCancelledCharges = json['subcriptionCancelledCharges'];

  Map<String, dynamic> toJson() => {
        'paymentId': paymentId,
        'subscriptionId': subscriptionId,
        'paymentDate': paymentDate,
        'startDate': startDate,
        'expiredate': expiredate,
        'plandetails': plandetails,
        'amountPaid': amountPaid,
        'status': status,
        'refundAmt': refundAmt,
        'subcriptionCancelledCharges': subcriptionCancelledCharges
      };
}
