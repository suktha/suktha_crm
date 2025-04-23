class FinancialYearAllModel {
  final int? id;
  final String? startDate;
  final String? endDate;
  final String? financialYear;
  final int? isActive;
  final String? deleted;
  final dynamic isModified;

  FinancialYearAllModel({
    this.id,
    this.startDate,
    this.endDate,
    this.financialYear,
    this.isActive,
    this.deleted,
    this.isModified,
  });

  FinancialYearAllModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        startDate = json['startDate'] as String?,
        endDate = json['endDate'] as String?,
        financialYear = json['financialYear'] as String?,
        isActive = json['isActive'] as int?,
        deleted = json['deleted'] as String?,
        isModified = json['isModified'];

  Map<String, dynamic> toJson() => {'id': id, 'startDate': startDate, 'endDate': endDate, 'financialYear': financialYear, 'isActive': isActive, 'deleted': deleted, 'isModified': isModified};
}
