// To parse this JSON data, do
//
//     final financialYearModel = financialYearModelFromJson(jsonString);

import 'dart:convert';

FinancialYearModel financialYearModelFromJson(String str) => FinancialYearModel.fromJson(json.decode(str));

String financialYearModelToJson(FinancialYearModel data) => json.encode(data.toJson());

class FinancialYearModel {
    FinancialYearModel({
        this.id,
        this.createdDateTime,
        this.createdBy,
        this.updatedDateTime,
        this.updatedBy,
        this.startDate,
        this.endDate,
        this.financialYear,
        this.isActive,
        this.deleted,
    });

    int? id;
    dynamic createdDateTime;
    dynamic createdBy;
    dynamic updatedDateTime;
    dynamic updatedBy;
    String? startDate;
    String? endDate;
    String? financialYear;
    int? isActive;
    String? deleted;

    factory FinancialYearModel.fromJson(Map<String, dynamic> json) => FinancialYearModel(
        id: json["id"],
        createdDateTime: json["createdDateTime"],
        createdBy: json["createdBy"],
        updatedDateTime: json["updatedDateTime"],
        updatedBy: json["updatedBy"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        financialYear: json["financialYear"],
        isActive: json["isActive"],
        deleted: json["deleted"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDateTime": createdDateTime,
        "createdBy": createdBy,
        "updatedDateTime": updatedDateTime,
        "updatedBy": updatedBy,
        "startDate": startDate,
        "endDate": endDate,
        "financialYear": financialYear,
        "isActive": isActive,
        "deleted": deleted,
    };
}
