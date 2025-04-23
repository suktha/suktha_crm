class AccountsBlanceReportModel {
  final String? id;
  final String? invoiceNumber;
  final String? invoiceDate;
  final int? invoiceAmount;
  final int? paidAmount;
  final int? dueAmount;
  final String? partyName;
  final String? gstin;
  final String? statusName;
  final String? partyCode;

  AccountsBlanceReportModel({
    this.id,
    this.invoiceNumber,
    this.invoiceDate,
    this.invoiceAmount,
    this.paidAmount,
    this.dueAmount,
    this.partyName,
    this.gstin,
    this.statusName,
    this.partyCode,
  });

  AccountsBlanceReportModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      invoiceNumber = json['invoiceNumber'] as String?,
      invoiceDate = json['invoiceDate'] as String?,
      invoiceAmount = json['invoiceAmount'] as int?,
      paidAmount = json['paidAmount'] as int?,
      dueAmount = json['dueAmount'] as int?,
      partyName = json['partyName'] as String?,
      gstin = json['gstin'] as String?,
      statusName = json['statusName'] as String?,
      partyCode = json['partyCode'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'invoiceNumber' : invoiceNumber,
    'invoiceDate' : invoiceDate,
    'invoiceAmount' : invoiceAmount,
    'paidAmount' : paidAmount,
    'dueAmount' : dueAmount,
    'partyName' : partyName,
    'gstin' : gstin,
    'statusName' : statusName,
    'partyCode' : partyCode
  };
}

class PackageModel {
  final int subPackageId;
  final List<SubPackageItemModel> subPackageItems;

  PackageModel({
    required this.subPackageId,
    required this.subPackageItems,
  });

  PackageModel.fromJson(Map<String, dynamic> json)
      : subPackageId = json['sub_package_id'] as int,
        subPackageItems = (json['sub_package_items'] as List<dynamic>).map((item) => SubPackageItemModel.fromJson(item)).toList();

  Map<String, dynamic> toJson() => {
        'sub_package_id': subPackageId,
        'sub_package_items': subPackageItems.map((item) => item.toJson()).toList(),
      };
}

class SubPackageItemModel {
  final String? itemId;
  final String? itemName;
  final String? description;
  final String? image;
  final String? subPackageId;

  SubPackageItemModel({
    this.itemId,
    this.itemName,
    this.description,
    this.image,
    this.subPackageId,
  });

  SubPackageItemModel.fromJson(Map<String, dynamic> json)
      : itemId = json['item_id'] as String?,
        itemName = json['item_name'] as String?,
        description = json['description'] as String?,
        image = json['image'] as String?,
        subPackageId = json['sub_package_id'] as String?;

  Map<String, dynamic> toJson() =>
      {'item_id': itemId, 'item_name': itemName, 'description': description, 'image': image, 'sub_package_id': subPackageId};
}
