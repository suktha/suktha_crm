class PartyServiceDetailsModel {
  final String? id;
  final String? invoiceDate;
  final String? invoiceNumber;
  final String? partyName;
  final String? serviceStartDate;
  final String? serviceEndDate;
  final double? price;
  final String? partyCode;
  final String? statusName;
  final String? serviceName;

  PartyServiceDetailsModel({
    this.id,
    this.invoiceDate,
    this.invoiceNumber,
    this.partyName,
    this.serviceStartDate,
    this.serviceEndDate,
    this.price,
    this.partyCode,
    this.statusName,
    this.serviceName,
  });

  PartyServiceDetailsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        invoiceDate = json['invoiceDate'] as String?,
        invoiceNumber = json['invoiceNumber'] as String?,
        partyName = json['partyName'] as String?,
        serviceStartDate = json['serviceStartDate'] as String?,
        serviceEndDate = json['serviceEndDate'] as String?,
        price = json['price'] as double?,
        partyCode = json['partyCode'] as String?,
        statusName = json['statusName'] as String?,
        serviceName = json['serviceName'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'invoiceDate': invoiceDate,
        'invoiceNumber': invoiceNumber,
        'partyName': partyName,
        'serviceStartDate': serviceStartDate,
        'serviceEndDate': serviceEndDate,
        'price': price,
        'partyCode': partyCode,
        'statusName': statusName,
        'serviceName': serviceName
      };
}
