class PrintTemplatesModel {
  final int? id;
  final dynamic createdDateTime;
  final dynamic createdBy;
  final dynamic updatedDateTime;
  final dynamic updatedBy;
  final String? deleted;
  final String? name;
  final int? isJasperPrint;
  final dynamic jasperFileName;

  PrintTemplatesModel({
    this.id,
    this.createdDateTime,
    this.createdBy,
    this.updatedDateTime,
    this.updatedBy,
    this.deleted,
    this.name,
    this.isJasperPrint,
    this.jasperFileName,
  });

  PrintTemplatesModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        createdDateTime = json['createdDateTime'],
        createdBy = json['createdBy'],
        updatedDateTime = json['updatedDateTime'],
        updatedBy = json['updatedBy'],
        deleted = json['deleted'] as String?,
        name = json['name'] as String?,
        isJasperPrint = json['isJasperPrint'] as int?,
        jasperFileName = json['jasperFileName'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdDateTime': createdDateTime,
        'createdBy': createdBy,
        'updatedDateTime': updatedDateTime,
        'updatedBy': updatedBy,
        'deleted': deleted,
        'name': name,
        'isJasperPrint': isJasperPrint,
        'jasperFileName': jasperFileName
      };
}
