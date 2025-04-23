class DetailedDCModel {
  final String? id;
  final String? deliveryChallanNumber;
  final String? deliveryChallanDate;
  final String? partyName;
  final String? materialName;
  final String? remarks;
  final double? quantity;
  final String? uom;
  final String? hsnOrSac;
  final String? statusName;
  final String? partyCode;
  final dynamic partNumber;

  DetailedDCModel({
    this.id,
    this.deliveryChallanNumber,
    this.deliveryChallanDate,
    this.partyName,
    this.materialName,
    this.remarks,
    this.quantity,
    this.uom,
    this.hsnOrSac,
    this.statusName,
    this.partyCode,
    this.partNumber,
  });

  DetailedDCModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      deliveryChallanNumber = json['deliveryChallanNumber'] as String?,
      deliveryChallanDate = json['deliveryChallanDate'] as String?,
      partyName = json['partyName'] as String?,
      materialName = json['materialName'] as String?,
      remarks = json['remarks'] as String?,
      quantity = json['quantity'] as double?,
      uom = json['uom'] as String?,
      hsnOrSac = json['hsnOrSac'] as String?,
      statusName = json['statusName'] as String?,
      partyCode = json['partyCode'] as String?,
      partNumber = json['partNumber'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'deliveryChallanNumber' : deliveryChallanNumber,
    'deliveryChallanDate' : deliveryChallanDate,
    'partyName' : partyName,
    'materialName' : materialName,
    'remarks' : remarks,
    'quantity' : quantity,
    'uom' : uom,
    'hsnOrSac' : hsnOrSac,
    'statusName' : statusName,
    'partyCode' : partyCode,
    'partNumber' : partNumber
  };
}