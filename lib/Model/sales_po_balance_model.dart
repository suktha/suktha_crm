class SalesPOBalanceModel {
  final String? poNumber;
  final String? purchaseOrderDate;
  final double? poQuantity;
  final double? price;
  final double? dcPendingQuantity;
  final double? invoicePendingQuantity;
  final String? dcNumber;
  final String? dcDate;
  final double? jwInDCInvoicePendingQuantity;
  final double? jwInDCQuantity;
  final double? jwInDCPendingQuantity;
  final dynamic jwInDCIncomingQuantity;
  final dynamic jwOutdcNumber;
  final dynamic jwOutdcDate;
  final dynamic jwOutDcInvoicePendingQuantity;
  final dynamic jwOutDcQuantity;
  final dynamic jwOutDCPendingQuantity;
  final dynamic jwOutDCIncomingQuantity;
  final String? partyName;
  final String? statusName;
  final String? materialName;
  final dynamic partNumber;
  final double? dcBalanceAmount;
  final double? invoiceBalanceAmount;
  final String? partyCode;
  final int? poTypeId;
  final String? poItemId;
  final dynamic dcTranType;
  final dynamic dcTransactionTypeId;
  final int? isOpenEnded;
  final dynamic inGrnBalance;
  final dynamic grnDcQuantity;
  final dynamic grnAcceptedQuantity;
  final dynamic rejectedQuantity;
  final dynamic grnNumber;
  final double? dcGrnBalanceQuantity;
  final String? dcstatusId;
  final dynamic internelRefNumber;

  SalesPOBalanceModel({
    this.poNumber,
    this.purchaseOrderDate,
    this.poQuantity,
    this.price,
    this.dcPendingQuantity,
    this.invoicePendingQuantity,
    this.dcNumber,
    this.dcDate,
    this.jwInDCInvoicePendingQuantity,
    this.jwInDCQuantity,
    this.jwInDCPendingQuantity,
    this.jwInDCIncomingQuantity,
    this.jwOutdcNumber,
    this.jwOutdcDate,
    this.jwOutDcInvoicePendingQuantity,
    this.jwOutDcQuantity,
    this.jwOutDCPendingQuantity,
    this.jwOutDCIncomingQuantity,
    this.partyName,
    this.statusName,
    this.materialName,
    this.partNumber,
    this.dcBalanceAmount,
    this.invoiceBalanceAmount,
    this.partyCode,
    this.poTypeId,
    this.poItemId,
    this.dcTranType,
    this.dcTransactionTypeId,
    this.isOpenEnded,
    this.inGrnBalance,
    this.grnDcQuantity,
    this.grnAcceptedQuantity,
    this.rejectedQuantity,
    this.grnNumber,
    this.dcGrnBalanceQuantity,
    this.dcstatusId,
    this.internelRefNumber,
  });

  SalesPOBalanceModel.fromJson(Map<String, dynamic> json)
    : poNumber = json['poNumber'] as String?,
      purchaseOrderDate = json['purchaseOrderDate'] as String?,
      poQuantity = json['poQuantity'] as double?,
      price = json['price'] as double?,
      dcPendingQuantity = json['dcPendingQuantity'] as double?,
      invoicePendingQuantity = json['invoicePendingQuantity'] as double?,
      dcNumber = json['dcNumber'] as String?,
      dcDate = json['dcDate'] as String?,
      jwInDCInvoicePendingQuantity = json['jwInDCInvoicePendingQuantity'] as double?,
      jwInDCQuantity = json['jwInDCQuantity'] as double?,
      jwInDCPendingQuantity = json['jwInDCPendingQuantity'] as double?,
      jwInDCIncomingQuantity = json['jwInDCIncomingQuantity'],
      jwOutdcNumber = json['jwOutdcNumber'],
      jwOutdcDate = json['jwOutdcDate'],
      jwOutDcInvoicePendingQuantity = json['jwOutDcInvoicePendingQuantity'],
      jwOutDcQuantity = json['jwOutDcQuantity'],
      jwOutDCPendingQuantity = json['jwOutDCPendingQuantity'],
      jwOutDCIncomingQuantity = json['jwOutDCIncomingQuantity'],
      partyName = json['partyName'] as String?,
      statusName = json['statusName'] as String?,
      materialName = json['materialName'] as String?,
      partNumber = json['partNumber'],
      dcBalanceAmount = json['dcBalanceAmount'] as double?,
      invoiceBalanceAmount = json['invoiceBalanceAmount'] as double?,
      partyCode = json['partyCode'] as String?,
      poTypeId = json['poTypeId'] as int?,
      poItemId = json['poItemId'] as String?,
      dcTranType = json['dcTranType'],
      dcTransactionTypeId = json['dcTransactionTypeId'],
      isOpenEnded = json['isOpenEnded'] as int?,
      inGrnBalance = json['inGrnBalance'],
      grnDcQuantity = json['grnDcQuantity'],
      grnAcceptedQuantity = json['grnAcceptedQuantity'],
      rejectedQuantity = json['rejectedQuantity'],
      grnNumber = json['grnNumber'],
      dcGrnBalanceQuantity = json['dcGrnBalanceQuantity'] as double?,
      dcstatusId = json['dcstatusId'] as String?,
      internelRefNumber = json['internelRefNumber'];

  Map<String, dynamic> toJson() => {
    'poNumber' : poNumber,
    'purchaseOrderDate' : purchaseOrderDate,
    'poQuantity' : poQuantity,
    'price' : price,
    'dcPendingQuantity' : dcPendingQuantity,
    'invoicePendingQuantity' : invoicePendingQuantity,
    'dcNumber' : dcNumber,
    'dcDate' : dcDate,
    'jwInDCInvoicePendingQuantity' : jwInDCInvoicePendingQuantity,
    'jwInDCQuantity' : jwInDCQuantity,
    'jwInDCPendingQuantity' : jwInDCPendingQuantity,
    'jwInDCIncomingQuantity' : jwInDCIncomingQuantity,
    'jwOutdcNumber' : jwOutdcNumber,
    'jwOutdcDate' : jwOutdcDate,
    'jwOutDcInvoicePendingQuantity' : jwOutDcInvoicePendingQuantity,
    'jwOutDcQuantity' : jwOutDcQuantity,
    'jwOutDCPendingQuantity' : jwOutDCPendingQuantity,
    'jwOutDCIncomingQuantity' : jwOutDCIncomingQuantity,
    'partyName' : partyName,
    'statusName' : statusName,
    'materialName' : materialName,
    'partNumber' : partNumber,
    'dcBalanceAmount' : dcBalanceAmount,
    'invoiceBalanceAmount' : invoiceBalanceAmount,
    'partyCode' : partyCode,
    'poTypeId' : poTypeId,
    'poItemId' : poItemId,
    'dcTranType' : dcTranType,
    'dcTransactionTypeId' : dcTransactionTypeId,
    'isOpenEnded' : isOpenEnded,
    'inGrnBalance' : inGrnBalance,
    'grnDcQuantity' : grnDcQuantity,
    'grnAcceptedQuantity' : grnAcceptedQuantity,
    'rejectedQuantity' : rejectedQuantity,
    'grnNumber' : grnNumber,
    'dcGrnBalanceQuantity' : dcGrnBalanceQuantity,
    'dcstatusId' : dcstatusId,
    'internelRefNumber' : internelRefNumber
  };
}