class RecentActivities {
  final String? transactionNumber;
  final String? transactionName;
  final double? transactionAmount;
  final String? transactionStatus;
  final String? transactionTypeName;
  final int? transactionTypeId;
  final String? transactionCreatedDAte;

  RecentActivities({
    this.transactionNumber,
    this.transactionName,
    this.transactionAmount,
    this.transactionTypeName,
    this.transactionStatus,
    this.transactionTypeId,
    this.transactionCreatedDAte,
  });

  RecentActivities.fromJson(Map<String, dynamic> json)
      : transactionTypeName = json['transactionTypeName'] as String?,
        transactionNumber = json['transactionNumber'] as String?,
        transactionName = json['transactionName'] as String?,
        transactionAmount = json['transactionAmount'] as double?,
        transactionStatus = json['transactionStatus'] as String?,
        transactionTypeId = json['transactionTypeId'] as int?,
        transactionCreatedDAte = json['transactionCreatedDAte'] as String?;

  Map<String, dynamic> toJson() => {
        'transactionNumber': transactionNumber,
        'transactionName': transactionName,
        'transactionAmount': transactionAmount,
        'transactionStatus': transactionStatus,
        'transactionTypeId': transactionTypeId,
        'transactionTypeName': transactionTypeName,
        'transactionCreatedDAte': transactionCreatedDAte
      };
}
