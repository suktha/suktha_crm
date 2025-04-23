class DocumentWalletModel {
  final int? id;
  final String? name;
  final int? partyId;
  final String? fileURL;

  DocumentWalletModel({
    this.id,
    this.name,
    this.partyId,
    this.fileURL,
  });

  DocumentWalletModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        partyId = json['partyId'] as int?,
        fileURL = json['fileURL'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'partyId': partyId, 'fileURL': fileURL};
}
