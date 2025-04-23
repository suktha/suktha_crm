class SharedDocHistoryModel {
  final int? id;
  final String? leadGenId;
  final String? leadName;
  final String? createdDate;
  final String? documentName;
  final String? userName;

  SharedDocHistoryModel({
    this.id,
    this.leadGenId,
    this.leadName,
    this.createdDate,
    this.documentName,
    this.userName,
  });

  SharedDocHistoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        leadGenId = json['leadGenId'] as String?,
        leadName = json['leadName'] as String?,
        createdDate = json['createdDate'] as String?,
        documentName = json['documentName'] as String?,
        userName = json['userName'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'leadGenId': leadGenId,
        'leadName': leadName,
        'createdDate': createdDate,
        'documentName': documentName,
        'userName': userName
      };
}
