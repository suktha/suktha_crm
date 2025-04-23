class PendingAmountModel {
  final double? dueAmount;
  final String? partyName;
  final int? partyId;

  PendingAmountModel({
    this.dueAmount,
    this.partyName,
    this.partyId,
  });

  PendingAmountModel.fromJson(Map<String, dynamic> json)
      : dueAmount = json['dueAmount'] as double?,
        partyName = json['partyName'] as String?,
        partyId = json['partyId'] as int?;

  Map<String, dynamic> toJson() => {'dueAmount': dueAmount, 'partyName': partyName, 'partyId': partyId};
}
